module RISC_V #(
    parameter WIDTH = 32
)
(
    input clk, areset
);
wire [WIDTH-1: 0] PCNext,A, PC, Instr, SrcA,SrcB, ALUResult, ReadData, WriteData, ImmExt, Result;
wire Zero, Sign, PCSrc, ResultSrc, MemWrite, ALUSrc, RegWrite;
wire [2:0] ALUControl;
wire [1:0] ImmSrc;

    /* Program Ccounter */
    PC_NEXT P0 (
        .PCSrc(PCSrc),
        .ImmExt(ImmExt), 
        .PC(PC), 
        .PCNext(PCNext)
        );

    PC   P1 (
        .PCNext(PCNext), 
        .clk(clk), 
        .areset(areset), 
        .load(1'b1), 
        .PC(PC)
        );

    /* Instruction Memory */
    inst_mem m0 (
        .A(PC), 
        .Instr(Instr)
        );

    /* Register File */ 
    reg_file R0 (
        .WD3(Result), 
        .A1(Instr[19:15]), 
        .A2(Instr[24:20]), 
        .A3(Instr[11:7]), 
        .clk(clk), 
        .areset(areset), 
        .WE3(RegWrite), 
        .RD1(SrcA), 
        .RD2(WriteData)
        );

    /* Extend */
    Extend E0 (
        .Instr(Instr), 
        .ImmSrc(ImmSrc), 
        .ImmExt(ImmExt)
        );

    /* ALUSrc Selction */
    Mux X0 (
        .In1(WriteData), 
        .In2(ImmExt), 
        .sel(ALUSrc), 
        .out(SrcB)
        );

    /* ALU */
    ALU A0 (
        .SrcA(SrcA), 
        .SrcB(SrcB), 
        .ALUControl(ALUControl), 
        .ALUResult(ALUResult), 
        .Zero(Zero), 
        .Sign(Sign)
        );


    /* Data Memory */
    data_mem M1 (
        .clk(clk), 
        .WE(MemWrite), 
        .WD(WriteData), 
        .A(ALUResult), 
        .RD(ReadData)
        );

    /* ResultSrc Selection */
    Mux X1 (
        .In1(ALUResult), 
        .In2(ReadData), 
        .sel(ResultSrc), 
        .out(Result)
        );

    /* Control Unit */
    Control_Unit C0 (
        .OP(Instr[6:0]),
        .funct3(Instr[14:12]), 
        .funct7(Instr[30]), 
        .Zero(Zero), 
        .Sign(Sign), 
        .PCSrc(PCSrc), 
        .ResultSrc(ResultSrc), 
        .MemWrite(MemWrite), 
        .ALUSrc(ALUSrc), 
        .RegWrite(RegWrite), 
        .ImmSrc(ImmSrc), 
        .ALUControl(ALUControl)
        );

endmodule