module modulator (
	dacval, // out: the value written to the dac
	locked, //out
	clk,    // in
   reset_  // in: active low
);

output [9:0] dacval;
output locked;

input		 clk;
input     reset_;

reg [9:0]    dac;
reg [7:0]    i;
reg [7:0]    q;
reg			 pllena;
reg          areset;

wire runclk;

iqmod myiq(dacval,i,q,runclk,reset_);
thepll mypll(areset,clk,pllena,runclk,locked);

initial begin
	i=8'hff;
	q=8'h00;
	pllena=1;
	areset=1;
end

endmodule

