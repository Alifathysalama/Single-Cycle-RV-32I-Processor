module data_mem (
    input [31:0] A,
    input [31:0] WD,
    input clk,
    input WE,
    output [31:0] RD
); 

reg [31:0] data_memory [63:0];

initial begin
    $readmemh("data_memory.hex", data_memory);
end 

always @(posedge clk ) begin
    if(WE) begin
        data_memory[A]<=WD;
    end
end

assign RD = data_memory[A];


endmodule