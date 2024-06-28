module data_path #(
        parameter PC_W = 8,
        parameter INS_W = 32,
        parameter RF_ADDRESS = 5,
        parameter DATA_W = 32,
        parameter DM_ADDRESS = 9,
        parameter ALU_CC_W = 4
    )(
        input clk,
        input reset,
        input reg_write,
        input mem2reg,
        input alu_src,
        input mem_write,
        input mem_read,
        input [ALU_CC_W-1:0] alu_cc,
        output [6:0] opcode,
        output [6:0] funct7,
        output [2:0] funct3,
        output [DATA_W-1:0] alu_result
    );

    wire [PC_W-1:0] PCPlus4;
    wire [PC_W-1:0] PC;
    wire [INS_W-1:0] Instruction;
    wire [DATA_W-1:0] Reg1;
    wire [DATA_W-1:0] Reg2;
    wire [DATA_W-1:0] ExtImm;
    wire [DATA_W-1:0] SreB;
    wire [DATA_W-1:0] ALU_Result1;
    wire [DM_ADDRESS-1:0] add;
    wire [DATA_W-1:0] DataMem_read;
    wire [31:0] WriteBack_Data;
    wire [4:0] rd_rg_wrt_wire;
    wire [4:0] rd_rg_addr_wire1;
    wire [4:0] rd_rg_addr_wire2;
    
    FlipFlop F0
        (
            .clk(clk),
            .reset(reset),
            .d(PCPlus4),
            .q(PC)
        );

    assign PCPlus4 = PC + 4;


    InstMem M0
        (
            .addr(PC),
            .instruction(Instruction)
        );
    
    assign rd_rg_wrt_wire = Instruction[11:7];
    assign rd_rg_addr_wire1 = Instruction[19:15];
    assign rd_rg_addr_wire2 = Instruction[24:20];

    assign opcode = Instruction[6:0];
    assign funct3 = Instruction[14:12];
    assign funct7 = Instruction[31:25];

    RegFile R0 
        (
            .clk(clk),
            .reset(reset),
            .rg_wrt_en(reg_write),
            .rg_rd_addr1(rd_rg_addr_wire1),
            .rg_rd_addr2(rd_rg_addr_wire2),
            .rg_wrt_addr(rd_rg_wrt_wire),
            .rg_wrt_data(WriteBack_Data),
            .rg_rd_data1(Reg1),
            .rg_rd_data2(Reg2)
        );

    ImmGen IG0
        (
            .InstCode(Instruction),
            .ImmOut(ExtImm)
        );

    mux21 MU0 
        (
            .A_in(Reg2),
            .B_in(ExtImm),
            .Sel(alu_src),
            .out(SreB)
        );

    ALU_32 A0 
        (
            .A_in(Reg1),
            .B_in(SreB),
            .ALU_Sel(alu_cc),
            .ALU_Out(ALU_Result1)
        );

    assign add = ALU_Result1[DM_ADDRESS-1:0];

    DataMem DM0 
        (
            .MemRead(mem_read),
            .MemWrite(mem_write),
            .addr(add),
            .write_data(Reg2),
            .read_data(DataMem_read)
        );

    mux21 M1
        (
            .A_in(ALU_Result1),
            .B_in(DataMem_read),
            .Sel(mem2reg),
            .out(WriteBack_Data)
        );
    assign alu_result = ALU_Result1;

endmodule
