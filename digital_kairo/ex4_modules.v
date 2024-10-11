module multiplier_2bit(
	input x0,
	input x1,
	input y0,
	input y1,
	output s0,
	output s1,
	output s2,
	output cout
);
    wire [2:0] zero, one;
    assign zero = (y0==1'b0) ? {0,0,0} : {1'b0,x1,x0};
    assign one = (y1==1'b0) ? {0,0,0} : {x1,x0,1'b0};
    rca_3bit(
    .x0(zero[0]),
    .x1(zero[1]),
    .x2(zero[2]),
    .y0(one[0]),
    .y1(one[1]),
    .y2(one[2]),
    .s0(s0),
    .s1(s1),
    .s2(s2),
    .cout(cout)
    );
endmodule


module rca_3bit (
	input x0,
	input x1,
	input x2,
	input y0,
	input y1,
	input y2,
	output s0,
	output s1,
	output s2,
	output cout
);
wire c0_out,c1_out;
full_adder fa0(
.xin(x0),
.yin(y0),
.cin(0),
.sout(s0),
.cout(c0_out)
);
full_adder fa1(
.xin(x1),
.yin(y1),
.cin(c0_out),
.sout(s1),
.cout(c1_out)
);
full_adder fa2(
.xin(x2),
.yin(y2),
.cin(c1_out),
.sout(s2),
.cout(cout)
);
endmodule

module full_adder (
	input xin,
	input yin,
	input cin,
	output sout,
	output cout
);
	assign sout = (xin ^ yin) ^ cin;
	assign cout = (xin & yin) | ((xin ^ yin) & cin);
endmodule