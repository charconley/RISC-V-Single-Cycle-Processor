`timescale 1ns / 1ps

module FlipFlop(clk, reset, d, q);
    input clk;
    input reset;
    input wire [7:0] d;
    output reg [7:0] q;

    always @(posedge clk) 
    begin
        if (reset == 1'b1)
            q <= 8'b0;
        else
            q <= d;
    end
endmodule