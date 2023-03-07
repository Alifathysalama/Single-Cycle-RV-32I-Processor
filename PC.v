module PC(
    input [31:0] PCNext,
    input clk,
    input load,
    input areset,
    output reg [31:0] PC
);


always @(posedge clk or negedge areset) begin
    if(!areset) begin
      PC<={32{1'b0}};
    end
    else if(load)  begin
          PC<=PCNext;
    end
 end

endmodule