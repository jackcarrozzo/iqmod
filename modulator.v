module modulator (
	dacval, // out: the value written to the dac
	loclk,  // out: local osc for mixer
	synthclk, // out: clk to the dac
	locked, //out
	clk    // in
);

output [9:0] dacval;
output synthclk;
output loclk;
output locked;

input		 clk;

reg [3:0]   i;
reg [3:0]   q;

reg					pllena;
reg      		areset;

iqmod iq0(dacval,i,q,synthclk);
thepll pll0(areset,clk,pllena,synthclk,loclk,locked);

initial begin
	i=15;
	q=0;

	pllena=1;
	areset=0;
end

endmodule

