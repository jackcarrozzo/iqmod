module pwm(
    input clk,
    input [15:0] val,
    input wr,
    output reg out);


// 200mhz / 64k =~= 3khz

    reg [15:0] currval=16'd10000;
    reg [15:0] pwmctr=16'd0;

    initial begin
        currval=16'd10000;
        pwmctr=16'd0;
    end

    always @(posedge clk) begin
        pwmctr=pwmctr+16'd1;

        out=(pwmctr<currval);

        if (wr) currval=val;
    end

endmodule
