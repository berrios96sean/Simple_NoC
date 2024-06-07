# Simulation script for the NoC Network

isim:
	iverilog noc_test.v noc.v router.v cb.v mux.v muxcont.v arb.v inputc.v outputc.v vc.v rtcomp.v vcmux.v fifo.v
	./a.out | tee sim.log

clean:
	rm -rf *.v
	rm -rf *.h
	rm -rf *.out
	rm -rf *.log
	rm -rf *.vcd