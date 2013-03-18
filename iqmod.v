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

input [7:0]  i;
input [7:0]  q;
input		 clk;
input        reset_;

reg [9:0]    dacval;
reg [7:0]    tpos = 8'h00;
reg [15:0]   inphase;
reg [15:0]   outphase;

wire[7:0]    sin;
wire[7:0]    cos;

sincos the_sincos (sin,cos,tpos,tpos);

initial begin
	dacval=8'h00;
end

always @(negedge clk) // calculate and set at falling edge (dac latches on posedge)
	begin
	
	if (reset_) // run
		begin
			inphase =i*cos[7:1];
			outphase=q*sin[7:1];

			dacval=512+inphase[15:6]-outphase[15:6];
			tpos=tpos+`POSPERCLK;
		end
	else
		tpos=0;
	end
endmodule

