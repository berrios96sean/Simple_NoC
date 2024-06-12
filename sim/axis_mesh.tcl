----------------------------------------
# TOP-LEVEL TEMPLATE - BEGIN
#
# QSYS_SIMDIR is used in the Quartus-generated IP simulation script to
# construct paths to the files required to simulate the IP in your Quartus
# project. By default, the IP script assumes that you are launching the
# simulator from the IP script location. If launching from another
# location, set QSYS_SIMDIR to the output directory you specified when you
# generated the IP script, relative to the directory from which you launch
# the simulator.
#
set QSYS_SIMDIR /mnt/vault0/sfberrio/repos/Simple_NoC/sim
#
# Source the generated IP simulation script.
# Script may fail if modelsim.ini file is not in read only mode
# adjust by using chmod 444 <dir>/modelsim.ini
source $QSYS_SIMDIR/mentor/msim_setup.tcl
#
# Set any compilation options you require (this is unusual).
# set USER_DEFINED_COMPILE_OPTIONS <compilation options>
# set USER_DEFINED_VHDL_COMPILE_OPTIONS <compilation options for VHDL>
# set USER_DEFINED_VERILOG_COMPILE_OPTIONS <compilation options for Verilog>
#
# Call command to compile the Quartus EDA simulation library.
# dev_com
#
# Call command to compile the Quartus-generated IP simulation files.
# com
#
# Add commands to compile all design files and testbench files, including
# the top level. (These are all the files required for simulation other
# than the files compiled by the Quartus-generated IP simulation script)
#

# Set up test bench files
set output_file_path /mnt/vault0/sfberrio/repos/Simple_NoC/sim/output.out
set input_file_path /mnt/vault0/sfberrio/repos/Simple_NoC/sim/input1.in
set input2_file_path /mnt/vault0/sfberrio/repos/Simple_NoC/sim/input2.in
set sim_status_file_path /mnt/vault0/sfberrio/repos/Simple_NoC/sim/sim_status.txt

if {[file exists $output_file_path]} {
    # Delete the existing file
    file delete -force $output_file_path
}

if {[file exists $input_file_path]} {
    # Delete the existing file
    file delete -force $input_file_path
}

if {[file exists $input2_file_path]} {
    # Delete the existing file
    file delete -force $input2_file_path
}

if {[file exists $sim_status_file_path]} {
    # Delete the existing file
    file delete -force $sim_status_file_path
}


# Create a new output file
set file_id [open $output_file_path w]
close $file_id

# Create a new input file
set file_id2 [open $input_file_path w]
close $file_id2

# Create a new input file
set file_id3 [open $input2_file_path w]
close $file_id3

# Create a new status file
set file_id3 [open $sim_status_file_path w]
close $file_id3

vlog +acc $QSYS_SIMDIR/axis_mesh_tb.sv $QSYS_SIMDIR/../src/noc/*sv $QSYS_SIMDIR/../src/num_generator/*sv $QSYS_SIMDIR/../src/adder/*sv $QSYS_SIMDIR/../src/output/*sv
#
# Set the top-level simulation or testbench module/entity name, which is
# used by the elab command to elaborate the top level.
#
set TOP_LEVEL_NAME axis_mesh_tb
#
# Set any elaboration options you require.
# set USER_DEFINED_ELAB_OPTIONS <elaboration options>
#
# Call command to elaborate your design and testbench.
elab_debug
#
do wave.do
# Run the simulation.
run -a
#
if {[file exists "sim_status.txt"]} {
    set status_file [open "sim_status.txt" r]
    set status [read $status_file]
    close $status_file

    if {[string equal $status "Simulation finished"]} {

        set python_path "/usr/bin/python3" ;
        set script_path "verify_sums.py"
        set result [exec $python_path $script_path]
        puts $result

    } else {

        puts "Simulation did not finish successfully."

    }
} else {

    puts "Simulation status file not found."

}
# Report success to the shell.
# exit -code 0
#
# TOP-LEVEL TEMPLATE - END
