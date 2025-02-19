all: build sim

build:
	iverilog -o tbin.vvp basics.v tb_dac5672.v dac5672.v

sim:
	vvp tbin.vvp -vcd

show:
	#gtkwave dump.vcd 2>&1 >/dev/null &
	#/Applications/gtkwave.app/Contents/Resources/bin/gtkwave dump.vcd 2>&1 >/dev/null &
	~/build/oss-cad-suite-build/oss-cad-suite/bin/gtkwave dump.vcd 2>&1 >/dev/null &

clean:
	rm -fr tbin.vvp dump.vcd
