`define PORWAITSTATES 100 //was 24576000

module handle_pcm1804 (
        output reg [23:0] leftsample,
        output reg [23:0] rightsample,
        output reg        dataready,
        output            scki,
        output reg        bck,
        output reg        lrck,
        output reg        rst_,
        input             ext_osc,
        input             data,
        input             ovfl,
        input             ovfr
    );

    assign scki=ext_osc; // hopefully pll'd

    reg [23:0] shiftin_l;
    reg [23:0] shiftin_r;

    reg [6:0] lrck_ctr=0;// 128 states

    reg [4:0] bitctr=24;

    reg [31:0] por_ctr=`PORWAITSTATES;

    initial begin
        por_ctr<=`PORWAITSTATES;
        bitctr<=0;
        shiftin_l<=24'd0;
        shiftin_r<=24'd0;
        lrck_ctr<=16;
        lrck<=0;
        bck<=0;
        rst_<=1;

        dataready<=0;

    end

    // dont stop clocks during reset, adc needs them
    always @(negedge scki) begin
        bck=~bck;
        lrck_ctr=lrck_ctr-1;

        if (0==lrck_ctr) begin
            lrck=~lrck;
            lrck_ctr=64;
            bitctr=0;
            dataready=0;
        end

        if (0<por_ctr) begin
            rst_=0;
            por_ctr=por_ctr-1;
        end else rst_=1;
    end

    always @(posedge scki) begin
        if (rst_) begin // reset not asserted
            if (bitctr<24) begin
                if (1==lrck) shiftin_l[bitctr]<=data;
                else         shiftin_r[bitctr]<=data;
                bitctr=bitctr+1;
            end else begin
                if (1==lrck) leftsample <=shiftin_l;
                else         rightsample<=shiftin_r;

                dataready<=1;
            end
        end else begin // reset asserted
            bitctr=0;
            dataready=0;
        end
    end


endmodule
//-*- mode: Verilog; verilog-indent-level:4; indent-tabs-mode: nil; tab-width: 1 -*- // ??
