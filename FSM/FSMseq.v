`timescale 10ns/1ns
module FSMseq(in, out, clk, reset, state);
input in;
input clk;
input reset;
output out; 
output [2:0] state;

reg [2:0] next_state;
reg [2:0] cur_state;
parameter s0='d0, s1='d1, s2='d2, s3='d3, s4='d4, s5='d5, s6='d6, s7='d7;
parameter DLY = 1;

//reset and next change to cur
always @ (posedge clk or negedge reset) begin
    if(!reset) begin
        cur_state <= #DLY s0;
    end
    else begin
        cur_state <= #DLY next_state;
    end
end

// next_state
always @ (*) begin
    case(cur_state)
        s0: begin
            if(in==1)
                next_state = s1;
            else
                next_state = s0;
        end
        s1: begin
            if(in==1)
                next_state = s2;
            else
                next_state = s0;
        end
        s2: begin
            if(in==1)
                next_state = s3;
            else
                next_state = s0;
        end
        s3: begin
            if(in==1)
                next_state = s3;
            else
                next_state = s4;
        end        
        s4: begin
            if(in==1)
                next_state = s1;
            else
                next_state = s5;
        end        
        s5: begin
            if(in==1)
                next_state = s6;
            else
                next_state = s0;
        end        
        s6: begin
            if(in==1)
                next_state = s2;
            else
                next_state = s7;
        end
        s7: begin
            if(in==1)
                next_state = s1;
            else
                next_state = s0;
        end
        default:begin
            next_state = s0;
        end
    endcase
end

//output in assign
assign out = (cur_state == s7) ? 1:0;
assign state = cur_state; 
endmodule
