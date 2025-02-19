/*
    - in left-justified mode, fmt[1:0] both low:
        - lrck edges occur at falling bck
        - adc data changes at falling bck, should be sampled at rising
        - data bits arrive starting at bit 0, shifting to bit 23, then
            continuing a bit, like 8 (32 bits of bck per chan = fs * 64)
*/

module pcm1804 (
        output  data,
        output reg ovfl,
        output reg ovfr,
        input      scki, // 24.576 mhz, fs * 128
        input      bck,  // 12.288 mhz, fs * 64, scki / 2
        input      lrck, // fs, 192 khz, scki / 128
        input      bypas,// hpf / dc remove
        input      rst_
    );

    assign data=lrck;

endmodule
