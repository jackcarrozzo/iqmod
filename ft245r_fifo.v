`define CLKSPERSYM 1000 // set i+q after this many clock cycles

module ft245r_fifo (
	i,      // out 
	q,      // out
	rd_,	// out: read strobe (
	wr,		// out: write strobe
	usbdata,// in: the data bus from the ft245r
	txe_,   // in: tx enable (when high, dont write)
	rxf_,	// in: read ready (when high, dont read)
	clk     // in
);

output signed [7:0]  i;
output signed [7:0]  q;
output rd_;
output wr;

input [7:0] usbdata;
input txe_;
input rxf_;
input clk;

reg [15:0] counter=0;
reg [2:0] state=0;

reg	readval=0; // 0 i, 1 q

wire[7:0] i;
wire[7:0] q;

initial begin
	// generate a carrier at least
	i=127;
	q=0;
	readval=0;
end

always @(negedge clk) begin
	counter=counter+1;

	if counter==`CLKSPERSYM begin
		counter=0;

		// http://www.mouser.com/ds/2/163/DS_FT245R-19492.pdf
		// pg 13			
		case (state)
			0: begin // start. if !rxf, clear rd_
				if (0==rxf_) begin
					rd_=0;
					state=1;
				end
			end
			1: begin // wait for clk
				state=2;
			end
			2: begin // fetch value
				if (readval) q=usbdata;
				else 		 i=usbdata;

				readval=~readval;
				state=3;
			end
			3: begin // set rd_
				rd_=1;
				state=0;
			end
		endcase
	end
endmodule

