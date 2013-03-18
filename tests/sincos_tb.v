module sincos_tb;

	initial begin
		$dumpvars;

		clock = 1;
		#300 $finish;

		in_sin=8'h00;
		in_cos=8'h00;
	end

	reg clock = 0;
	always #10 clock = !clock;
	always #1 in_sin=in_sin+1;
	always #1 in_cos=in_cos+1;

	reg [7:0] in_sin = 8'h00;
	reg [7:0] in_cos = 8'h00;
	wire [7:0] out_sin;
	wire [7:0] out_cos;

	sincos my_sc (out_sin,out_cos,in_sin,in_cos);

endmodule
