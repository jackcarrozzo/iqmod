/*
 - of general notice, gmii updates state, increments paddr, and sets e_txd<=pdata on negedge ethclk
       - TODO: is this fucked up and should hapen as two phases?
 -     - is the expected behavior clocked, and the NEXT data value is picked up? or fast feedthru?

 */

module testram (
                output [7:0] rddata, // ram[addr] latched into rddata on rising clk edges
                input        wrclk,
                input [15:0] wraddr,
                input [7:0]  wrdata,
                input        wrena, // writes on rising edge of clk when wrena=1 (TODO: confirm phase)
                input        rdclk,
                input [15:0] rdaddr
                );


   reg [7:0]                 ramdata [0:65535];

   assign rddata=ramdata[wraddr];

   initial begin
      ramdata[0]<=8'd0;
      ramdata[65535]<=8'd0;
   end

   always @(posedge wrclk) begin
      if (wrena) begin
         ramdata[wraddr]<=wrdata;
         //$display("ip header checksum: 0x%2h (0x%4h)", ip_checksum[15:0], ip_checksum);
         $display("- ram write to addr 0x%2h: 0x%1h", wraddr, wrdata);
      end
   end

   /*always @(posedge rdclk) begin
      rddata<=ramdata[rdaddr];
   end*/

endmodule
