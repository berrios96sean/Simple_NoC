# Define the clock constraints
# Clock frequency of 100 MHz for CLK and CLK_NOC
create_clock -name CLK -period 10.0 [get_ports {CLK}]
create_clock -name CLK_NOC -period 10.0 [get_ports {CLK_NOC}]

# Define the input delay for START and RST_N signals
# Adjust the delays according to your design requirements
set_input_delay -clock CLK 2.5 [get_ports {START}]
set_input_delay -clock CLK 2.5 [get_ports {RST_N}]

# Define the output delay for DONE, IDATA_O1, IDATA_O2, and ODATA_O signals
# Adjust the delays according to your design requirements
set_output_delay -clock CLK 2.5 [get_ports {DONE}]
set_output_delay -clock CLK 2.5 [get_ports {IDATA_O1[*]}]
set_output_delay -clock CLK 2.5 [get_ports {IDATA_O2[*]}]
set_output_delay -clock CLK 2.5 [get_ports {ODATA_O[*]}]

# Specify the reset signal as an asynchronous reset
set_false_path -from [get_ports {RST_N}]
set_false_path -to [get_ports {RST_N}]
