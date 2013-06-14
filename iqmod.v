`define POSPERCLK 5'd2 // how far we increment the sin/cos position per clk

module iqmod (
	dacval, // out: the value written to the dac
	i,      // in 
  q,      // in
	clk    // in
);

output [9:0] dacval;

input [3:0]  i;
input [3:0]  q;
input	       clk;

reg [9:0]    dacval;
reg [4:0]    tpos;  // 32 values, wraps

wire signed [8:0] icos;
wire signed [8:0] qsin;

sincos the_sincos (icos,qsin,tpos,i,q);

initial begin
	dacval=512;
	tpos=0;
end

always @(negedge clk) // calculate and set at falling edge (dac latches on posedge)
	begin
		dacval=512+icos-qsin;
		tpos=tpos+`POSPERCLK;
	end

endmodule

