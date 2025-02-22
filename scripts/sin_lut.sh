#!/bin/bash

echo "module sinquarter (
	input wire [15:0] theta,
	output wire [13:0] sinval
);

reg [13:0] sin_lut [0:65535];

initial begin
" >/tmp/sin_lut.v

perl -e '$max=2**16;for ($i=0;$i<$max;$i++) { printf("sinlut[$i] = 14d%.0f;\n", (2**13)*sin((3.14159/2)*$i/$max)); }'|sed s/14d/14\'d/ >> /tmp/sin_lut.v

echo "end" >>/tmp/sin_lut.v
echo "endmodule" >>/tmp/sin_lut.v


cat /tmp/sin_lut.v

