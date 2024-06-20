exec mkdir -p constraints

file copy -force ../../src/noc/dcfifo_agilex7.sdc                     constraints/dcfifo_agilex7.sdc
file copy -force ../../src/noc/dcfifo_mixed_width_agilex7.sdc         constraints/dcfifo_mixed_width_agilex7.sdc
file copy -force ../../src/noc/reset_synchronizer.sdc                 constraints/reset_synchronizer.sdc
file copy -force ../../src/top/noc_adder.sdc                          constraints/noc_adder.sdc


set_global_assignment -name SDC_FILE  constraints/dcfifo_agilex7.sdc
set_global_assignment -name SDC_FILE  constraints/dcfifo_mixed_width_agilex7.sdc
set_global_assignment -name SDC_FILE  constraints/reset_synchronizer.sdc
set_global_assignment -name SDC_FILE  constraints/noc_adder.sdc