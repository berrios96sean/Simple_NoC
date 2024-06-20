# Check if the project directory exists and delete it if it does
if {[file exists noc_adder]} {
    exec rm -rf noc_adder
}

# Create the project directory
exec mkdir -p noc_adder

# Change to the project directory
cd noc_adder

source create_design.tcl