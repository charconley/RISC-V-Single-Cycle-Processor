`timescale 1ns / 1ps

module InstMem(input [7:0] addr, output wire [31:0] instruction);
    reg [31:0] memory [63:0];
    assign instruction = memory[addr >> 2];
    initial 
    begin
        memory[0] = 32'h00007033;
        memory[1] = 32'h00100093;
        memory[2] = 32'h00200113;
        memory[3] = 32'h00308193;
        memory[4] = 32'h00408213;
        memory[5] = 32'h00510293;
        memory[6] = 32'h00610313;
        memory[7] = 32'h00718393;
        memory[8] = 32'h00208433;
        memory[9] = 32'h404404b3;
        memory[10] = 32'h00317533;
        memory[11] = 32'h0041e5b3;
        memory[12] = 32'h0041a633;
        memory[13] = 32'h007346b3;
        memory[14] = 32'h4d34f713;
        memory[15] = 32'h8d35e793;
        memory[16] = 32'h4d26a813;
        memory[17] = 32'h4d244893;
        memory[18] = 32'h02b02823;
        memory[19] = 32'h03002603;
    end
endmodule