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