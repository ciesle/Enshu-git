module adder(
  input [15:0] a,
  input [15:0] b,
  output [15:0] s
);
wire [15:0] c;
full_adder fa0(
.xin(a[0]),
.yin(b[0]),
.cin(0),
.sout(s[0]),
.cout(c[0])
);
full_adder fa1(
.xin(a[1]),
.yin(b[1]),
.cin(c[0]),
.sout(s[1]),
.cout(c[1])
);
full_adder fa2(
.xin(a[2]),
.yin(b[2]),
.cin(c[1]),
.sout(s[2]),
.cout(c[2])
);
full_adder fa3(
.xin(a[3]),
.yin(b[3]),
.cin(c[2]),
.sout(s[3]),
.cout(c[3])
);
full_adder fa4(
.xin(a[4]),
.yin(b[4]),
.cin(c[3]),
.sout(s[4]),
.cout(c[4])
);
full_adder fa5(
.xin(a[5]),
.yin(b[5]),
.cin(c[4]),
.sout(s[5]),
.cout(c[5])
);
full_adder fa6(
.xin(a[6]),
.yin(b[6]),
.cin(c[5]),
.sout(s[6]),
.cout(c[6])
);
full_adder fa7(
.xin(a[7]),
.yin(b[7]),
.cin(c[6]),
.sout(s[7]),
.cout(c[7])
);
full_adder fa8(
.xin(a[8]),
.yin(b[8]),
.cin(c[7]),
.sout(s[8]),
.cout(c[8])
);
full_adder fa9(
.xin(a[9]),
.yin(b[9]),
.cin(c[8]),
.sout(s[9]),
.cout(c[9])
);
full_adder fa10(
.xin(a[10]),
.yin(b[10]),
.cin(c[9]),
.sout(s[10]),
.cout(c[10])
);
full_adder fa11(
.xin(a[11]),
.yin(b[11]),
.cin(c[10]),
.sout(s[11]),
.cout(c[11])
);
full_adder fa12(
.xin(a[12]),
.yin(b[12]),
.cin(c[11]),
.sout(s[12]),
.cout(c[12])
);
full_adder fa13(
.xin(a[13]),
.yin(b[13]),
.cin(c[12]),
.sout(s[13]),
.cout(c[13])
);
full_adder fa14(
.xin(a[14]),
.yin(b[14]),
.cin(c[13]),
.sout(s[14]),
.cout(c[14])
);
full_adder fa15(
.xin(a[15]),
.yin(b[15]),
.cin(c[14]),
.sout(s[15]),
.cout(c[15])
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
