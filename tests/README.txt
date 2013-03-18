These tests use iverilog and gtkwave. I really dislike Quartus's IDE, so I write the code in vim and 
test it here.

Eventually I will spend a day writing a Makefile that implements the build process from Quartus (since
the IDE just calls the cli binaries anyway), but for now this workflow is OK.

- Debian/Ubuntu:
apt-get install iverilog gtkwave

- OSX:
brew install iverilog
brew install gtkwave

`make` will build and run the simulation. `make show` will start gtkwave for you, and after it's open
you can just press ctrl-shift-r to reload each time you run make.

Protip: Select the 'analog' datatype in gtkwave to see the waveforms coming out of the modules.
