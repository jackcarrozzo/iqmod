module sinmult (
    input wire [11:0] theta,
    input wire signed [13:0] coef,
    output wire signed [13:0] outsigned,
    output wire [13:0] outunsigned);


    //reg signed [13:0] coef=14'b01111111111111;
    //reg signed [13:0] coef=14'b10000000000000;
    wire signed [27:0] accum;
    wire signed [13:0] accum_top;

    wire signed [13:0] sin_outval;
    wire [13:0] sin_outunsigned;

    assign accum=coef * sin_outval;
    assign accum_top=accum[27:14];

    assign outsigned=accum[27:14];
    assign outunsigned=accum_top+14'sd8192;

    fullsine_lut sin0(
        .in_val(theta),
        .out_val(sin_outval),
        .uint_val(sin_outunsigned));

    

endmodule
