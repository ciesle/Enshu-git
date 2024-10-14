`define COUNTER_W 4

`define ENABLE 1'b1
`define DISABLE 1'b0


module counter_3bit(
	input clk,
	input reset_n,
	input enable,
	output [2:0] count
);
reg [2:0] r_count;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        r_count <= 3'b000;
    end else begin
        if (enable==1'b1) begin
            r_count <= r_count+3'b001;
        end
    end
end
assign count=r_count;
endmodule

module seven_seg_decoder(
	input [2:0] num,
	output led_a,
	output led_b,
	output led_c,
	output led_d,
	output led_e,
	output led_f,
	output led_g
);
wire [3:0] data;
assign data = {0,num[2],num[1],num[0]};
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



module chattering_eliminator (
	input clk,
	input in_signal,
	output out_signal
);

	reg [`COUNTER_W:0] r_count;
	reg r_out_signal;
	reg r_enable_delay;
	

	always @(posedge clk or negedge in_signal) begin
		if (!in_signal) begin
			r_count <= 0;
		end else begin
			if (!(&r_count == `ENABLE)) begin
				r_count <= r_count + 1;
			end
		end
	end
	
	always @(posedge clk) begin
	   r_enable_delay <= &r_count;
	end

    assign out_signal = &r_count & !r_enable_delay;	

endmodule 
