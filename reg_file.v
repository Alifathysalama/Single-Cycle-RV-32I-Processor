module reg_file (
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input clk,
    input areset,
    input WE3,
    input [31:0] WD3,
    output  [31:0] RD1,
    output  [31:0] RD2
);

reg [31:0] reg_file [31:0];
integer i ;

initial begin
    for (i =0 ;i<32 ;i=i+1 ) begin
        reg_file[i]<={32{1'b0}};
    end
end

always @(posedge clk  or negedge areset) begin
    if(!areset) begin
        for (i =0 ;i<32 ;i=i+1 ) begin
        reg_file[i]<={32{1'b0}};
        end
    end
    else if(WE3) begin
        reg_file[A3]<= WD3;
    end
end

assign RD1 = reg_file[A1];
assign RD2 = reg_file[A2];

endmodule 