all: build sim

# 2022-11-01
#
# https://ughe.github.io/2018/11/06/gtkwave-osx
#
# brew install icarus-verilog gtkwave
# cpan install Switch
# /Applications/gtkwave.app/Contents/Resources/bin/gtkwave

build:
	iverilog -o tbin.vvp samplewriter.v tb_pcm1804.v pcm1804.v handlepcm1804.v testram.v

sim:
	vvp tbin.vvp -vcd

show:
	#gtkwave dump.vcd 2>&1 >/dev/null &
	#/Applications/gtkwave.app/Contents/Resources/bin/gtkwave dump.vcd 2>&1 >/dev/null &
	~/build/oss-cad-suite-build/oss-cad-suite/bin/gtkwave dump.vcd 2>&1 >/dev/null &

clean:
	rm -fr tbin.vvp dump.vcd
