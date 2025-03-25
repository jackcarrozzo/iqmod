module sin_lut #(
    parameter IN_WIDTH = 12,   // Input bit width (unsigned, maps to [0, 2π])
    parameter OUT_WIDTH = 14, // Output bit width (mapped [0, 2^OUT_WIDTH])
    parameter LUT_SIZE = 4096  // Number of LUT entries (1/4 cycle)
)(
    input  [IN_WIDTH-1:0] in_val,  // Input angle
    output [OUT_WIDTH-1:0] out_val // Scaled sine output
);

    // LUT containing precomputed sin values for the first quadrant (0 to pi/2)
    reg [OUT_WIDTH-1:0] lut [0:LUT_SIZE-1];

    // Load LUT from file
    initial begin
        $readmemh("sin_lut.mem", lut);
    end

    wire [1:0] quadrant;
    wire [$clog2(LUT_SIZE)-1:0] raw_index;

    assign quadrant = in_val[IN_WIDTH-1:IN_WIDTH-2]; // Extract quadrant
    assign raw_index = in_val[IN_WIDTH-3 -: $clog2(LUT_SIZE)]; // Ensure correct index width

    reg [OUT_WIDTH-1:0] sin_value;
    always @(*) begin
        case (quadrant)
            2'b00: sin_value = lut[raw_index];                 // 1st quadrant
            2'b01: sin_value = lut[LUT_SIZE - 1 - raw_index];  // 2nd quadrant (mirror)
            2'b10: sin_value = (2**(OUT_WIDTH-1) - 1) - lut[raw_index]; // 3rd quadrant (invert)
            2'b11: sin_value = (2**(OUT_WIDTH-1) - 1) - lut[LUT_SIZE - 1 - raw_index]; // 4th quadrant (mirror & invert)
        endcase
    end

    assign out_val = sin_value;

endmodule

