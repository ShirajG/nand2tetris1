class JackTokenizer
  # Parses source text into discrete tokens
  @@symbols = %w({ } ( ) [ ] . , ; + - * / & | < > = ~)
  @@token_types = {
    keyword: "keyword", symbol: "symbol", identifier: "identifier",
    int: "integerConstant", str: "stringConstant" }

  attr_reader :tokens, :filename

  def initialize(file)
    @tokens = []
    @xml = ""
    @filename = file.gsub('.jack','')
    @file = File.read(file)
      .gsub(/\/\/.+$/,"") # remove // comments
      .strip

    within_quote = false
    within_comment = false
    current_string = ""
    file_length = @file.length
    @file.each_char.with_index do |char, i|
      # Keep track of when we are in a multi line comment. Ignore text.
      if char == '/' && @file[i+1] == '*'
        within_comment = true
      end

      if within_quote
        current_string += char;
      elsif within_comment
        # End comment when we hit '*/'
        if char == '/' && @file[i - 1] == '*'
          within_comment = false
        end
        next
      else
        if ["\r", "\n", " "].include? char
          current_string.strip!
          tokenize!(current_string) unless current_string == ""
          current_string = ""
        else
          current_string += char
          if file_length == i + 1
            tokenize! current_string
          end
        end
      end

      if char == '"'
        within_quote = !within_quote
      end
    end
    output_xml
  end

  def output_xml
    @xml << "<tokens>\n"
    @tokens.each do |token|
        token[:value].gsub!('"', '')
        @xml << "<#{token[:type]}> #{token[:value]} </#{token[:type]}>\n"
    end
    @xml << "</tokens>"

    File.open(@filename + '_T.xml', 'w') do |outfile|
      outfile << @xml
    end
  end

  def tokenize!(token_str)
    token = nil;
    if @@symbols.include?(token_str)
      token = {
        type: @@token_types[:symbol],
        value: token_str
      }
    elsif %w(class constructor function method field static var int char boolean void true false null this let do if else while return).include?(token_str)
      token = {
        type: @@token_types[:keyword],
        value: token_str
      }
    elsif /^\".+\"$/.match token_str
      token = {
        type: @@token_types[:str],
        value: token_str
      }
    else
      if contains_symbols(token_str)
        if (%w(, ;).include? token_str[-1])
          tokenize!(token_str[0..-2])
          tokenize!(token_str[-1])
        elsif token_str[0] == '.'
          tokenize!(token_str[0])
          tokenize!(token_str[1..-1])
        else
          if(/\..+\(.*\)$/.match(token_str))
            dot_position = token_str.index('.')
            token1 = token_str[0...dot_position]
            rest = token_str[dot_position..-1]
            tokenize!(token1)
            tokenize!(rest)
          elsif(/\(\)$/.match(token_str))
            tokenize!(token_str[0..-3])
            tokenize!(token_str[-2])
            tokenize!(token_str[-1])
          elsif(/^\(.*\)$/.match(token_str))
            tokenize!(token_str[0])
            tokenize!(token_str[1..-2])
            tokenize!(token_str[-1])
          elsif(/\[.*\]$/.match(token_str))
            left_bracket_position = token_str.index('[')
            tokenize!(token_str[0...left_bracket_position])
            tokenize!(token_str[(left_bracket_position)...-1])
            tokenize!(token_str[-1])
          elsif(@@symbols.include?(token_str[0]))
            tokenize!(token_str[0])
            tokenize!(token_str[1..-1])
          elsif(@@symbols.include?(token_str[-1]))
            tokenize!(token_str[0...-1])
            tokenize!(token_str[-1])
          elsif(token_str.index('.'))
            dot_position = token_str.index('.')
            tokenize! token_str[0...dot_position]
            tokenize! token_str[dot_position..-1]
          elsif(token_str.index('('))
            paren_position = token_str.index('(')
            tokenize! token_str[0...paren_position]
            tokenize! token_str[paren_position]
            tokenize! token_str[paren_position+1..-1]
          # elsif(token_str.index(','))
          #   comma_pos = token_str.index(',')
          #   tokenize! token_str[0...comma_pos]
          #   tokenize! token_str[comma_pos+1..-1]
          elsif(token_str.index '/' )
            matches = /(.+)\/(.+)/.match(token_str)
            tokenize! matches[1]
            tokenize! '/'
            tokenize! matches[2]
          elsif(token_str.index '[')
            brack_pos = token_str.index('[')
            tokenize! token_str[0...brack_pos]
            tokenize! token_str[brack_pos..-1]
          else
             puts "UNHANDLED!: #{token_str} "
          end
        end
      else
        if is_number?(token_str)
          token = {
            type: @@token_types[:int],
            value: token_str
          }
        else
          token = {
            type: @@token_types[:identifier],
            value: token_str
          }
        end
      end
    end

    @tokens << token unless token.nil? || token[:value] == ''
  end

  def contains_symbols(token_str)
    !(token_str.split('') & @@symbols).empty?
  end

  def is_number?(obj)
    obj.to_f.to_s == obj.to_s || obj.to_i.to_s == obj.to_s
  end
end
