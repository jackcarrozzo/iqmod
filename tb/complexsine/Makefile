
VERILATOR = verilator
CPP       = g++
CFLAGS    =  -Wall
# -O2

.PHONY: all clean

all: sim

sim: obj_dir/Vcomplexsine
	./obj_dir/Vcomplexsine

#--Wno-WIDTHTRUNC
obj_dir/Vcomplexsine: complexsine.v test_complexsine.cpp
	$(VERILATOR) --cc complexsine.v --trace --timing --exe test_complexsine.cpp
	make -C obj_dir -f Vcomplexsine.mk Vcomplexsine

show:
	#gtkwave dump.vcd 2>&1 >/dev/null &
	#/Applications/gtkwave.app/Contents/Resources/bin/gtkwave dump.vcd 2>&1 >/dev/null &
	~/build/oss-cad-suite-build/oss-cad-suite/bin/gtkwave waveform.vcd 2>&1 >/dev/null &

clean:
	rm -rf obj_dir

