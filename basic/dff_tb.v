module dff_tb();
    parameter DATA_WIDTH = 4;
    reg [DATA_WIDTH-1:0] d;
    reg clk, rst;
    wire [DATA_WIDTH-1:0] out;
`timescale 1ns/1ps
initial begin
    #2 rst=1;
    clk=1;
    d=1;
    #2 rst=0;
    #4 rst=1;
    #5 d=0;
    #5 d=1;
    #20 d=0;
    #40 d=1;
end

always #5 clk=~clk;

dff dffer (
    .d(d),
    .rst(rst),
    .clk(clk),
    .q(out)
    );

endmodule
