`timescale 1ns / 1ps

module basics(
    input wire clock,
    input wire _reset);

    reg [13:0] val_a;
    reg [13:0] val_b;

    initial begin
        val_a<=14'd0;
        val_b<=14'b10000000000000;
    end

    dac5672 dac0(
        .wrta(clock),
        .wrtb(clock),
        .clka(clock),
        .clkb(clock),
        .dataa(val_a),
        .datab(val_b));

    always @(posedge clock) begin
        if (!_reset) begin
            val_a <= 14'd0;
            val_b <= 14'b10000000000000;
        end else begin
            val_a <= val_a+14'd1;
            val_b <= val_b+14'd1;
        end
    end

endmodule
