`define POSPERCLK 8 // how far we increment the sin/cos position per clk
                    // carrier freq is POSPERCLK*clkfreq/256 (assuming
					     // 8-bit lookup tables)

module iqmod (
	dacval, // out: the value written to the dac
	i,      // in 
   q,      // in
	clk,    // in
   reset_  // in: active low
);

output [9:0] dacval;

input signed [7:0]  i;
input signed [7:0]  q;
input		        clk;
input               reset_;

reg [9:0]    dacval;
reg signed [15:0] dacfull;
reg [7:0]    tpos=0;

wire[7:0]    sin;
wire[7:0]    cos;

sincos the_sincos (sin,cos,tpos,tpos);

initial begin
	// really we don't care about startup values, but setting these makes the
	// debugging happy
	dacval=0;
	tpos=0;
end

always @(negedge clk) // calculate and set at falling edge (dac latches on posedge)
	begin
	
	if (reset_) // run
		begin
			// sin and cos go from 0 to 255 for simplicited, so we need to make them signed
			dacfull=(i*(cos-128))-(q*(sin-128));

			// scale to output range and make positive
			dacval=(dacfull/64)+512;
			tpos=tpos+`POSPERCLK;
		end
	else
		tpos=0;
	end
endmodule

