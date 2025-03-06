`timescale 1ns / 1ps

module tb_sine;
    reg _reset=1;
    reg clock=0;

    initial begin
        $dumpvars;

        _reset=0;
        clock=1;

        #20 _reset=1;

        #400000 $finish;
    end

    always #1 clock=!clock;

    wire signed [13:0] sinval;
    wire [15:0] sincentered;
    assign sincentered=16'd32768+sinval;
    reg [17:0] theta=18'd0;

    sine sine0(
        .theta(theta),
        .sinval(sinval));

    always @(posedge clock) theta<=theta+18'd16;
endmodule
