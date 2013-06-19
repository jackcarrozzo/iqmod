`define POSPERCLK 5'd2 // how far we increment the sin/cos position per clk

module iqcalc (
	dacval, // out: the value written to the dac
	i,      // in 
  q,      // in
	clk     // in: this needs to be the same clock sent to the DAC
);

output [9:0] dacval;

input [`IQMSB:0]  i;
input [`IQMSB:0]  q;
input	       			clk;

reg [9:0]    dacval;
reg [4:0]    tphase;  // 32 values, wraps

wire signed [8:0] icos;
wire signed [8:0] qsin;

sincos sincos0(icos,qsin,tphase,i,q);

initial begin
	dacval=10'd512; // center
	tphase=0;
end

always @(negedge clk) // calculate and set at falling edge (dac latches on posedge)
	begin
		dacval=10'sd512+icos-qsin;
		tphase=tphase+`POSPERCLK;
	end

endmodule

