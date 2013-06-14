module modulator (
	dacval, // out: the value written to the dac
	loclk,  // out: local osc for mixer
	synthclk, // out: clk to the dac
	pll_locked, //out
	usb_rd_, // out: ftdi 
	usb_wr,  // out: ftdi
	status,  //out: status liights
	clk,    // in
	usb_bus, // in from ftdi: databus
	usb_txe_, // ftdi ready to transmid
	usb_rxf_ // ftdi ready for read 
);

output [9:0] 	dacval;
output 				synthclk;
output 				loclk;
output 				pll_locked;
output 				usb_rd_;
output 				usb_wr;
output [7:0]  status;

input		 		clk;
input [7:0] usb_bus;
input 			usb_txe_;
input				usb_rxf_;

reg [3:0]   i;
reg [3:0]   q;
wire [7:0]		usbval;
reg [7:0] 	status;

reg					pllena;
reg      		areset;

wire [7:0] 	usb_bus;
wire 				usb_rd_;
wire 				usb_wr;
wire 				usb_txe_;
wire 				usb_rxf_;

iqmod iq0(dacval,i,q,synthclk);
thepll pll0(areset,clk,pllena,synthclk,loclk,pll_locked);
ft245r_fifo ftdi0(usbval,usb_rd_,usb_wr,usb_bus,usb_txe_,usb_rxf_,clk);

initial begin
	i=15;
	q=7;

	status=8'hff;

	pllena=1;
	areset=0;
end

reg [31:0] c;
always @(posedge clk) // send am 1khz tone
	begin
		c=c+1;
		if (c>=50000)
			begin
				c=0;
				status=~status;
				i=7+status[2:0];
			end
	end

//always @(usbval)
//	begin
//		i=usbval[7:4];
//		q=usbval[3:0];
//	end

endmodule

