module seven_seg_decoder(
	input s0,
	input s1,
	input s2,
	input cout,
	output led_a,
	output led_b,
	output led_c,
	output led_d,
	output led_e,
	output led_f,
	output led_g
);
wire [3:0] data;
assign data = {cout,s2,s1,s0};
function [6:0] decode(input [3:0] in);
    case (in)
        4'b0000: decode = 7'b1111110;
        4'b0001: decode = 7'b0110000;
        4'b0010: decode = 7'b1101101;
        4'b0011: decode = 7'b1111001;
        4'b0100: decode = 7'b0110011;
        4'b0101: decode = 7'b1011011;
        4'b0110: decode = 7'b1011111;
        4'b0111: decode = 7'b1110000;
        4'b0111: decode = 7'b1110000;
        4'b1000: decode = 7'b1111111;
        4'b1001: decode = 7'b1111011;
        default: decode = 7'b0000000;
    endcase
endfunction
assign {led_a, led_b, led_c, led_d, led_e, led_f, led_g} = decode(data);
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