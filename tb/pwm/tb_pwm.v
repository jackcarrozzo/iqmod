`timescale 1ns / 1ps

module tb_pwm;

    reg clk=0;

    reg wr=0;

    initial begin
        $dumpvars;

        clk=0;
        wr=0;

        #2000000 wr=1;
        #2000001 wr=0;

        #4000000 $finish;
    end

    always #1 clk=!clk;

    reg [15:0] val=16'd50000;

    wire out;

    pwm pwm0(
        .clk(clk),
        .val(val),
        .wr(wr),
        .out(out));

endmodule
