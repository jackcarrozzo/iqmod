module sincos_tb;

	initial begin
		$dumpvars;

		clock=1;
		#300 $finish;

		//t=0;
		//i=15;
		//q=8;
	end

	reg clock;
	reg [4:0] t=0;
	reg [3:0] i=15;
	reg [3:0] q=8;

	always #1 clock = !clock;
	always #1 t=t+1;

	wire [8:0] icos;
	wire [8:0] qsin;

	sincos sc0(icos,qsin,t,i,q);

endmodule
