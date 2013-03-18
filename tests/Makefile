all: build sim 

build:
	iverilog -o iqmod_bin iqmod_tb.v ../iqmod.v ../sincos.v

sim:
	vvp iqmod_bin -vcd

show:
	gtkwave dump.vcd 2>&1 >/dev/null &

clean:
	rm -fr iqmod_bin dump.vcd

