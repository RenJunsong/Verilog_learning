module sync_pulse (
                  clk_a,        
                  clk_b,   
                  rst_a_n,            
                  rst_b_n,
                  pulse_a_in,   
                 
                  pulse_b_out,  
                  b_out 
                  );
 
input                           clk_a;
input                           clk_b;
input                           rst_a_n;
input                           rst_b_n;
input                           pulse_a_in;
    
output                          pulse_b_out;
output                          b_out;
);

input                           clk_a;
input                           clk_b;
input                           rst_a_n;
input                           rst_b_n;
input                           pulse_a_in;
    
output                          pulse_b_out;
output                          b_out;
    
 
reg                             signal_a;
reg                             signal_b;
reg                             signal_b_r1;
reg                             signal_b_r2;
reg                             signal_b_a1;
reg                             signal_b_a2;

always @ (posedge clk_a or negedge rst_a_n) begin
    if (rst_a_n == 1'b0)
                signal_a <= 1'b0;
            else if (pulse_a_in)            //????????????????pulse_a_in??????????????signal_a
                signal_a <= 1'b1;
            else if (signal_b_a2)           //??????signal_b1_a2??????????????signal_a
                signal_a <= 1'b0;
            else;
        end
    
    //????????clk_b????????signal_a??????signal_b
    always @ (posedge clk_b or negedge rst_b_n)
        begin
            if (rst_b_n == 1'b0)
                signal_b <= 1'b0;
            else
                signal_b <= signal_a;
        end
 //??????????????
    always @ (posedge clk_b or negedge rst_b_n)
        begin
            if (rst_b_n == 1'b0) 
                begin
                    signal_b_r1 <= 1'b0;
                    signal_b_r2 <= 1'b0;
                end
            else 
                begin
                    signal_b_r1 <= signal_b;        //??signal_b??????
                    signal_b_r2 <= signal_b_r1;
                end
        end
 //????????clk_a????????signal_b_r1????????????????????????signal_a
    always @ (posedge clk_a or negedge rst_a_n)
        begin
            if (rst_a_n == 1'b0) 
                begin
                    signal_b_a1 <= 1'b0;
                    signal_b_a2 <= 1'b0;
                end
            else 
                begin
                    signal_b_a1 <= signal_b_r1;     //??signal_b_r1??????????????????????????????   
                    signal_b_a2 <= signal_b_a1;
                end
        end
 
    assign  pulse_b_out =   signal_b_r1 & (~signal_b_r2);
    assign  b_out       =   signal_b_r1;
 
endmodule