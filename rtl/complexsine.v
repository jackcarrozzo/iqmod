`timescale 1ns / 1ps
module complexsine (
    input wire clk,
    input wire signed [13:0] i_mag,
    input wire signed [13:0] q_mag,
    output wire [13:0] i_unsigned_out,
    output wire [13:0] q_unsigned_out);

    wire [11:0] omega=12'd100;

    // sines are 0 to 2*Pi mapped over 0 - 2**12
    // omega- amount we move through the wave per sample over 0-2**12
    //   1 is 2**12 ticks per wave
    //   2**12 is 1 tick per wave
    

    reg pos_freq=1'b1;

    reg [11:0]  i_theta;
    wire [11:0] q_theta;
    // q is 1/4 behind if pos_freq, else 1/4 in front
    assign q_theta=(1==pos_freq)?i_theta-12'd1024:i_theta+12'd1024;

    always @(posedge clk) begin
        i_theta<=i_theta+omega;
    end

    wire [13:0] i_sin_out;
    wire [13:0] q_sin_out;
    wire [13:0] i_sin_uint;
    wire [13:0] q_sin_uint;

    fullsine_lut isine(
        .in_val(i_theta),
        .out_val(i_sin_out),
        .uint_val(i_sin_uint));

    fullsine_lut qsine(
        .in_val(q_theta),
        .out_val(q_sin_out),
        .uint_val(q_sin_uint));

    //reg signed [13:0] coef=14'b01111111111111;
    //reg signed [13:0] coef=14'b10000000000000;
    wire signed [27:0] i_accum;
    wire signed [13:0] i_accum_top;
    wire signed [27:0] q_accum;
    wire signed [13:0] q_accum_top;
    
    assign i_accum=i_mag * i_sin_out;
    assign i_accum_top=i_accum[27:14];

    assign q_accum=q_mag * q_sin_out;
    assign q_accum_top=q_accum[27:14];

    // assign i_signed_out=i_accum_top;
    //assign i_unsigned_out=i_accum_top+14'sd8192;
    wire [13:0] i_unsigned_out_halfsize;
    assign i_unsigned_out_halfsize=(i_accum_top>14'd4000)?i_accum_top-14'd4000:i_accum_top+14'd4096;
    assign i_unsigned_out={i_unsigned_out_halfsize[12:0],1'b0};

    // assign q_signed_out=q_accum_top;
    //assign q_unsigned_out=(q_accum_top>14'd4000)?q_accum_top-14'd4000:q_accum_top+14'd8192;
    wire [13:0] q_unsigned_out_halfsize;
    assign q_unsigned_out_halfsize=(q_accum_top>14'd4000)?q_accum_top-14'd4000:q_accum_top+14'd4096;
    assign q_unsigned_out={q_unsigned_out_halfsize[12:0],1'b0};

endmodule
