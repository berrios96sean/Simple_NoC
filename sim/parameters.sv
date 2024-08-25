// parameters.sv
`ifndef PARAMETERS_SV
`define PARAMETERS_SV

// LFSR parameters
parameter int LFSR_DW      = 7;
parameter int LFSR_DEFAULT = 8'h01;

// MVM Parameters
parameter int DATAW = 512;
parameter int BYTEW = 8;
parameter int IDW = 4;
parameter int DESTW = 4;
parameter int USERW = 75; // May need to parameterize this
parameter int IPRECISION = 8;
parameter int OPRECISION = 32;
parameter int LANES = DATAW / IPRECISION;
parameter int DPES = LANES;
parameter int NODES = 512;
parameter int NODESW = $clog2(NODES);
parameter int RFDEPTH = 512;
parameter int RFADDRW = $clog2(RFDEPTH);
parameter int INSTW = 1 + NODESW + 2 * RFADDRW + 4;
parameter int INSTD = 512;
parameter int INSTADDRW = $clog2(INSTD);
parameter int AXIS_OPS = 4;
parameter int AXIS_OPSW = $clog2(AXIS_OPS);
parameter int FIFOD = 64;
parameter int DATAPATH_DELAY = 12;

// Mesh Parameters
parameter int ROWS         = 2;
parameter int COLUMNS      = 2;
parameter int TDATAW       = DATAW + USERW;
parameter int TIDW         = 4;
parameter int TDESTW       = 4;
parameter int NUM_PACKETS  = 1;

// Directories
parameter string ROUTING_TABLES_DIR = "../routing_tables/mesh_2x2/";

`endif // PARAMETERS_SV
