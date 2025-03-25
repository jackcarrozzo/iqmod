
VERILATOR = verilator
CPP       = g++
CFLAGS    = -O2 -Wall

.PHONY: all clean

all: sim

sim: obj_dir/Vcsin
	./obj_dir/Vcsin

obj_dir/Vcsin: csin.v test_csin.cpp
	$(VERILATOR) --cc csin.v --trace --exe test_csin.cpp #--Wno-WIDTHTRUNC
	make -C obj_dir -f Vcsin.mk Vcsin

show:
	#gtkwave dump.vcd 2>&1 >/dev/null &
	#/Applications/gtkwave.app/Contents/Resources/bin/gtkwave dump.vcd 2>&1 >/dev/null &
	~/build/oss-cad-suite-build/oss-cad-suite/bin/gtkwave waveform.vcd 2>&1 >/dev/null &

clean:
	rm -rf obj_dir waveform.vcd

