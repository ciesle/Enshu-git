module fmul(
	input [31:0] a,
	input [31:0] b,
	output [31:0] s
);
reg [9:0] exp,exp_tmp;
reg [23:0] ta,tb;
reg [47:0] sig,sig_tmp,sig_tmp2;
reg [31:0] out;
always @(*) begin 
    out[31]=a[31]^b[31];
    exp_tmp = a[30:23]+b[30:23]-127;
    ta[23]=1;
    tb[23]=1;
    ta[22:0] = a[22:0];
    tb[22:0] = b[22:0];
    sig_tmp2 = ta*tb;
    
    if (sig_tmp2[22]==1'b1) begin
        sig_tmp=sig_tmp2+(1'b1<<22);
    end else begin
        sig_tmp=sig_tmp2;
    end
    
    if (sig_tmp[47]==1'b1) begin
        sig = sig_tmp>>1;
        exp = exp_tmp+1;
    end else begin
        sig = sig_tmp;
        exp = exp_tmp;
    end
    
    out[30:23] = exp[7:0];
    out[22:0] = sig[45:23];
end
assign s = out;
endmodule