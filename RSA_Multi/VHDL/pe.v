//--------------------------------------------------------------------------------------------
//
// Generated by X-HDL VHDL Translator - Version 2.0.0 Feb. 1, 2011
// ?? 4? 28 2020 14:51:55
//
//      Input file      : 
//      Component name  : pe
//      Author          : 
//      Company         : 
//
//      Description     : 
//
//
//--------------------------------------------------------------------------------------------


module pe(clk, reset, a_j, b_i, s_prev, m, n_j, s_next, aj_bi, ab_valid_in, valid_in, ab_valid_out, valid_out, fifo_req);
   input         clk;
   input         reset;
   input [15:0]  a_j;
   input [15:0]  b_i;
   input [15:0]  s_prev;
   input [15:0]  m;
   input [15:0]  n_j;
   output [15:0] s_next;
   reg [15:0]    s_next;
   output [15:0] aj_bi;
   reg [15:0]    aj_bi;
   input         ab_valid_in;
   input         valid_in;
   output        ab_valid_out;
   reg           ab_valid_out;
   output        valid_out;
   reg           valid_out;
   output        fifo_req;
   reg           fifo_req;
   
   
   reg [31:0]    prod_aj_bi;
   reg [31:0]    next_prod_aj_bi;
   wire [31:0]   mult_aj_bi;
   reg [31:0]    prod_nj_m;
   reg [31:0]    next_prod_nj_m;
   wire [31:0]   mult_nj_m;
   wire [31:0]   mult_nj_m_reg;
   reg [31:0]    sum_1;
   reg [31:0]    next_sum_1;
   reg [31:0]    sum_2;
   reg [31:0]    next_sum_2;
   reg           ab_valid_reg;
   reg           valid_out_reg;
   reg           valid_out_reg2;
   reg           valid_out_reg3;
   reg [15:0]    n_reg;
   reg [15:0]    next_n_reg;
   reg [15:0]    s_prev_reg;
   reg [15:0]    next_s_prev_reg;
   reg [15:0]    ab_out_reg;
   
   assign mult_aj_bi = a_j * b_i;
   assign mult_nj_m = n_reg * m;
   
   
   always @(posedge clk or reset)
      
      
      begin
         if (reset == 1'b1)
         begin
            prod_aj_bi <= {32{1'b0}};
            prod_nj_m <= {32{1'b0}};
            sum_1 <= {32{1'b0}};
            sum_2 <= {32{1'b0}};
            ab_valid_reg <= 1'b0;
            n_reg <= {16{1'b0}};
            valid_out_reg <= 1'b0;
            valid_out_reg2 <= 1'b0;
            valid_out_reg3 <= 1'b0;
            s_prev_reg <= {16{1'b0}};
         end
         else
         begin
            prod_aj_bi <= next_prod_aj_bi;
            prod_nj_m <= next_prod_nj_m;
            sum_1 <= next_sum_1;
            sum_2 <= next_sum_2;
            ab_valid_reg <= ab_valid_in;
            ab_out_reg <= mult_aj_bi[15:0];
            n_reg <= next_n_reg;
            valid_out_reg <= valid_in;
            valid_out_reg2 <= valid_out_reg;
            valid_out_reg3 <= valid_out_reg2;
            s_prev_reg <= next_s_prev_reg;
         end
      end
   
   
   always @(s_prev or prod_aj_bi or prod_nj_m or sum_1 or sum_2 or mult_aj_bi or mult_nj_m or valid_in or ab_valid_reg or n_j or n_reg or valid_out_reg3 or s_prev_reg or ab_out_reg)
   begin
      ab_valid_out <= ab_valid_reg;
      aj_bi <= ab_out_reg[15:0];
      s_next <= sum_2[15:0];
      fifo_req <= valid_in;
      valid_out <= valid_out_reg3;
      next_sum_1 <= sum_1;
      next_sum_2 <= sum_2;
      next_prod_nj_m <= prod_nj_m;
      next_prod_aj_bi <= prod_aj_bi;
      next_n_reg <= n_reg;
      next_s_prev_reg <= s_prev_reg;
      if (valid_in == 1'b1)
      begin
         next_s_prev_reg <= s_prev;
         next_n_reg <= n_j;
         next_prod_aj_bi <= mult_aj_bi;
         next_prod_nj_m <= mult_nj_m;
         next_sum_1 <= prod_aj_bi + sum_1[31:16] + s_prev_reg;
         next_sum_2 <= prod_nj_m + sum_2[31:16] + sum_1[15:0];
      end
      else
      begin
         next_s_prev_reg <= {16{1'b0}};
         next_n_reg <= {16{1'b0}};
         next_prod_aj_bi <= {32{1'b0}};
         next_prod_nj_m <= {32{1'b0}};
         next_sum_1 <= {32{1'b0}};
         next_sum_2 <= {32{1'b0}};
      end
   end
   
endmodule



