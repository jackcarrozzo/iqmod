all: build sim

# 2022-11-01
#
# https://ughe.github.io/2018/11/06/gtkwave-osx
#
# brew install icarus-verilog gtkwave
# cpan install Switch
# /Applications/gtkwave.app/Contents/Resources/bin/gtkwave

build:
	iverilog -o tbin.vvp tb_gmii.v ../rtl/gmii.v ../rtl/rom.v ../rtl/crc.v

sim:
	vvp tbin.vvp -vcd

show:
	#gtkwave dump.vcd 2>&1 >/dev/null &
	/Applications/gtkwave.app/Contents/Resources/bin/gtkwave dump.vcd 2>&1 >/dev/null &

clean:
	rm -fr tbin.vvp dump.vcd
