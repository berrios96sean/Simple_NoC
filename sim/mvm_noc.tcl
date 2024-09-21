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
#set QSYS_SIMDIR /mnt/vault0/sfberrio/repos/Simple_NoC/sim
set QSYS_SIMDIR [pwd]
#
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

# Set up test bench files
set output_file_path $QSYS_SIMDIR/test_files/mvm_noc/output.out
set output_file "./test_files/mvm_noc/results.txt"

if {[file exists $output_file_path]} {
    # Delete the existing file
    file delete -force $output_file_path
}

# Create a new output file
set file_id [open $output_file_path w]
close $file_id

# Create Stimulus and golden output files
exec python3 test_files/mvm_noc/create_stimulus.py
exec python3 test_files/mvm_noc/golden_out.py
exec python3 test_files/mvm_noc/create_stimulus_signed.py
exec python3 test_files/mvm_noc/golden_out_signed.py

# Add commands to compile all design files and testbench files, including
# the top level. (These are all the files required for simulation other
# than the files compiled by the Quartus-generated IP simulation script)
#

vlog +acc $QSYS_SIMDIR/testbench/mvm_noc_tb.sv \
    $QSYS_SIMDIR/parameters.sv \
    $QSYS_SIMDIR/../src/axis/axis_passthrough.sv \
    $QSYS_SIMDIR/../src/mvm/*v \
    $QSYS_SIMDIR/../src/noc/*sv \
    $QSYS_SIMDIR/../src/top/mvm_top.sv

# Define the path to the parameters.sv file
set params_file "./parameters.sv"
set wave_file "./test_files/mvm_noc/wave.do"
set python_file "./test_files/mvm_noc/generate_wave.py"

# Initialize variables to hold ROWS and COLUMNS values
set ROWS ""
set COLUMNS ""

# Open the parameters.sv file for reading
set file_id [open $params_file r]

# Read the file line by line
while {[gets $file_id line] >= 0} {
    # Use regex to extract ROWS value
    if {[regexp {parameter\s+int\s+ROWS\s*=\s*(\d+)\s*;} $line match rows_value]} {
        set ROWS $rows_value
    }
    # Use regex to extract COLUMNS value
    if {[regexp {parameter\s+int\s+COLUMNS\s*=\s*(\d+)\s*;} $line match columns_value]} {
        set COLUMNS $columns_value
    }
}

# Close the file
close $file_id

# Print the extracted values (or assign them to other variables as needed)
puts "ROWS = $ROWS"
puts "COLUMNS = $COLUMNS"

exec python3 $python_file --rows $ROWS --columns $COLUMNS --output $wave_file
#
# Set the top-level simulation or testbench module/entity name, which is
# used by the elab command to elaborate the top level.
#
set TOP_LEVEL_NAME mvm_noc_tb
#
# Set any elaboration options you require.
# set USER_DEFINED_ELAB_OPTIONS <elaboration options>
#
# Call command to elaborate your design and testbench.
elab_debug -suppress 14408
#
do test_files/mvm_noc/wave.do
# Run the simulation with suppression.
run -a
#

# Check results for Pass or Fail report 
exec python3 test_files/mvm_noc/compare_output.py


# Read the results from results.txt
set result_file [open $output_file r]
set result [read $result_file]
close $result_file

# Print the result to the QuestaSim console
puts "Comparison result: $result"

# Report success to the shell.
# exit -code 0
#
# TOP-LEVEL TEMPLATE - END
