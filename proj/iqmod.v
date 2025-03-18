`timescale 1ns / 1ps
`define PORINIT 32'd125000000
`define BLINKEN 32'd75000000

module iqmod(
		input reset_n, // SW4 at P3
		input  fpga_gclk, // G1
        input  e_rxc, // 125mhz from gmii at D22
		output led_0, // active low
        output led_1, // D5 and D6 on cyclone4st
        output wire [7:0] pmod2char,
	    output wire [2:0] dig_ena,
        output wire [7:0] dig_seg,
        output wire dac_clka,
        output wire dac_clkb,
        output wire dac_wrta,
        output wire dac_wrtb,
        output reg [13:0] dac_a,
        output reg [13:0] dac_b
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

assign mainclock=fpga_gclk;


/*dacbasics dacctl(
    .clock(e_rxc),
    ._reset(por_),
    .clka(dac_clka),
    .clkb(dac_clkb),
    .wrta(dac_wrta),
    .wrtb(dac_wrtb),
    .dataa(dac_a),
    .datab(dac_b));
*/

initial begin
	por_=0;
	porctr=`PORINIT;
    dac_a=14'd0;
    dac_b=14'd2048;

	blinken=0;
	blinkenctr=`BLINKEN;
end

assign dac_wrta=mainclock;
assign dac_wrtb=mainclock;
assign dac_clka=mainclock;
assign dac_clkb=mainclock;

reg [15:0] sqctr=16'd0;

always @(negedge mainclock) begin
	clockdiv<=clockdiv+8'h01;

	if (porctr) porctr=porctr-32'd1;
	else por_=1;

	if (blinkenctr) blinkenctr<=blinkenctr-32'd1;
	else begin
		if (por_) blinken<=~blinken;
		blinkenctr<=`BLINKEN;
	end

    // 1 - 1.8khz about
    
    // with e_rxc, 4111 gives 31.389 mhz
    // 2111 ~ 16mhz
    // 411 ~ 3mhz
    //dac_a<=dac_a+14'd7;
    //dac_b<=dac_b+14'd7;

    if (por_) begin
        if (sqctr[7]==1'b0) begin
            dac_a=~dac_a;
            dac_b=~dac_b;
        end

        sqctr=sqctr+16'd1;
    end else begin
        dac_a=14'b11111111111111;
        dac_b=14'b00000000000000;
        sqctr=0;
    end

end

//always @(posedge fpga_gclk) begin
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
//end

endmodule
