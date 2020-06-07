//--------------------------------------------------------------------------------------------
//
// Generated by X-HDL VHDL Translator - Version 2.0.0 Feb. 1, 2011
// ?? 4? 28 2020 14:26:56
//
//      Input file      : 
//      Component name  : montgomery_mult
//      Author          : 
//      Company         : 
//
//      Description     : 
//
//
//--------------------------------------------------------------------------------------------


module montgomery_mult(clk, reset, valid_in, a, b, n, s_prev, n_c, s, valid_out);
   
   input            clk;
   input            reset;
   input            valid_in;
   input [15:0]     a;
   input [15:0]     b;
   input [15:0]     n;
   input [15:0]     s_prev;
   input [15:0]     n_c;
   output [15:0]    s;
   reg [15:0]       s;
   output           valid_out;
   reg              valid_out;
   
   
   
   reg [15:0]       b_reg[0:7];
   reg [15:0]       next_b_reg[0:7];
   wire             valid_mid[0:7];
   wire             fifo_reqs[0:7];
   reg              fifo_reqs_reg[0:7];
   reg              next_fifo_reqs_reg[0:7];
   reg              stops[0:7];
   wire [15:0]      a_out_mid[0:7];
   wire [15:0]      n_out_mid[0:7];
   wire [15:0]      s_out_mid[0:7];
   
   reg              wr_en;
   reg              rd_en;
   wire             empty;
   wire [15:0]      fifo_out;
   
   wire [48:0]      fifo_out_feedback;
   reg [48:0]       fifo_in_feedback;
   reg              read_fifo_feedback;
   wire             empty_feedback;
   
   reg [15:0]       a_in;
   reg [15:0]       s_in;
   reg [15:0]       n_in;
   reg              f_valid;
   wire             busy_pe;
   
   wire             c_step;
   reg              reg_c_step;
   
   reg [7:0]        count;
   reg [7:0]        next_count;
   
   reg              wr_fifofeed;
   
   parameter [1:0]  state_type_rst_fifos = 0,
                    state_type_wait_start = 1,
                    state_type_process_data = 2,
                    state_type_dump_feed = 3;
   reg [1:0]        state;
   reg [1:0]        next_state;
   reg              reg_busy;
   reg              reset_fifos;
   reg [15:0]       count_feedback;
   reg [15:0]       next_count_feedback;
   
   
   fifo_512_bram fifo_b(.clk(clk), .rst(reset_fifos), .din(b), .wr_en(wr_en), .rd_en(rd_en), .dout(fifo_out), .empty(empty));
   
   
   fifo_256_feedback fifo_feed(.clk(clk), .rst(reset_fifos), .din(fifo_in_feedback), .wr_en(wr_fifofeed), .rd_en(read_fifo_feedback), .dout(fifo_out_feedback), .empty(empty_feedback));
   
   
   montgomery_step et_first(.clk(clk), .reset(reset), .valid_in(f_valid), .a(a_in), .b(b_reg[0]), .n(n_in), .s_prev(s_in), .n_c(n_c), .s(s_out_mid[0]), .valid_out(valid_mid[0]), .busy(busy_pe), .b_req(fifo_reqs[0]), .a_out(a_out_mid[0]), .n_out(n_out_mid[0]), .c_step(c_step), .stop(stops[0]));
   
   
   montgomery_step et_last(.clk(clk), .reset(reset), .valid_in(valid_mid[6]), .a(a_out_mid[6]), .b(b_reg[7]), .n(n_out_mid[6]), .s_prev(s_out_mid[6]), .n_c(n_c), .s(s_out_mid[7]), .valid_out(valid_mid[7]), .b_req(fifo_reqs[7]), .a_out(a_out_mid[7]), .n_out(n_out_mid[7]), .stop(stops[7]));
   
   generate
      begin : xhdl0
         genvar           i;
         for (i = 1; i <= 6; i = i + 1)
         begin : g1
            
            montgomery_step et_i(.clk(clk), .reset(reset), .valid_in(valid_mid[i - 1]), .a(a_out_mid[i - 1]), .b(b_reg[i]), .n(n_out_mid[i - 1]), .s_prev(s_out_mid[i - 1]), .n_c(n_c), .s(s_out_mid[i]), .valid_out(valid_mid[i]), .b_req(fifo_reqs[i]), .a_out(a_out_mid[i]), .n_out(n_out_mid[i]), .stop(stops[i]));
         end
      end
   endgenerate
   
   
   always @(posedge clk or reset)
   begin: xhdl1
      integer          i;
      
      
      begin
         
         if (reset == 1'b1)
         begin
            state <= state_type_wait_start;
            count_feedback <= {16{1'b0}};
            reg_busy <= 1'b0;
            for (i = 0; i <= 7; i = i + 1)
            begin
               b_reg[i] <= {(7-15:0][0)+1{1'b0}};
               fifo_reqs_reg[i] <= 1'b0;
               count <= {8{1'b0}};
               reg_c_step <= 1'b0;
            end
         end
         else
         begin
            
            state <= next_state;
            reg_busy <= busy_pe;
            count_feedback <= next_count_feedback;
            for (i = 0; i <= 7; i = i + 1)
            begin
               b_reg[i] <= next_b_reg[i];
               fifo_reqs_reg[i] <= next_fifo_reqs_reg[i];
               count <= next_count;
               reg_c_step <= c_step;
            end
         end
      end
   end
   
   
   always @(fifo_reqs_reg or fifo_out or b or fifo_reqs or b_reg or state or empty)
   begin: xhdl2
      integer          i;
      
      for (i = 0; i <= 7; i = i + 1)
      begin
         next_b_reg[i] <= b_reg[i];
         next_fifo_reqs_reg[i] <= fifo_reqs[i];
      end
      
      if (state == state_type_wait_start)
      begin
         next_b_reg[0] <= b;
         next_fifo_reqs_reg[0] <= 1'b0;
         for (i = 1; i <= 7; i = i + 1)
         begin
            next_b_reg[i] <= {(7-15:0][0)+1{1'b0}};
            next_fifo_reqs_reg[i] <= 1'b0;
         end
      end
      else
         for (i = 0; i <= 7; i = i + 1)
            if (fifo_reqs_reg[i] == 1'b1 & empty == 1'b0)
               next_b_reg[i] <= fifo_out;
   end
   
   
   always @(valid_in or b or state or fifo_reqs or a_out_mid or n_out_mid or s_out_mid or valid_mid or a or s_prev or n or busy_pe or empty_feedback or fifo_out_feedback or count or reg_c_step or reset or reg_busy or count_feedback)
   begin: xhdl3
      integer          i;
      
      rd_en <= fifo_reqs[0] | fifo_reqs[1] | fifo_reqs[2] | fifo_reqs[3] | fifo_reqs[4] | fifo_reqs[5] | fifo_reqs[6] | fifo_reqs[7];
      next_state <= state;
      wr_en <= 1'b0;
      fifo_in_feedback <= {a_out_mid[7], n_out_mid[7], s_out_mid[7], valid_mid[7]};
      read_fifo_feedback <= 1'b0;
      wr_fifofeed <= 1'b0;
      a_in <= a;
      s_in <= s_prev;
      n_in <= n;
      f_valid <= valid_in;
      reset_fifos <= reset;
      s <= {16{1'b0}};
      valid_out <= 1'b0;
      
      next_count <= count;
      next_count_feedback <= count_feedback;
      if (reg_c_step == 1'b1)
         next_count <= count + 8;
      if (count == 8'h20)
      begin
         s <= s_out_mid[0];
         valid_out <= valid_mid[0];
      end
      
      for (i = 0; i <= 7; i = i + 1)
         stops[i] <= 1'b0;
      
      case (state)
         state_type_wait_start :
            if (valid_in == 1'b1)
            begin
               reset_fifos <= 1'b0;
               next_state <= state_type_process_data;
            end
         
         state_type_process_data :
            begin
               wr_fifofeed <= valid_mid[7];
               if (valid_in == 1'b1)
                  wr_en <= 1'b1;
               if (empty_feedback == 1'b0 & reg_busy == 1'b0)
               begin
                  read_fifo_feedback <= 1'b1;
                  next_state <= state_type_dump_feed;
                  next_count_feedback <= 16'h0000;
               end
               
               if (count > 8'h23)
               begin
                  next_state <= state_type_wait_start;
                  for (i = 0; i <= 7; i = i + 1)
                     stops[i] <= 1'b1;
                  next_count <= {8{1'b0}};
               end
            end
         
         state_type_dump_feed :
            begin
               if (empty_feedback == 1'b0)
                  next_count_feedback <= count_feedback + 1;
               wr_fifofeed <= valid_mid[7];
               read_fifo_feedback <= 1'b1;
               a_in <= fifo_out_feedback[48:33];
               n_in <= fifo_out_feedback[32:17];
               s_in <= fifo_out_feedback[16:1];
               f_valid <= fifo_out_feedback[0];
               if (empty_feedback == 1'b1)
                  next_state <= state_type_process_data;
               
               if (count_feedback == 8'h22)
               begin
                  read_fifo_feedback <= 1'b0;
                  next_state <= state_type_process_data;
               end
            end
         state_type_rst_fifos :
            begin
               next_state <= state_type_wait_start;
               reset_fifos <= 1'b1;
            end
      endcase
   end
   
endmodule
