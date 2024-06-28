`timescale 1ns / 1ps

module DataMem(MemRead, MemWrite, addr, write_data, read_data);
    input MemRead;
    input MemWrite;
    input wire [8:0] addr;
    input wire [31:0] write_data;
    output reg [31:0] read_data;
    reg [31:0] memory [127:0]; 

    always @(MemRead, MemWrite, addr, write_data) begin
        if (MemWrite == 1'b1)
            memory[addr >> 2] = write_data;
        if (MemRead == 1'b1)
            read_data = memory[addr >> 2];
        else if (MemRead == 1'b0)
            read_data = 32'b0;
    end
endmodule
