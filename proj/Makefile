PROJ=iqmod
TOPBLOCK=iqmod

QUBIN=/opt/intelFPGA_lite/18.1/quartus/bin
#QUBIN=/opt/altera/12.1sp1_243/quartus/linux
#ALTERALIBS=/opt/altera/12.1sp1_243/quartus/linux
#QUBIN=/opt/altera/12.1sp1_243/quartus/linux64
#ALTERALIBS=/opt/altera/12.1sp1_243/quartus/linux64

all: synth fit assemble
rest: fit assemble

#all: synth fit assemble netlist
#rest: fit assemble netlist

synth:
	$(QUBIN)/quartus_map --read_settings_files=on --write_settings_files=off $(PROJ) -c $(TOPBLOCK)

fit:
	$(QUBIN)/quartus_fit --read_settings_files=off --write_settings_files=off $(PROJ) -c $(TOPBLOCK)

assemble:
	$(QUBIN)/quartus_asm --read_settings_files=off --write_settings_files=off $(PROJ) -c $(TOPBLOCK)

timing:
	$(QUBIN)/quartus_sta $(PROJ) -c $(TOPBLOCK)

netlist:
	$(QUBIN)/quartus_eda --read_settings_files=off --write_settings_files=off $(PROJ) -c $(TOPBLOCK)

prog:
	$(QUBIN)/quartus_pgm --no_banner -c 1 -m JTAG -o 'P;output_files/$(TOPBLOCK).sof'

jtagconfig:
	$(QUBIN)/jtagconfig

quartus:
	$(QUBIN)/quartus

clean:
	rm -fr db incremental_db output_files greybox_tmp simulation

