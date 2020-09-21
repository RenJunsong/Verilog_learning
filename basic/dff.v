module dff(d, rst, clk, q);
    parameter DATA_WIDTH = 4;    
    input [DATA_WIDTH-1:0] d;
    input rst, clk;
    output [DATA_WIDTH-1:0] q;
    reg [DATA_WIDTH-1:0] q;

always @(posedge clk or negedge rst) begin
    if(~rst)
        q<=0;
    else begin
        q<=d;
    end
end

endmodule
