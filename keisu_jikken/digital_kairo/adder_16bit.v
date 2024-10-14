module adder(
  input [15:0] a,
  input [15:0] b,
  output [15:0] s
);
wire c0,c1,c2,c3;
single s0(
.a(a[3:0]),
.b(b[3:0]),
.cin(0),
.s(s[3:0]),
.cout(c0)
);
single s1(
.a(a[7:4]),
.b(b[7:4]),
.cin(c0),
.s(s[7:4]),
.cout(c1)
);
single s2(
.a(a[11:8]),
.b(b[11:8]),
.cin(c1),
.s(s[11:8]),
.cout(c2)
);
single s3(
.a(a[15:12]),
.b(b[15:12]),
.cin(c2),
.s(s[15:12]),
.cout(c3)
);
endmodule
module single(
input [3:0] a,
input [3:0] b,
input cin,
output [3:0] s,
output cout
);
wire [3:0] p = {
a[3]^b[3],
a[2]^b[2],
a[1]^b[1],
a[0]^b[0]
};
wire [3:0] g = {
a[3]&b[3],
a[2]&b[2],
a[1]&b[1],
a[0]&b[0]
};
wire [3:0] c;
assign c={
g[3] | p[3]&g[2] | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&g[0] | p[3]&p[2]&p[1]&p[0]&cin,
g[2] | p[2]&g[1] | p[2]&p[1]&g[0] | p[2]&p[1]&p[0]&cin,
g[1] | p[1]&g[0] | p[1]&p[0]&cin,
g[0] | p[0]&cin
};
assign s = {
a[3]^b[3]^c[2],
a[2]^b[2]^c[1],
a[1]^b[1]^c[0],
a[0]^b[0]^cin
};
assign cout=c[3];
endmodule
