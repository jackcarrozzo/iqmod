`timescale 1ns / 1ps

module dacbasics(
    input wire clock,
    input wire _reset,
    output wire clka,
    output wire clkb,
    output wire wrta,
    output wire wrtb,
    output reg [13:0] dataa,
    output reg [13:0] datab);

    reg clkena=1'b1;

    initial begin
        dataa<=14'd0;
        datab<=14'b10000000000000;
    
        clkena<=1'b1;
    end

    assign clka=clock & clkena;
    assign clkb=clock & clkena;
    assign wrta=clock & clkena;
    assign wrtb=clock & clkena;

    // dac latches on rising edge WRTn and CLKn
    always @(negedge clock) begin
        if (!_reset) begin
            dataa <= 14'd0;
            datab <= 14'b10000000000000;

            clkena<=1'b0;
        end else begin
            dataa <= dataa+14'd1;
            datab <= datab+14'd1;

            clkena<=1'b1;
        end
    end

endmodule
