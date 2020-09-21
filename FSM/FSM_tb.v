`timescale 10ns/1ns
module FSM_tb();
reg in, clk, reset;
wire [2:0] out, state;

initial begin
    clk = 0;
    reset = 0;
    in = 0;
    #20 reset = 1;
end

always #20 clk = ~clk;

initial begin
    #20 in = 1;
    #50 in = 0;
    #20 in = 1;
    #50 in = 1;
    #100 $finish;
end

FSMseq newFSM_seq(
    .in(in),
    .reset(reset),
    .out(out),
    .clk(clk),
    .state(state)
);
endmodule
