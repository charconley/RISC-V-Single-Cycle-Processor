`timescale 1ns / 1ps

module ALU(A_in, B_in, ALU_ctrl, ALU_out, carry_out, zero, overflow);
    input wire [31:0] A_in;
    input wire [31:0] B_in;
    input wire [3:0] ALU_ctrl;
    output reg [31:0] ALU_out;
    output reg carry_out = 1'b0;
    output reg zero = 1'b0;
    output reg overflow = 1'b0;
    always @(*) begin
        if (ALU_ctrl == 4'b1111) begin //equals comparison
            if (A_in == B_in)
                ALU_out = 32'b1;
            else
                ALU_out = 32'b0;
        end
        else if (ALU_ctrl == 4'b1100) //Nor
            ALU_out = ~(A_in | B_in);
        else if (ALU_ctrl == 4'b0111) begin //set less than
            if ($signed(A_in) < $signed(B_in))
                ALU_out = 32'b1;
            else
                ALU_out = 32'b0;
        end
        else if (ALU_ctrl == 4'b0110) begin //signed subtraction
            ALU_out = $signed(A_in) - $signed(B_in);
            if ( ($signed(A_in) < 0 && $signed(B_in) > 0) && ALU_out[31] != 1)
                overflow = 1'b1;
            else if ( ($signed(A_in) > 0 && $signed(B_in) <0) && ALU_out[31] != 0)
                overflow = 1'b1;
            else
                overflow = 1'b0;
        end
        else if (ALU_ctrl == 4'b0000) //and
            ALU_out = A_in & B_in;
        else if (ALU_ctrl == 4'b0001) //or
            ALU_out = A_in | B_in;
        else begin  // add
            ALU_out = $signed(A_in) + $signed(B_in);
            if (($signed(A_in) > 0 && $signed(B_in) > 0 && $signed(ALU_out) < 0) || ($signed(A_in) < 0 && $signed(B_in) < 0 && $signed(ALU_out) > 0))
                overflow = 1'b1;
            else 
                overflow = 1'b0;
            if (ALU_out < A_in || ALU_out < B_in)
                carry_out = 1'b1;
            else 
                carry_out = 1'b0;
        end
        if (ALU_out == 32'b0)
            zero = 1'b1;
        else
            zero = 1'b0;
    end
endmodule

