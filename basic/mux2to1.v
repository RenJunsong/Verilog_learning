module mux2to1(in1, in2, sel, out);
    parameter DATA_WIDTH = 4; 
    input [DATA_WIDTH-1:0] in1, in2;
    input sel;
    output [DATA_WIDTH-1:0] out;

    assign out = (!sel) ? in1 : in2;
endmodule
