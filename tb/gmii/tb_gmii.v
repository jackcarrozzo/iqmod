`timescale 1ns / 1ps

module tb_gmii;

	reg _reset=1;
	reg clock=0;

	initial begin
		$dumpvars;

		_reset=0;
		clock=1;

		#20 _reset=1;

		#40000 $finish;
	end

	always #1 clock=!clock;

	wire [7:0] e_txd;
	wire e_txen;
	wire e_txer;
	wire e_gtxc;
	wire e_reset;

	gmii gmii0(e_txd,e_txen,e_txer,e_reset,clock,_reset);
endmodule
