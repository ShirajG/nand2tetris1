require 'byebug'

module Parser
  @@file = []
  @@parsed_file = []
  @@current_line = nil
  @@command_types = {
    'add': 'C_ARITHMETIC',
    'sub': 'C_ARITHMETIC',
    'neg': 'C_ARITHMETIC',
    'eq': 'C_ARITHMETIC',
    'gt': 'C_ARITHMETIC',
    'lt': 'C_ARITHMETIC',
    'and': 'C_ARITHMETIC',
    'or': 'C_ARITHMETIC',
    'not': 'C_ARITHMETIC',
    'push': 'C_PUSH',
    'pop': 'C_POP',
    'label': 'C_LABEL',
    'goto': 'C_GOTO ',
    'if': 'C_IF',
    'function': 'C_FUNCTION',
    'return': 'C_RETURN',
    'call': 'C_CALL'
  }

  def self.file
    @@file
  end

  def self.parsed_file
    @@parsed_file
  end

  def self.current_line
    @@file[@@current_line]
  end

  def self.has_more_commands
    if @@current_line.nil?
      @@file[0]
    else
      @@file[@@current_line+1]
    end
  end

  def self.advance
    if @@current_line.nil?
      @@current_line = 0
    else
      @@current_line += 1
    end
  end

  def self.command_type
    c_type = @@command_types[current_line.split(' ')[0].to_sym]
    if c_type == 'C_ARITHMETIC'
      return current_line.split(' ')[0]
    end
    c_type
  end

  def self.init
    File.open(ARGV[0], 'r').each_line do |line|
      @@file << line.gsub(/\/\/.*$/,'').strip
    end
    @@file = @@file.compact.reject{|line| line==""}
  end

  def self.parse
    while has_more_commands
      advance
      @@parsed_file[@@current_line] = {
        command_type: command_type,
        arg1: current_line.split(' ')[1],
        arg2: current_line.split(' ')[2],
      }
    end
  end
end

module Encoder
  @@out_file = nil

  def self.init
    @@out_file = File.open(set_file_name, 'w')
  end

  def self.close
    @@out_file.close
  end

  def self.file
    @@out_file
  end

  def self.set_file_name
    ARGV[0][0..ARGV[0].rindex('.')] + 'asm'
  end

  def self.write_arithmetic(command)
    @@out_file << self.send(command).join("\n") << "\n"
  end

  def self.write_push_pop(command, segment, index)
    case command
    when 'C_PUSH'
      @@out_file << push_code(segment, index).join("\n") << "\n"
    else
      @@out_file << pop_code(segment, index).join("\n") << "\n"
    end
  end

  def self.increment_sp
    ["@SP","M=M+1;"]
  end

  def self.decrement_sp
    ["@SP","M=M-1;"]
  end

  def self.push_code(segment, index)
      [
        "// push #{segment} #{index}",
        "#{self.segment_address(segment, index)}",
        "@SP",
        "A=M",
        "M=D"
      ] + increment_sp
  end

  def self.pop_code(segment, index)
      [ "// pop #{segment} #{index}" ] +
      decrement_sp + [
        # Store Value to Pop in R5
        "@SP",
        "A=M",
        "D=M",
        "@R5",
        "M=D",
        # Calculate memory address to write to in R6
        "#{segment}",
        "D=M",
        "@#{index}",
        "D=D+A",
        "@R6",
        "M=D",
        # Store Value in R5 at Memory Address in R6
        "@R5",
        "D=M",
        "@R6",
        "A=M",
        "M=D"
      ]
  end

  def self.segment_address(segment, index)
    case segment
    when 'local'
      "@LCL"
    when 'argument'
      "@ARG"
    when 'this'
      "@THIS"
    when 'that'
      "@THAT"
    when 'pointer'
      "@THIS"
    when 'temp'
      "@R5"
    when 'constant'
      "@#{index}\nD=A;"
    when 'static'
      "@#{ARGV[0][0..ARGV[0].rindex('.')] + index}\nD=M"
    end
  end

  def self.add
    self.decrement_sp + %w(
      //Add
      @SP
      A=M;
      D=M;
      A=A-1;
      D=D+M;
      M=D;
    )
  end

  def self.sub
    self.decrement_sp + %w(
      //Sub
      @SP
      A=M;
      D=M;
      A=A-1;
      D=M-D;
      M=D;
    )
  end

  def self.neg
    self.decrement_sp + %w(
      //Neg
      @SP
      A=M;
      M=-M;
    ) + self.increment_sp
  end

  def self.and
    self.decrement_sp + %w(
      //And
      @SP
      A=M;
      D=M;
      A=A-1;
      D=M&D;
      M=D;
    )
  end

  def self.or
    self.decrement_sp + %w(
      //Or
      @SP
      A=M;
      D=M;
      A=A-1;
      D=M|D;
      M=D;
    )
  end

  def self.not
    self.decrement_sp + %w(
      //Not
      @SP
      A=M;
      M=!M;
    ) + self.increment_sp
  end

  def self.eq
  # Check equality by subtracting the 2 values?
  end

  def self.gt

  end

  def self.lt

  end
end

Parser.init
Parser.parse
puts Parser.parsed_file
Encoder.init

Parser.parsed_file.each do |parsed_line|
  case parsed_line[:command_type]
  when 'C_PUSH'
    Encoder.write_push_pop(
      parsed_line[:command_type],
      parsed_line[:arg1],
      parsed_line[:arg2]
    )
  when 'C_POP'
    Encoder.write_push_pop(
      parsed_line[:command_type],
      parsed_line[:arg1],
      parsed_line[:arg2]
    )
  else
    Encoder.write_arithmetic(parsed_line[:command_type])
  end
end

Encoder.close
