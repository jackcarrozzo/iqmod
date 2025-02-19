`timescale 1ns / 1ps

module tb_iqmod;

    reg _reset=1;
    reg clock=0;

    initial begin
        $dumpvars;

        _reset=0;
        clock=1;

        #20 _reset=1;

        #40000 $finish;
    end

    always #1 clock=!clock;

    basics basicwrapper(
        .clock(clock),
        ._reset(_reset));

endmodule
