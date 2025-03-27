#include <verilated.h>
#include <iostream>
#include <cmath>
#include <verilated_vcd_c.h>
#include "Vcomplexsine.h"

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);

	Verilated::traceEverOn(true);
	VerilatedVcdC *m_trace = new VerilatedVcdC;

	Vcomplexsine* top = new Vcomplexsine;

    top->trace(m_trace, 99); //  levels of hierarchy
    m_trace->open("waveform.vcd");

	uint32_t maxiter=1000;

	int i_mag=8020;
	i_mag=7900;
	int q_mag=7900;
	uint8_t clk=0;
	int i;

	int tt=0;

	for (i=0;i<maxiter;i++) {
		Verilated::timeInc(1);

		clk=~clk;
		top->clk=(clk)?1:0;
		top->i_mag=i_mag;
		top->q_mag=q_mag;

		top->eval();

		m_trace->dump(Verilated::time());

		if (clk) {
			unsigned int i_unsigned_out=top->i_unsigned_out;
			unsigned int q_unsigned_out=top->q_unsigned_out;
		
			std::cout<<"I: "<<i_unsigned_out<<", Q: "<<q_unsigned_out<<std::endl;
		}
	}

	top->final();
    m_trace->close();
    delete m_trace;

    delete top;
    return 0;
}

