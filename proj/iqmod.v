`timescale 1ns / 1ps
`define PORINIT 32'd125000000
`define BLINKEN 32'd75000000

module iqmod(
		input reset_n, // SW4 at P3
		input  fpga_gclk, // G1
        input  e_rxc, // 125mhz from gmii at D22
		output led_0, // active low
        output led_1, // D5 and D6 on cyclone4st
        output [7:0] pmod2char,
	    output [2:0] dig_ena,
        output [7:0] dig_seig,
        output wire dac_clka,
        output wire dac_clkb,
        output wire dac_wrta,
        output wire dac_wrtb,
        output wire [13:0] dac_a,
        output wire [13:0] dac_b
    );

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

assign mainclock=e_rxc;


dacbasics dacctl(
    .clock(mainclock),
    ._reset(por_),
    .clka(dac_clka),
    .clkb(dac_clkb),
    .wrta(dac_wrta),
    .wrtb(dac_wrtb),
    .dataa(dac_a),
    .datab(dac_b));

initial begin
	por_=0;
	porctr=`PORINIT;

	blinken=0;
	blinkenctr=`BLINKEN;
end

always @(negedge e_rxc) begin
	clockdiv<=clockdiv+8'h01;

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
