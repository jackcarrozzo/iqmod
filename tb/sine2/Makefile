
VERILATOR = verilator
CPP       = g++
CFLAGS    = -O2 -Wall

.PHONY: all clean

all: sim

sim: obj_dir/Vfullsine_lut
	./obj_dir/Vfullsine_lut

obj_dir/Vfullsine_lut: fullsine_lut.v test_sin.cpp
	$(VERILATOR) --cc fullsine_lut.v --exe test_sin.cpp --Wno-WIDTHTRUNC
	make -C obj_dir -f Vfullsine_lut.mk Vfullsine_lut

clean:
	rm -rf obj_dir

