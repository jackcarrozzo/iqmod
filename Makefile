all: synth fit assemble netlist 

#QUBIN=/usr/local/altera/12.1sp1/quartus/bin
QUBIN=/usr/local/altera/12.1sp1_x64/quartus/linux64
ALTERALIBS=/usr/local/altera/12.1sp1_x64/quartus/linux64

synth:
	LD_LIBRARY_PATH=$(ALTERALIBS) $(QUBIN)/quartus_map --read_settings_files=on --write_settings_files=off iq_modulator -c modulator

fit:
	LD_LIBRARY_PATH=$(ALTERALIBS) $(QUBIN)/quartus_fit --read_settings_files=off --write_settings_files=off iq_modulator -c modulator

assemble:
	LD_LIBRARY_PATH=$(ALTERALIBS) $(QUBIN)/quartus_asm --read_settings_files=off --write_settings_files=off iq_modulator -c modulator

timing:
	LD_LIBRARY_PATH=$(ALTERALIBS) $(QUBIN)/quartus_sta iq_modulator -c modulator

netlist:
	LD_LIBRARY_PATH=$(ALTERALIBS) $(QUBIN)/quartus_eda --read_settings_files=off --write_settings_files=off iq_modulator -c modulator

prog:
	LD_LIBRARY_PATH=$(ALTERALIBS) $(QUBIN)/quartus_pgm --no_banner -c 1 -m JTAG -o 'P;output_files/modulator.sof'

jtagconfig:
	LD_LIBRARY_PATH=$(ALTERALIBS) $(QUBIN)/jtagconfig
