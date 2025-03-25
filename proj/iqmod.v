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
        output reg [13:0] dac_a,
        output wire [13:0] dac_b,
        output wire dac_led0a,
        output wire dac_led0b
    );

reg por_=0;
reg [31:0] porctr=`PORINIT;

reg blinken=0;
reg [31:0] blinkenctr=`BLINKEN;

assign dac_led0a=blinken;
assign dac_led0b=~blinken;

//assign led_0=0;
//assign led_0=reset_n;
//assign led_0=por_|reset_n;
assign led_0=blinken;
assign led_1=por_;

assign pmod2char=8'h7f;

assign dig_ena=3'd5; // lol
assign dig_seg=8'h00;


/*
wire [13:0] sin_in;
wire [13:0] sin_out;
reg [13:0] sinectr=14'd0;
assign sin_in=sinectr;
assign dac_b=sin_out;

sin_lut #( .IN_WIDTH(14), .OUT_WIDTH(14) )
    sin0(
        .in_val(sin_in),
        .out_val(sin_out));*/

wire [13:0] i_unsigned_out;
wire [13:0] q_unsigned_out;

complexsine csin0(
    .clk(mainclock),
    .i_mag(14'sd8000),
    .q_mag(14'sd8000),
    .i_unsigned_out(i_unsigned_out),
    .q_unsigned_out(q_unsigned_out));

assign dac_b=q_unsigned_out;

wire mainclock;
reg [7:0] clockdiv=8'h01;

assign mainclock=fpga_gclk;
//assign mainclock=e_rxc; // doesnt seem to run

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
	por_<=0;
	porctr<=`PORINIT;
    dac_a<=14'd0;
    //dac_b<=14'd2048;

	blinken=0;
	blinkenctr=`BLINKEN;
end

assign dac_clka=mainclock;
assign dac_clkb=mainclock;

//reg [15:0] sqctr=16'd0;

reg dirup_a=1'b1;
//reg dirup_b=1'b1;

always @(posedge mainclock) begin
	clockdiv<=clockdiv+8'h01;

	if (porctr) porctr<=porctr-32'd1;
	else por_<=1;

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

    if (por_) begin // not in reset state
        //if (sinectr>14'd10000) sinectr<=14'd6000;
        //else sinectr<=sinectr+14'd1;

        if (1==dirup_a) begin
            if (dac_a>({14{1'b1}}-14'd33)) begin
                dirup_a<=0;
            end else dac_a<=dac_a+14'd15;
        end else begin
            if (dac_a<14'd33) begin
                dirup_a<=1;
            end else dac_a<=dac_a-14'd15;
        end

        /*if (1==dirup_b) begin
            if (dac_b>({14{1'b1}}-14'd33)) begin
                dirup_b<=0;
            end else dac_b<=dac_b+14'd15;
        end else begin
            if (dac_b<14'd33) begin
                dirup_b<=1;
            end else dac_b<=dac_b-14'd15;
        end*/
    end else begin
        dac_a<=14'b00101111111111;
        //dac_b<=14'b00000000000000;
        //sqctr<=0;
        //sinectr<=14'd0;
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
