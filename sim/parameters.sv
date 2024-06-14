// parameters.sv
`ifndef PARAMETERS_SV
`define PARAMETERS_SV

// Define your parameters here
parameter int ROWS         = 2;
parameter int COLUMNS      = 2;
parameter int TDATAW       = 32;
parameter int TIDW         = 2;
parameter int TDESTW       = 4;
parameter int NUM_PACKETS  = 1;

// LFSR parameters
parameter int LFSR_DW      = 7;
parameter int LFSR_DEFAULT = 8'h01;

// Directories
parameter string ROUTING_TABLES_DIR = "../routing_tables/mesh_2x2/";

`endif // PARAMETERS_SV
