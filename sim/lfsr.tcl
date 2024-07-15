set QSYS_SIMDIR /mnt/vault0/sfberrio/repos/Simple_NoC/sim

source $QSYS_SIMDIR/mentor/msim_setup.tcl

vlog +acc $QSYS_SIMDIR/testbench/lfsr_tb.sv \
    $QSYS_SIMDIR/../src/num_generator/lfsr.sv

set TOP_LEVEL_NAME lfsr_tb
#
# Set any elaboration options you require.
# set USER_DEFINED_ELAB_OPTIONS <elaboration options>
#
# Call command to elaborate your design and testbench.
#
elab_debug

do test_files/lfsr_test/lfsr_wave.do

# Run the simulation.
run -a