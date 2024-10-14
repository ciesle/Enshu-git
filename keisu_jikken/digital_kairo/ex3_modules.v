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