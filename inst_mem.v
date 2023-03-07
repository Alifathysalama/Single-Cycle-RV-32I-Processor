module  inst_mem #(
    parameter WIDTH = 32,
    parameter DEPTH = 265
)(
    input [WIDTH-1:0] A,
    output [WIDTH-1:0] Instr
);

reg [WIDTH-1:0] Instr_mem [DEPTH-1:0];

initial begin
    $readmemh("FIBONACCI_series_Machine_Code.hex", Instr_mem);
end

assign Instr = Instr_mem[A[31:2]];

endmodule