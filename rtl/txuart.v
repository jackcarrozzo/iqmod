module txuart (
  input wire sck,
  input wire [7:0] indata,
  input wire dwr,
  input wire reset_,
  output reg busy,
  output reg sout
);

reg [7:0] bitind; //size
reg [7:0] state; //size

reg [7:0] txdata;
reg [7:0] int;

reg [2:0] chillctr;

initial begin
  bitind = 0;
  state = 0;
  txdata = 8'h63;
  chillctr = 0;

  sout = 1;
  busy = 0;
end

//always @(posedge dwr) int<=indata;
//always @(posedge dwr) txdata<=8'h46;
//always @(posedge dwr) txdata<=indata;

// reminder, lsb first

// 0 waiting for data
// 1 start bit
// 2 data bits
// 3 stop bit
// 4 reset

always @(posedge sck or negedge reset_) begin
  if (!reset_) begin
    state <= 0;
    bitind <= 0;

    sout <= 1;
    busy <= 0;
  end else begin
    case (state)
      0: if (dwr) begin
        txdata <= indata;
        //txdata<=8'h41;
				busy <= 1;
        state <= 1;
      end
      1: begin
        sout <= 0; // start bit
        state <= 2;
        bitind <= 0;
      end
      2: begin
        sout <= txdata[bitind]; // data bit
        if (7 == bitind) state <= 3;
        else bitind <= bitind + 8'd1;
      end
      3: begin
        sout <= 1; // stop bit
        state <= 4;
        chillctr <= 3'b111;
      end
      4: begin
        if (!chillctr) begin
          state <= 0;
          busy <= 0;
          bitind <= 0;
					//txdata<=8'h45;
					//txdata<=int;
        end else begin
          chillctr <= chillctr - 3'd1;
        end
      end
    endcase
  end
end

endmodule
