#!/usr/local/opt/python@3.9/libexec/bin/python

import math

# Configuration
LUT_SIZE = 4096 #128  # Number of LUT entries (1/4 cycle)
OUT_WIDTH = 14  # Bit width of sine values
MAX_VALUE = (2 ** OUT_WIDTH) - 1
MAG_VAL = (2 ** (OUT_WIDTH-1))-1
OFFSET = 0

# '%#2x' % (-34 & 0xffff)

print("-- input vals:  scaling i 0 to %d over 0 to 2*Pi" % LUT_SIZE)
print("-- output vals: scaling -1 to 1 over -%d to %d." % (MAG_VAL, MAG_VAL))

# Generate LUT values
lut_values = [
    # in: i 0 to LUT_SIZE over 0 to 2*pi
    # out: -1 to 1 over 1/2*max unsigned mag
    int((math.sin(2*math.pi*i/LUT_SIZE) + OFFSET) * MAG_VAL) for i in range(LUT_SIZE)
]

# Write to a memory file
with open("sin_lut.mem", "w") as f:
    for value in lut_values:
        #f.write(f"{value:04X}\n")  # Write in hexadecimal format
        # signed:
        wstr=f"%#02x\n" % (value & 0xffff)
        f.write(wstr[2:])

print("LUT file 'sin_lut.mem' generated.")

