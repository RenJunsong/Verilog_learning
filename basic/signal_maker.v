//In order to generate the sequence signal, initil is 10010,or set the load and D;
module signal_maker(out, clk ,load, D);
    parameter DATA_WIDTH = 6;
    output out;
    input clk, load;
    input [DATA_WIDTH-1:0] D;
    reg [DATA_WIDTH-1:0] Q;

initial Q=6'b110011;

always @(posedge clk) begin
    if (load) Q<=D;
    else Q<={Q[DATA_WIDTH-2:0],Q[DATA_WIDTH-1]};
end

assign out = Q[DATA_WIDTH-1];


endmodule
