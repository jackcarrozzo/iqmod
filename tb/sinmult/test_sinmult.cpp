#include <verilated.h>
#include <iostream>
#include <cmath>
#include <verilated_vcd_c.h>
#include "Vsinmult.h"

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);

    Vsinmult* top = new Vsinmult;

	Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    top->trace(m_trace, 5); // TODO: what is the number
    m_trace->open("waveform.vcd");

    const int IN_WIDTH = 12;
    const int OUT_WIDTH = 14;
    const int mag=1<<(OUT_WIDTH-1);
	int max_in = (1 << IN_WIDTH);

	// 0x2000 full neg, 0x1FFF full plus ?
	int coef=0x2000;
	//coef=0x1fff;
	//coef=-8000;
	coef=8000;

	int dtheta_i=100;
	dtheta_i=1;
	int thistheta;

    for (int i = 0; i < (4*max_in); i+=dtheta_i) { // was just i++
        thistheta=i%max_in;
		//if ((thistheta<(max_in/4))||(thistheta>(3*max_in/4))) coef=-8100;
		//else                     coef=8100;

		coef=(i>2*max_in)?-8100:8100;

		top->theta = thistheta;
		top->coef = coef;

        top->eval();
        
		unsigned int out_unsigned=top->outunsigned;
		int out_signed=top->outsigned;

		std::cout<<"-- theta "<<thistheta<<", coef "<<coef<<": int "<<out_signed<<", uint "<<out_unsigned<<std::endl;

		m_trace->dump(i);
    }

	top->final();
	m_trace->close();
	delete m_trace;

    delete top;
    return 0;
}

