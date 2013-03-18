module modulator (
	dacval, // out: the value written to the dac
	loclk,  // out: local osc
	synthclk, // out: clk to the dac
	locked, //out
	clk,    // in
   reset_  // in: active low
);

output [9:0] dacval;
output synthclk;
output loclk;
output locked;

input		 clk;
input     reset_;

reg [7:0]    i;
reg [7:0]    q;
reg			 pllena;
reg          areset;

iqmod myiq(dacval,i,q,runclk,reset_);
thepll mypll(areset,clk,pllena,synthclk,loclk,locked);

initial begin
	i=127;
	q=0;
	pllena=1;
	areset=0;
end

endmodule

