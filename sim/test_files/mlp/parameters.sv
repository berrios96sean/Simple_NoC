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
parameter int DESTW = 12;
parameter int IPRECISION = 8;
parameter int OPRECISION = 32;
parameter int LANES = DATAW / IPRECISION;
parameter int USERW = LANES + 11; // Lanes = # RF weigts for each MVM
                                  // + 11 for user operations 10:0

parameter int NUM_BYTES = DATAW / BYTEW;
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
parameter int USE_RELU = 1;

// Mesh Parameters
// 4x4 Mesh is verified but exceeds intel recommended design size
// this causes the simulation to finish extremely slowly. For testing 
// purposes recommend only using 3x3 noc or below. 
parameter int ROWS         = 2;
parameter int COLUMNS      = 2;
parameter int TDATAW       = DATAW + USERW;
parameter int TIDW         = 4;
parameter int TDESTW       = 12;
parameter int NUM_PACKETS  = 1;

// Directories
localparam string ROUTING_TABLES_DIR = 
    (ROWS == 2 && COLUMNS == 2) ? "../routing_tables/mesh_2x2/" :
    (ROWS == 3 && COLUMNS == 3) ? "../routing_tables/mesh_3x3/" :
    (ROWS == 4 && COLUMNS == 4) ? "../routing_tables/mesh_4x4/" :
    "../routing_tables/default/"; // Default this should be an error

`endif // PARAMETERS_SV
