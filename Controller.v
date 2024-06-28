
module Controller (
    Opcode, 
    ALUSrc, 
    MemtoReg, 
    RegWrite, 
    MemRead, 
    MemWrite, 
    ALUOp);

    input [6:0] Opcode;
    output MemtoReg;
    output MemWrite;
    output MemRead; 
    output ALUSrc; 
    output RegWrite;
    output [1:0] ALUOp;

    wire [6:0] R_TYPE, LW, SW, RTypeI;
    assign R_TYPE = 7'b0110011;
    assign LW = 7'b0000011;
    assign SW = 7'b0100011;
    assign RTypeI = 7'b0010011;

    assign ALUSrc = (Opcode == LW || Opcode == SW || Opcode == RTypeI);
    assign MemtoReg = (Opcode == LW);
    assign RegWrite = (Opcode == R_TYPE || Opcode == LW || Opcode == RTypeI);
    assign MemRead = (Opcode == LW);
    assign MemWrite = (Opcode == SW);

    assign ALUOp = (Opcode == R_TYPE) ? 2'b10: (Opcode == RTypeI) ? 2'b00: 2'b01;        
    
endmodule

    