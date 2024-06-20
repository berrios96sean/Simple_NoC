exec mkdir -p constraints

file copy -force ../../src/noc/dcfifo_agilex7.sv                     constraints/dcfifo_agilex7.sv
file copy -force ../../src/noc/dcfifo_mixed_width_agilex7.sv         constraints/dcfifo_mixed_width_agilex7.sv
file copy -force ../../src/noc/reset_synchronizer.sv                 constraints/reset_synchronizer.sv


set_global_assignment -name SDC_FILE  constraints/dcfifo_agilex7.sv
set_global_assignment -name SDC_FILE  constraints/dcfifo_mixed_width_agilex7.sv
set_global_assignment -name SDC_FILE  constraints/reset_synchronizer.sv