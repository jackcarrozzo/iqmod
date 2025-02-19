/*
   for each pcm1804handler:
     - read each sample when ready into ram, inc ptr
     - something
     - udp checksum etc
     - gmii tx






     - extra pts / next rev:
       - min, max, avg for each ch, resettable at packet tx,
          included in status part of packet payload as
          vp-p, dc offset, filter bank response...

 */

module samplewriter (
    output reg [7:0]  wrdata,
    output reg [15:0] wraddr,
    output reg        wrena,
    input             ethclk,
    input             scki,
    input             bck,
    input             lrck,
    input [23:0]      leftsample,
    input [23:0]      rightsample,
    input             dataready);

    reg [1:0]          bytestate;

	// TODO: when wraddr > whatever, udp check and send the packet

    initial begin
       wraddr=45;
       wrena=0;
       bytestate=0;
    end

    // ram writes on rising bck edge i guess

    always @(negedge bck) begin
        if ((1==dataready)&&(3>bytestate)) begin
            if (0==bytestate) begin
                wrdata<=(1==lrck)?leftsample[7:0]:rightsample[7:0];
            end else if (1==bytestate) begin
                wrdata<=(1==lrck)?leftsample[15:8]:rightsample[15:8];
            end else if (2==bytestate) begin
                wrdata<=(1==lrck)?leftsample[23:16]:rightsample[23:16];
            end

			wrena<=1;
			wraddr<=wraddr+1;
            bytestate<=bytestate+1;
        end else begin
            wrena<=0;
		end
    end

	always @(lrck) bytestate<=0;
endmodule
