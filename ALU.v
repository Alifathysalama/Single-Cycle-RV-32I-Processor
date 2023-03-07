module ALU
    #(parameter n = 32)
    (
        input [n-1:0] SrcA, SrcB,
        input [2:0] ALUControl,
        output reg [n-1:0] ALUResult,
        output reg Zero,
        output reg Sign
    );
    always @(*) begin
        case (ALUControl)
            3'b000:  ALUResult = SrcA + SrcB;      
            3'b001:  ALUResult = SrcA << SrcB;      
            3'b010:  ALUResult = SrcA - SrcB;      
            3'b100:  ALUResult = SrcA ^ SrcB;      
            3'b101:  ALUResult = SrcA >> SrcB;      
            3'b110:  ALUResult = SrcA | SrcB;       
            3'b111:  ALUResult = SrcA & SrcB;      
            default: ALUResult = {n{1'b0}};        
        endcase

        Zero = ALUResult ? 1'b0 : 1'b1;
        Sign = ALUResult[n-1];
    end
endmodule
