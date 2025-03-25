
VERILATOR = verilator
CPP       = g++
CFLAGS    = -O2 -Wall

.PHONY: all clean

all: sim

sim: obj_dir/Vsinmult
	./obj_dir/Vsinmult

obj_dir/Vsinmult: sinmult.v test_sinmult.cpp
	$(VERILATOR) --cc sinmult.v --trace --exe test_sinmult.cpp #--Wno-WIDTHTRUNC
	make -C obj_dir -f Vsinmult.mk Vsinmult

show:
	#gtkwave dump.vcd 2>&1 >/dev/null &
	#/Applications/gtkwave.app/Contents/Resources/bin/gtkwave dump.vcd 2>&1 >/dev/null &
	~/build/oss-cad-suite-build/oss-cad-suite/bin/gtkwave waveform.vcd 2>&1 >/dev/null &

clean:
	rm -rf obj_dir

