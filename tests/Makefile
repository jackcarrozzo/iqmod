all: build sim 
sc: buildsc simsc

build:
	iverilog -o iqmod_bin iqmod_tb.v ../iqmod.v ../sincos.v

sim:
	vvp iqmod_bin -vcd

show:
	gtkwave dump.vcd 2>&1 >/dev/null &

clean:
	rm -fr iqmod_bin dump.vcd

buildsc:
	iverilog -o sc_bin sincos_tb.v ../sincos.v
	
simsc:
	vvp sc_bin -vcd


