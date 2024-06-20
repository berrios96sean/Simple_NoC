# Create a new Quartus project
project_new noc_adder -overwrite

set_global_assignment -name TOP_LEVEL_ENTITY noc_adder
set_global_assignment -name ORIGINAL_QUARTUS_VERSION 23.4.0
set_global_assignment -name LAST_QUARTUS_VERSION "23.4.0 Pro Edition"
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
set_global_assignment -name EDA_DESIGN_ENTRY_SYNTHESIS_TOOL Synplify
set_global_assignment -name EDA_LMF_FILE synplcty.lmf -section_id eda_design_synthesis
set_global_assignment -name EDA_INPUT_DATA_FORMAT VQM -section_id eda_design_synthesis
set_global_assignment -name EDA_TIME_SCALE "1 ps" -section_id eda_simulation
set_global_assignment -name EDA_OUTPUT_DATA_FORMAT "VERILOG HDL" -section_id eda_simulation
set_global_assignment -name EDA_BOARD_DESIGN_SIGNAL_INTEGRITY_TOOL "IBIS (Signal Integrity)"
set_global_assignment -name EDA_OUTPUT_DATA_FORMAT IBIS -section_id eda_board_design_signal_integrity
set_global_assignment -name DEVICE AGFB014R24A3E3V
set_global_assignment -name FAMILY "Agilex 7"
set_global_assignment -name VERILOG_INPUT_VERSION SYSTEMVERILOG_2012
set_global_assignment -name PWRMGT_VOLTAGE_OUTPUT_FORMAT "LINEAR FORMAT"
set_global_assignment -name PWRMGT_LINEAR_FORMAT_N "-12"


project_save