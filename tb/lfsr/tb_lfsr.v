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

    wire [7:0] out;
    wire outbit;
    assign outbit=out[0];
    wire topbit;
    assign topbit=out[7];

    wire reset;
    assign reset=!_reset;

    lfsr u0(
        .clk(clock),
        .rst(reset),
        .op(out));

endmodule
