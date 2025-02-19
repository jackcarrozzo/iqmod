`timescale 1ns / 1ps

module tb_pcm1804;

    reg clock=0;

    initial begin
        $dumpvars;

        clock=1;

        #40000 $finish;
    end

    always #1 clock=!clock;

    /*wire [7:0] e_txd;
    wire e_txen;
    wire e_txer;
    wire e_gtxc;
    wire e_reset;

    gmii gmii0(e_txd,e_txen,e_txer,e_reset,clock,_reset);
    */


    wire ethclk;
    assign ethclk=clock; // 125 mhz gmii clk

	reg ext_osc=0; // 24.576 mhz , through ppl when hw
    reg [1:0] extosc_ctr=0;

    wire scki;
    wire bck;
    wire lrck;
    wire data;
    wire rst_;
    wire [23:0] ls;
    wire [23:0] rs;
    wire dataready;

   wire [7:0]  wrdata;
   wire [15:0] wraddr;
   wire        wrena;

    samplewriter swr0(
        .wrdata(wrdata),
        .wraddr(wraddr),
        .wrena(wrena),
        .ethclk(ethclk),
        .scki(scki),
        .bck(bck),
        .lrck(lrck),
        .leftsample(ls),
        .rightsample(rs),
        .dataready(dataready));

   wire [7:0]  rddata;
   wire [15:0] rdaddr;
   wire        rdclk;
   assign rdclk=ethclk;

    testram tram0(
                  .rddata(rddata),
                  .wrclk(bck),
                  .wraddr(wraddr),
                  .wrdata(wrdata),
                  .wrena(wrena),
                  .rdclk(rdclk),
                  .rdaddr(rdaddr));

    handle_pcm1804 handler0(
        .leftsample(ls),   // latched in at 25th (maybe 26th) seen data bit after lrck
        .rightsample(rs),  //   (which is fine becuase data ends bit 23, bck runs 32x before next lrck)
        .dataready(dataready),
        .ext_osc(ext_osc), // from (pll, from) external 24.576mhz osc
        .scki(scki),       // 24.576 mhz to pcm1804
        .bck(bck),         // 12.288 mhz to pcm1804
        .lrck(lrck),       // 192.00 khz to pcm1804
        .rst_(rst_),       // active low, from handler to pcm1804
        .data(data));      // data bit from pcm1804

    pcm1804 pcm0(
        .data(data),
        .scki(scki),
        .bck(bck),
        .lrck(lrck),
        .rst_(rst_));


   always @(negedge clock) begin
       if (0==extosc_ctr) begin
	       ext_osc=~ext_osc;
		   extosc_ctr=2;
	   end else begin
           extosc_ctr=extosc_ctr-1;
       end
   end

endmodule
