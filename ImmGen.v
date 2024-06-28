`timescale 1ns / 1ps

module ImmGen(InstCode, ImmOut);
    input [31:0] InstCode;
    output reg [31:0] ImmOut;

    always @(InstCode)
    begin
        case (InstCode[6:0])
        
            7'b0000011:
            begin
                ImmOut = {InstCode[31]? {20{1'b1}}:20'b0, InstCode[31:20]};
            end
            7'b0010011:
            begin
                ImmOut = {InstCode[31]? {20{1'b1}}:20'b0, InstCode[31:20]};
            end 
            7'b0100011:
            begin
                ImmOut = {InstCode[31]? {20{1'b1}}:20'b0, InstCode[31:25], InstCode[11:7]};
            end  
            7'b0010111:
            begin
                ImmOut = {InstCode[31:12], 12'b0};
            end
            default:
            begin
                ImmOut = {32'b0};
            end
        endcase
    end
endmodule