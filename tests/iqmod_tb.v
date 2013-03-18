module iqmod_tb;

	reg reset = 0;
	initial begin
		$dumpvars;

		reset = 0;
		clock = 1;
		
		in_i = 127;
		in_q = -127;

		#10 reset = 1;
		#400 $finish;
	end

	reg clock = 0;
	always #1 clock = !clock;
	

	reg signed [7:0] in_i;
	reg signed [7:0] in_q;
	wire [9:0] out_dac;

	iqmod myiqmod (out_dac,in_i,in_q,clock,reset);

endmodule
