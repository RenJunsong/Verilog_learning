module mux2to1_tb();
    parameter DATA_WIDTH = 4;    
    reg [DATA_WIDTH-1:0] in1_data, in2_data;
    reg sel;
    wire [DATA_WIDTH-1:0] out;

//
initial begin
    #5 in1_data=4'b1111;
    in2_data=4'b0101;
    #2 sel=1;
    #2 sel=0;
end

mux2to1 muxer (
    .in1(in1_data),
    .in2(in2_data),
    .sel(sel),
    .out(out)
);

endmodule
