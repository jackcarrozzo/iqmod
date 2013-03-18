all: synth fit assemble netlist 

QUBIN=/usr/local/altera/12.1sp1/quartus/bin

synth:
	$(QUBIN)/quartus_map --read_settings_files=on --write_settings_files=off iq_modulator -c modulator

fit:
	$(QUBIN)/quartus_fit --read_settings_files=off --write_settings_files=off iq_modulator -c modulator

assemble:
	$(QUBIN)/quartus_asm --read_settings_files=off --write_settings_files=off iq_modulator -c modulator

timing:
	$(QUBIN)/quartus_sta iq_modulator -c modulator

netlist:
	$(QUBIN)/quartus_eda --read_settings_files=off --write_settings_files=off iq_modulator -c modulator

prog:
	$(QUBIN)/quartus_pgm --no_banner -c 1 -m JTAG -o 'P;output_files/modulator.sof'
