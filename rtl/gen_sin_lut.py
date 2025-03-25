import math

# Configuration
LUT_SIZE = 4096 #128  # Number of LUT entries (1/4 cycle)
OUT_WIDTH = 14  # Bit width of sine values
MAX_VALUE = (2 ** OUT_WIDTH) - 1
mag=((2 ** OUT_WIDTH)/2) - 1
offset=(2 ** OUT_WIDTH)

# Generate LUT values
lut_values = [
    #int((math.sin(math.pi / 2 * i / LUT_SIZE) + 0) * MAX_VALUE) for i in range(LUT_SIZE)
    int((math.sin(math.pi / 2 * i / LUT_SIZE) + offset) * mag) for i in range(LUT_SIZE)
]

# Write to a memory file
with open("sin_lut.mem", "w") as f:
    for value in lut_values:
        f.write(f"{value:04X}\n")  # Write in hexadecimal format

print("LUT file 'sin_lut.mem' generated.")

