module dac5672 (
  input wire clka,
  input wire clkb,
  input wire wrta,
  input wire wrtb,
  input wire [13:0] dataa,
  input wire [13:0] datab
);

// do nothing for tb (replaced by real device)

reg [31:0] chillctr;

initial begin
  chillctr = 32'd0;
end

always @(posedge clka or posedge clkb) begin
    chillctr <= (wrta & dataa) + (wrtb & datab);
end
endmodule
