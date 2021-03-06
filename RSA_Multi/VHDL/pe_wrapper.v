//--------------------------------------------------------------------------------------------
//
// Generated by X-HDL VHDL Translator - Version 2.0.0 Feb. 1, 2011
// ?? 4? 28 2020 14:54:13
//
//      Input file      : 
//      Component name  : pe_wrapper
//      Author          : 
//      Company         : 
//
//      Description     : 
//
//
//--------------------------------------------------------------------------------------------


module pe_wrapper(clk, reset, ab_valid, valid_in, a, b, n, s_prev, n_c, s, data_ready, fifo_req, m_val, reset_the_PE);
   
   input         clk;
   input         reset;
   input         ab_valid;
   input         valid_in;
   input [15:0]  a;
   input [15:0]  b;
   input [15:0]  n;
   input [15:0]  s_prev;
   input [15:0]  n_c;
   output [15:0] s;
   output        data_ready;
   output        fifo_req;
   output        m_val;
   reg           m_val;
   input         reset_the_PE;
   
   
   wire [15:0]   aj_bi;
   reg [15:0]    m;
   reg [15:0]    next_m;
   wire [15:0]   m_out;
   wire          mult_valid;
   wire          valid_m;
   reg           valid_m_reg;
   
   
   pe pe_0(.clk(clk), .reset(reset), .a_j(a), .b_i(b), .s_prev(s_prev), .m(m), .n_j(n), .s_next(s), .aj_bi(aj_bi), .ab_valid_in(ab_valid), .valid_in(valid_in), .ab_valid_out(mult_valid), .valid_out(data_ready), .fifo_req(fifo_req));
   
   
   m_calc mcons_0(.clk(clk), .reset(reset), .ab(aj_bi), .t(s_prev), .n_cons(n_c), .m(m_out), .mult_valid(mult_valid), .m_valid(valid_m));
   
   
   always @(posedge clk or reset)
      
      begin
         
         if (reset == 1'b1)
         begin
            m <= {16{1'b0}};
            valid_m_reg <= 1'b0;
         end
         else
         begin
            m <= next_m;
            valid_m_reg <= valid_m;
         end
      end
   
   
   always @(m_out or valid_m or valid_m_reg or m)
   begin
      m_val <= valid_m_reg;
      if (valid_m == 1'b1 & valid_m_reg == 1'b0)
         next_m <= m_out;
      else
         next_m <= m;
   end
   
endmodule
