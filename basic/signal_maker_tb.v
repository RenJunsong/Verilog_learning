module signal_maker_tb();
    parameter DATA_WIDTH = 6;
    reg clk, load;
    reg [DATA_WIDTH-1:0] D;
    wire out;

    initial begin
        clk=0;
        load=0;
        D=0;
        #500 D=6'b010101;
        #1 load=1;
        #5 load=0;
    end
    always #5 clk = ~clk;

signal_maker sig1(
    .clk(clk),
    .load(load),
    .D(D),
    .out(out)
    );

endmodule
