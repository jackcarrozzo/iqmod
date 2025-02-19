`timescale 1ns / 1ps
`define PORINIT 32'd125000000
`define BLINKEN 32'd75000000

module iqmod(
		input reset_n,
		input  fpga_gclk,
		output e_reset,
		output e_mdc,
		inout  e_mdio,

		input  e_rxc,                       //125Mhz ethernet gmii rx clock
		input  e_rxdv,
		input  e_rxer,
		input  [7:0] e_rxd,

		input  e_txc,                     //25Mhz ethernet mii tx clock         
		output e_gtxc,                    //25Mhz ethernet gmii tx clock  
		output e_txen,
		//output e_txer,
		output [7:0] e_txd,

		output led_0, // active low
        output led_1, // D5 and D6 on cyclone4st
		output p_e_reset,
		output p_e_txen,
		output p_e_gtxc,
		//output [7:0] p_e_txd,
		//output [4:0] dbleds,
        output [7:0] pmod2char,
	    output [2:0] dig_ena,
        output [7:0] dig_seg
    );

assign p_e_reset=e_reset;
assign p_e_txen=e_txen;
assign p_e_gtxc=e_gtxc;

//assign p_e_txd=e_txd;
//reg [7:0] dbg_p8_reg=8'h00;
//assign p_e_txd=dbg_p8_reg;

/*reg [7:0] t1=8'h01;
reg [7:0] t2=8'h02;
reg [7:0] t3=8'h03;
reg [7:0] t4=8'h04;
wire [31:0] widebus;
assign widebus={t4,t3,t2,t1};
reg [1:0] wb_offset=2'd0;*/

reg por_=0;
reg [31:0] porctr=`PORINIT;

reg blinken=0;
reg [31:0] blinkenctr=`BLINKEN;


//assign led_0=0;
//assign led_0=reset_n;
//assign led_0=por_|reset_n;
assign led_0=blinken;
assign led_1=por_;

assign pmod2char=8'h7f;

assign dig_ena=3'd5; // lol
assign dig_seg=8'h00;


wire mainclock;
reg [7:0] clockdiv=8'h01;

//assign e_gtxc=e_rxc;
//assign mainclock=clockdiv[4];
assign mainclock=e_rxc;

assign e_gtxc=mainclock;

gmii gmii0(
	.e_txd(e_txd),
	.e_txen(e_txen),
	.e_txer(e_txer),
	.e_reset(e_reset),
	.clk(mainclock),
	._rst(por_)
);

reg ram_wrena; // write enable
reg [11:0] ram_wraddr;
reg [11:0] ram_rdaddr;
reg [7:0] ram_wrdata;
wire [7:0] ram_rddata;
reg ram_clk;

//////////ram?~T??~N?~X?~B?以太?~Q?~N??~T??~H??~Z~D?~U??~M??~H~V?~K?~U?~U??~M?///////////////////
ram ram_inst (
  .wrclock(ram_clk),       // input write clock
  .wren(ram_wrena),                // input [0 : 0] ram write enable
  .wraddress(ram_wraddr),         // input [8 : 0] ram write address
  .data(ram_wrdata),               // input [31 : 0] ram write data
  .rdclock(ram_clk),       // input read clock
  .rdaddress(ram_rdaddr),   // input [8 : 0] ram read address
  .q(ram_rddata)            // output [31 : 0] ram read data
);

initial begin
	por_=0;
	porctr=`PORINIT;

	blinken=0;
	blinkenctr=`BLINKEN;

	// was 512 x 32 = 16384
	//ram_wrena=0;
	//ram_rdaddr=9'h00;
	//ram_wraddr=9'h08;
	//ram_wrdata=32'h00000000;

	// should fit 2048 x 8 = 16384
	//ram_wrena=0;
  //ram_rdaddr=10'h00;
  //ram_wraddr=10'h08;
  //ram_wrdata=8'h00;

	// numwords=4096
	ram_wrena=0;
  ram_rdaddr=11'h00;
  ram_wraddr=11'h08;
  ram_wrdata=8'h00;

	ram_clk=1'b0;
	
end

always @(negedge e_rxc) begin
	clockdiv<=clockdiv+8'h01;
	ram_clk<=0;

	if (porctr) porctr<=porctr-32'd1;
	else por_<=1;

	if (blinkenctr) blinkenctr<=blinkenctr-32'd1;
	else begin
		blinken<=~blinken;
		blinkenctr<=`BLINKEN;
	end
end

always @(posedge fpga_gclk) begin
    //p_e_txd<=widebus[(wb_offset+7):wb_offset];
    //dbg_p8_reg<=widebus[wb_offset:0];    
    
    /*if (2'd0==wb_offset) begin
        dbg_p8_reg<=widebus[7:0];
    end else if (2'd1==wb_offset) begin
        dbg_p8_reg<=widebus[15:8];
    end else begin
        dbg_p8_reg<=widebus[23:16];
     end

    wb_offset<=wb_offset+1;*/
end

endmodule
