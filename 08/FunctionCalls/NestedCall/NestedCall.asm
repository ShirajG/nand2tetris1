// FunctionCalls/NestedCall/NestedCall.asm.asm
(Sys.init)
// push constant 4000
@4000
D=A;
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 0
@SP
M=M-1
@SP
A=M
D=M
@R13
M=D
@3
D=A
@0
D=D+A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
// push constant 5000
@5000
D=A;
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 1
@SP
M=M-1
@SP
A=M
D=M
@R13
M=D
@3
D=A
@1
D=D+A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
// call Sys.main 0
@ReturnAddress0
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
D=M
D=D-1
D=D-1
D=D-1
D=D-1
D=D-1
@ARG
M=D
@SP
D=M
@LCL
M=D
@Sys.main
0;JMP
(ReturnAddress0)
// pop temp 1
@SP
M=M-1
@SP
A=M
D=M
@R13
M=D
@5
D=A
@1
D=D+A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
// Label
(LOOP)

// Goto LOOP
@LOOP
0;JMP
(Sys.main)
// push constant 0
@0
D=A;
@SP
A=M
M=D
@SP
M=M+1
// push constant 0
@0
D=A;
@SP
A=M
M=D
@SP
M=M+1
// push constant 0
@0
D=A;
@SP
A=M
M=D
@SP
M=M+1
// push constant 0
@0
D=A;
@SP
A=M
M=D
@SP
M=M+1
// push constant 0
@0
D=A;
@SP
A=M
M=D
@SP
M=M+1
// push constant 4001
@4001
D=A;
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 0
@SP
M=M-1
@SP
A=M
D=M
@R13
M=D
@3
D=A
@0
D=D+A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
// push constant 5001
@5001
D=A;
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 1
@SP
M=M-1
@SP
A=M
D=M
@R13
M=D
@3
D=A
@1
D=D+A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
// push constant 200
@200
D=A;
@SP
A=M
M=D
@SP
M=M+1
// pop local 1
@SP
M=M-1
@SP
A=M
D=M
@R13
M=D
@LCL
D=M
@1
D=D+A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
// push constant 40
@40
D=A;
@SP
A=M
M=D
@SP
M=M+1
// pop local 2
@SP
M=M-1
@SP
A=M
D=M
@R13
M=D
@LCL
D=M
@2
D=D+A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
// push constant 6
@6
D=A;
@SP
A=M
M=D
@SP
M=M+1
// pop local 3
@SP
M=M-1
@SP
A=M
D=M
@R13
M=D
@LCL
D=M
@3
D=D+A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
// push constant 123
@123
D=A;
@SP
A=M
M=D
@SP
M=M+1
// call Sys.add12 1
@ReturnAddress1
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
D=M
D=D-1
D=D-1
D=D-1
D=D-1
D=D-1
D=D-1
@ARG
M=D
@SP
D=M
@LCL
M=D
@Sys.add12
0;JMP
(ReturnAddress1)
// pop temp 0
@SP
M=M-1
@SP
A=M
D=M
@R13
M=D
@5
D=A
@0
D=D+A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
// push local 0
@LCL
D=M
@0
D=D+A
A=D
D=M
@SP
A=M
M=D
@SP
M=M+1
// push local 1
@LCL
D=M
@1
D=D+A
A=D
D=M
@SP
A=M
M=D
@SP
M=M+1
// push local 2
@LCL
D=M
@2
D=D+A
A=D
D=M
@SP
A=M
M=D
@SP
M=M+1
// push local 3
@LCL
D=M
@3
D=D+A
A=D
D=M
@SP
A=M
M=D
@SP
M=M+1
// push local 4
@LCL
D=M
@4
D=D+A
A=D
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP
M=M-1
//Add
@SP
A=M;
D=M;
A=A-1;
D=D+M;
M=D;
@SP
M=M-1
//Add
@SP
A=M;
D=M;
A=A-1;
D=D+M;
M=D;
@SP
M=M-1
//Add
@SP
A=M;
D=M;
A=A-1;
D=D+M;
M=D;
@SP
M=M-1
//Add
@SP
A=M;
D=M;
A=A-1;
D=D+M;
M=D;
// return
@LCL
D=M
@R7
M=D
@R6
M=D
M=M-1
M=M-1
M=M-1
M=M-1
M=M-1
A=M
D=M
@R6
M=D
@SP
M=M-1
A=M
D=M
@ARG
A=M
M=D
@ARG
D=M
@SP
M=D+1
@R7
D=M
D=D-1
A=D
D=M
@THAT
M=D
@R7
D=M
D=D-1
D=D-1
A=D
D=M
@THIS
M=D
@R7
D=M
D=D-1
D=D-1
D=D-1
A=D
D=M
@ARG
M=D
@R7
D=M
D=D-1
D=D-1
D=D-1
D=D-1
A=D
D=M
@LCL
M=D
@R6
A=M
0;JMP
(Sys.add12)
// push constant 4002
@4002
D=A;
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 0
@SP
M=M-1
@SP
A=M
D=M
@R13
M=D
@3
D=A
@0
D=D+A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
// push constant 5002
@5002
D=A;
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 1
@SP
M=M-1
@SP
A=M
D=M
@R13
M=D
@3
D=A
@1
D=D+A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
// push argument 0
@ARG
D=M
@0
D=D+A
A=D
D=M
@SP
A=M
M=D
@SP
M=M+1
// push constant 12
@12
D=A;
@SP
A=M
M=D
@SP
M=M+1
@SP
M=M-1
//Add
@SP
A=M;
D=M;
A=A-1;
D=D+M;
M=D;
// return
@LCL
D=M
@R7
M=D
@R6
M=D
M=M-1
M=M-1
M=M-1
M=M-1
M=M-1
A=M
D=M
@R6
M=D
@SP
M=M-1
A=M
D=M
@ARG
A=M
M=D
@ARG
D=M
@SP
M=D+1
@R7
D=M
D=D-1
A=D
D=M
@THAT
M=D
@R7
D=M
D=D-1
D=D-1
A=D
D=M
@THIS
M=D
@R7
D=M
D=D-1
D=D-1
D=D-1
A=D
D=M
@ARG
M=D
@R7
D=M
D=D-1
D=D-1
D=D-1
D=D-1
A=D
D=M
@LCL
M=D
@R6
A=M
0;JMP