//FileName: SYNCFIFO.v
//Creator: Ren Junsong
//Function: 

mudule SYNCFIFO(
Fifo_rst,   //async reset
Clock,      //write and read clock
Read_enable,
Write_enable,
Read_data,
Write_data,
Full,       //Full flag, if the FIFO is full, Full is 1.
Empty,      //Empty flag, if the FIFO is empty, Empty is 1.
Fcounter    //count the number of data in FIFO
);

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 9;

input Fifo_rst;
input Clock;
input Read_enable;
input Write_enable;
input [DATA_WIDTH-1:0] Write_data;
output reg [DATA_WIDTH-1:0] Read_data;
output reg Full;
output reg Empty;
output reg [ADDR_WIDTH-1:0] Fcounter;

reg [ADDR_WIDTH-1:0] Read_addr;
reg [ADDR_WIDTH-1:0] Write_addr;

wire Read_allow = (Read_enable && !Empty);
wire Write_allow = (Write_enable && !Full);

DaulRAM fiforam(
    .Read_clock(Clock),
    .Write_clock(Clock),
    .Read_allow(Read_allow),
    .Write_allow(Write_allow),
    .Read_addr(Read_addr),
    .Write_addr(Write_addr),
    .Write_data(Write_data),
    .Read_data(Read_data)
)

/*
* Empty flag is set on Fifo_rst, or when on the next clock cycle, Write Enable is low,and either the FIFOcount is equa to 0, or it is equal to 1 and Read Enable is high.
*/
always @ (posedge Clock or posedge Fifo_rst)
    if(Fifo_rst)
        Empty <= 'b1;
    else
        Empty <=


