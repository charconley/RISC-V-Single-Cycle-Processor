`timescale 1ns / 1ps

module RegFile(clk, reset, rg_wrt_en, rg_wrt_addr, rg_rd_addr1, rg_rd_addr2, rg_wrt_data, rg_rd_data1, rg_rd_data2);
    input clk, reset;
    input rg_wrt_en;
    input wire [4:0] rg_rd_addr1; 
    input wire [4:0] rg_rd_addr2;
    input wire [4:0] rg_wrt_addr;
    input wire [31:0] rg_wrt_data;
    output wire [31:0] rg_rd_data1;
    output wire [31:0] rg_rd_data2;
    reg [31:0] register [31:0];

    assign rg_rd_data1 = register[rg_rd_addr1];
    assign rg_rd_data2 = register[rg_rd_addr2];

    always @(posedge clk, reset)
    begin
        if (reset == 1'b1)
        begin
            for (integer i = 0; i < 32; i = i + 1)
            begin
                register[i] = 32'b0;
            end
        end

        if (rg_wrt_en == 1'b1 && reset == 1'b0)
            register[rg_wrt_addr] = rg_wrt_data;
    end
    
endmodule