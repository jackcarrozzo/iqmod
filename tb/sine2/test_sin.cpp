#include <verilated.h>
#include <iostream>
#include <cmath>
#include <verilated_vcd_c.h>
#include "Vfullsine_lut.h"

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);

    Vfullsine_lut* top = new Vfullsine_lut;

	Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    top->trace(m_trace, 5); // TODO: what is the number
    m_trace->open("waveform.vcd");

    const int IN_WIDTH = 12;
    const int OUT_WIDTH = 14;
    const int mag=1<<(OUT_WIDTH-1);
	int max_in = (1 << IN_WIDTH);

	int dtheta_i=100;
	dtheta_i=1;

    for (int i = 0; i < (2*max_in); i+=dtheta_i) { // was just i++
        // Apply input
        top->in_val = i%max_in;
        
        // Evaluate (combinational, so just call eval once)
        top->eval();
        
        // The angle in floating point
        double angle = 2.0 * M_PI * (double(i) / double(max_in));
        double c_sin  = std::sin(angle); // Range: [-1..1]

        // Convert c_sin -> expected out in 0..(2^OUT_WIDTH - 1)
		//double mapped = (c_sin + 1.0) * ( (1<<OUT_WIDTH) - 1 ) / 2.0;
	
		double mapped=c_sin*mag;
		if (mapped<0.0) mapped+=16385;


        // We'll see the actual device output as an integer
        unsigned int hw_val = top->out_val;

        std::cout 
            << "in=" << i
            << " angle=" << angle
            << " sin=" << c_sin
            << " expected=" << mapped
            << " got=" << hw_val
			<< " err=" << (mapped-hw_val)
			<< ", ";
			//<< std::endl;
		printf("%.2f %.\n", (100*(mapped-hw_val)/65536.0));

		m_trace->dump(i);
    }

	top->final();
	m_trace->close();
	delete m_trace;

    delete top;
    return 0;
}

