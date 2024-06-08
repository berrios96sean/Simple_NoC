// parameters.sv
`ifndef PARAMETERS_SV
`define PARAMETERS_SV

// Define your parameters here
parameter int ROWS         = 2;
parameter int COLUMNS      = 2;
parameter int TDATAW       = 32;

// LFSR parameters
parameter int LFSR_DW      = 7;
parameter int LFSR_DEFAULT = 8'h01;

`endif // PARAMETERS_SV
