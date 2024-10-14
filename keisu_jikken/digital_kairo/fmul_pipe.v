module fmul(
    input clk,
    input reset_n,
	input [31:0] a,
	input [31:0] b,
	output [31:0] s
);
reg [9:0] exp,exp_tmp;
reg [23:0] ta,tb;
reg [47:0] sig,sig_tmp,sig_tmp2;
reg [31:0] out;
always @(posedge clk) begin
    // TIM1
    exp_tmp <= a[30:23]+b[30:23]-127;
    ta <= {1'b1, a[22:0]};
    tb <= {1'b1, b[22:0]};
    
    // TIM2
    sig_tmp2 <= ta*tb;
    
    //TIM 3
    if (sig_tmp2[22]==1'b1) begin
        sig_tmp<=sig_tmp2+(1'b1<<22);
    end else begin
        sig_tmp<=sig_tmp2;
    end
    
    // TIM 4
    if (sig_tmp[47]==1'b1) begin
        sig <= sig_tmp>>1;
        exp <= exp_tmp+1;
    end else begin
        sig <= sig_tmp;
        exp <= exp_tmp;
    end
    
    // TIM 5
    out <= {a[31]^b[31],exp[7:0],sig[45:23]};
end
assign s = out;
endmodule