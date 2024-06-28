`timescale 1ns / 1ps

module mux21(
            input [31:0] A_in, 
            input [31:0] B_in, 
            input Sel, 
            output [31:0] out
            );

   //assign out = (A_in & ~(Sel)) | (B_in & Sel);
   assign out = Sel ? B_in : A_in;

endmodule