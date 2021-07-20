module single_port_ram #
(

    parameter DATA_WIDTH = 12,
    parameter ADDR_WIDTH = 9
)
(
input[(DATA_WIDTH-1):0]                         rename_wdata,
input[(ADDR_WIDTH-1):0]                         rename_addr,
input                                           rename_cen,
input                                           rename_clk,
input                                           rename_wen,
output                                          rename_rdata
);
reg[DATA_WIDTH-1:0]                             ram[2**ADDR_WIDTH-1:0];
reg[DATA_WIDTH-1:0]                             rename_rdata;

always @ (posedge rename_clk) begin
    if (!rename_cen) begin
        if (!rename_wen)
           ram[rename_addr] = rename_wdata;
        rename_rdata <= ram[rename_addr];
    end
end

endmodule
