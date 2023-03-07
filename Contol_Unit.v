module Control_Unit
(
    input [6:0] OP,
    input Zero, Sign, funct7,
    input [2:0] funct3,
    output reg PCSrc, ResultSrc, MemWrite, ALUSrc, RegWrite,
    output reg [1:0] ImmSrc,
    output wire [2:0] ALUControl
);
    
    reg Branch;
    reg [1:0] ALUOp;
    wire beq, bnq, blt;

    ALU_Decoder D0 (.OP5(OP[5]), .ALUOp(ALUOp), .funct3(funct3), .funct7(funct7), .ALUControl(ALUControl));
    
    always @(*) begin
        case (OP)
            7'b000_0011: begin 
              RegWrite <= 1'b1; 
              ImmSrc <= 2'b00;
              ALUSrc <= 1'b1;
              MemWrite <= 1'b0; 
              ResultSrc <= 1'b1; 
              Branch <= 1'b0; 
              ALUOp <= 2'b00; 
            end
            7'b010_0011: begin 
              RegWrite <= 1'b0; 
              ImmSrc <= 2'b01; 
              ALUSrc <= 1'b1; 
              MemWrite <= 1'b1; 
              ResultSrc <= 1'b0; 
              Branch <= 1'b0; 
              ALUOp <= 2'b00; 
              end
            7'b011_0011: begin 
              RegWrite <= 1'b1; 
              ImmSrc <= 2'b00; 
              ALUSrc <= 1'b0; 
              MemWrite <= 1'b0; 
              ResultSrc <= 1'b0; 
              Branch <= 1'b0; 
              ALUOp <= 2'b10; 
              end
            7'b001_0011: begin 
              RegWrite <= 1'b1; 
              ImmSrc <= 2'b00; 
              ALUSrc <= 1'b1; 
              MemWrite <= 1'b0; 
              ResultSrc <= 1'b0; 
              Branch <= 1'b0; 
              ALUOp <= 2'b10; 
              end
            7'b110_0011: begin 
              RegWrite <= 1'b0; 
              ImmSrc <= 2'b10; 
              ALUSrc <= 1'b0; 
              MemWrite <= 1'b0; 
              ResultSrc <= 1'b0; 
              Branch <= 1'b1; 
              ALUOp <= 2'b01; 
              end
            default:begin 
              RegWrite <= 1'b0; 
              ImmSrc <= 2'b00; 
              ALUSrc <= 1'b0; 
              MemWrite <= 1'b0; 
              ResultSrc <= 1'b0; 
              Branch <= 1'b0; 
              ALUOp <= 2'b00; 
              end
        endcase
        case (funct3)
            3'b000:  PCSrc <= beq; 
            3'b001:  PCSrc <= bnq; 
            3'b100:  PCSrc <= blt; 
            default: PCSrc <= 1'b0;
        endcase
    end

    assign beq = Branch & Zero; 
    assign bnq = Branch & ~Zero; 
    assign blt = Branch & Sign; 

endmodule