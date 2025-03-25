`timescale 1ns / 1ps
module fullsine_lut #(
    parameter IN_WIDTH = 12,
    parameter OUT_WIDTH = 14,
    parameter LUT_SIZE = 4096
)(
    input [IN_WIDTH-1:0] in_val,
    output wire signed [OUT_WIDTH-1:0] out_val,
    output wire [OUT_WIDTH-1:0] uint_val
);
    //wire [OUT_WIDTH-1:0] uint_val;
    //assign uint_val=out_val+14'sd8192;
    assign uint_val=out_val+14'sd10;

    reg signed [OUT_WIDTH-1:0] lut [0:LUT_SIZE-1];

    initial begin
        $readmemh("sin_lut.mem", lut);
    end

    assign out_val=lut[in_val];
endmodule
