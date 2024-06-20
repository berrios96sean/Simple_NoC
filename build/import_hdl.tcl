exec mkdir -p hdl

file copy -force ../../src/top/noc_adder_top.sv               hdl/noc_adder_top.sv
file copy -force ../../src/adder/adder.sv                     hdl/adder.sv
file copy -force ../../src/noc/axis_mesh.sv                   hdl/axis_mesh.sv
file copy -force ../../src/noc/axis_serdes_shims.sv           hdl/axis_serdes_shims.sv
file copy -force ../../src/noc/dcfifo_agilex7.sv              hdl/dcfifo_agilex7.sv
file copy -force ../../src/noc/dcfifo_mixed_width_agilex7.sv  hdl/dcfifo_mixed_width_agilex7.sv
file copy -force ../../src/noc/fifo_agilex7.sv                hdl/fifo_agilex7.sv
file copy -force ../../src/noc/mesh.sv                        hdl/mesh.sv
file copy -force ../../src/noc/noc_pipeline_link.sv           hdl/noc_pipeline_link.sv
file copy -force ../../src/noc/reset_synchronizer.sv          hdl/reset_synchronizer.sv
file copy -force ../../src/noc/router.sv                      hdl/router.sv
file copy -force ../../src/num_generator/lfsr.sv              hdl/lfsr.sv
file copy -force ../../src/num_generator/num_gen.sv           hdl/num_gen.sv
file copy -force ../../src/output/output_module.sv            hdl/output_module.sv
file copy -force ../../sim/parameters.sv                      hdl/parameters.sv


set_global_assignment -name SYSTEMVERILOG_FILE hdl/noc_adder_top.sv
set_global_assignment -name SYSTEMVERILOG_FILE hdl/noc_adder_top.sv
set_global_assignment -name SYSTEMVERILOG_FILE hdl/adder.sv
set_global_assignment -name SYSTEMVERILOG_FILE hdl/axis_mesh.sv
set_global_assignment -name SYSTEMVERILOG_FILE hdl/axis_serdes_shims.sv
set_global_assignment -name SYSTEMVERILOG_FILE hdl/dcfifo_agilex7.sv
set_global_assignment -name SYSTEMVERILOG_FILE hdl/dcfifo_mixed_width_agilex7.sv
set_global_assignment -name SYSTEMVERILOG_FILE hdl/fifo_agilex7.sv
set_global_assignment -name SYSTEMVERILOG_FILE hdl/mesh.sv
set_global_assignment -name SYSTEMVERILOG_FILE hdl/noc_pipeline_link.sv
set_global_assignment -name SYSTEMVERILOG_FILE hdl/reset_synchronizer.sv
set_global_assignment -name SYSTEMVERILOG_FILE hdl/router.sv
set_global_assignment -name SYSTEMVERILOG_FILE hdl/lfsr.sv
set_global_assignment -name SYSTEMVERILOG_FILE hdl/num_gen.sv
set_global_assignment -name SYSTEMVERILOG_FILE hdl/output_module.sv
set_global_assignment -name SYSTEMVERILOG_FILE hdl/parameters.sv

set_global_assignment -name TOP_LEVEL_ENTITY hdl/noc_adder_tob.sv