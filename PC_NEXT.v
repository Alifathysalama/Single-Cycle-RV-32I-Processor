module PC_NEXT(
    input [31:0] ImmExt,
    input [31:0] PC,
    input PCSrc,
    output reg [31:0] PCNext
);


always @(*) begin
    if(PCSrc) begin
      PCNext <= PC + ImmExt;
    end    
    else begin
      PCNext <= PC + 32'd4;
    end
end

endmodule