`timescale 1 ns / 1 ps
module processor(
    input clk, reset,
    output [31:0] Result
);
    wire [6:0] opcode, Funct7;
    wire MemtoReg;
    wire MemWrite;
    wire MemRead;
    wire ALUSrc;
    wire RegWrite;
    wire [1:0] ALUOp;
    wire [2:0] Funct3;
    wire [3:0] Operation;

    data_path D0
        (
            .clk(clk),
            .reset(reset),
            .reg_write(RegWrite),
            .mem2reg(MemtoReg),
            .alu_src(ALUSrc),
            .mem_write(MemWrite),
            .mem_read(MemRead),
            .alu_cc(Operation),
            .opcode(opcode),
            .funct7(Funct7),
            .funct3(Funct3),
            .alu_result(Result)
        );

    ALUController A0
        (
            .ALUOp(ALUOp),
            .Funct7(Funct7),
            .Funct3(Funct3),
            .Operation(Operation)
        );

    Controller C0
        (
            .Opcode(opcode), 
            .ALUSrc(ALUSrc), 
            .MemtoReg(MemtoReg), 
            .RegWrite(RegWrite), 
            .MemRead(MemRead), 
            .MemWrite(MemWrite), 
            .ALUOp(ALUOp)
        );

endmodule