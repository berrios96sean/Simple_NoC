set QSYS_SIMDIR /mnt/vault0/sfberrio/repos/Simple_NoC/sim

vlog +acc $QSYS_SIMDIR/lfsr_tb.sv $QSYS_SIMDIR/../src/num_generator/lfsr.sv

set TOP_LEVEL_NAME lsfr_tb
#
# Set any elaboration options you require.
# set USER_DEFINED_ELAB_OPTIONS <elaboration options>
#
# Call command to elaborate your design and testbench.
elab_debug
#

# Run the simulation.
run -a