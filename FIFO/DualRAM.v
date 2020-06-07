//FileName: DualRAM.v 
//Function: dual port ram, 512*8
//Creator: Ren Junsong
//

module DualRAM(
    write_clock,
    read_clock,
    write_allow,
    read_allow,
    write_addr,
    read_addr,
    write_data,
    read_data
);

parameter DLY   =1;  //zero time delays can be confusion
parameter RAM_WIDTH = 8; //per address can save 8bit
parameter RAM_DEPTH = 512; //can save 512 data
parameter ADDR_WIDTH = 9; //512=2**9

input write_clock;
input read_clock;
input write_allow;
input read_allow;
input [ADDR_WIDTH-1:0] write_addr;
input [ADDR_WIDTH-1:0] read_addr;
input [RAM_WIDTH-1:0] write_data;
output [RAM_WIDTH-1:0] read_data;
reg [RAM_WIDTH-1:0] memory[RAM_DEPTH-1:0];

always @ (posedge write_clock)
begin
    if(write_allow)
        memory[write_addr] <= #DLY write_data;
end

always @ (posedge read_clock)
begin
    if(read_allow)
        read_data <= #DLY memory[read_addr];
end

endmodule
