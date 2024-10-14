`define COUNTER_W 4

`define ENABLE 1'b1
`define DISABLE 1'b0

module state_machine (
	input clk,
	input reset_n,
	input btn0,
	input btn1,
	output state
);
reg prev, out;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        prev=`DISABLE;
        out=`DISABLE;
    end else begin
        if (btn1==`ENABLE) begin
            if (prev==`ENABLE) begin
                out=`ENABLE;
            end else if (out==`ENABLE) begin
                out=`DISABLE;
            end
            prev=`DISABLE;
        end else if (btn0 == `ENABLE) begin
            prev=`ENABLE;
            out=`DISABLE;
        end
    end
end
assign state=out;
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
