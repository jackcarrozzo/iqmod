module lfsr(
    input clk, 
    input rst, 
    output reg [7:0] op
);
  always@(posedge clk) begin
    if (rst) op <= 8'h15;
    else op = {op[7:0],(op[6]^op[2])};
  end
endmodule
