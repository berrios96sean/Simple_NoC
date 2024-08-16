`include "parameters.sv"

module mvm_top (

    input   wire                  CLK,
    input   wire                  CLK_NOC,
    input   wire                  RST_N,

    // -------------------------------------------------------
    // AXI-Stream Slave Interface
    // -------------------------------------------------------
    input   wire                  AXIS_S_TVALID,
    output  logic                 AXIS_S_TREADY,
    input   wire    [TDATAW-1:0]  AXIS_S_TDATA,
    input   wire                  AXIS_S_TLAST,
    input   wire    [  TIDW-1:0]  AXIS_S_TID,
    input   wire    [ USERW-1:0]  AXIS_S_TUSER,
    input   wire    [TDESTW-1:0]  AXIS_S_TDEST,

    // -------------------------------------------------------
    // AXI-Stream Master Interface
    // -------------------------------------------------------
    output  logic                 AXIS_M_TVALID,
    input   wire                  AXIS_M_TREADY,
    output  logic   [TDATAW-1:0]  AXIS_M_TDATA,
    output  logic                 AXIS_M_TLAST,
    output  logic   [  TIDW-1:0]  AXIS_M_TID,
    output  logic   [ USERW-1:0]  AXIS_M_TUSER,
    output  logic   [TDESTW-1:0]  AXIS_M_TDEST

);

    // -------------------------------------------------------
    // NoC Connections
    // -------------------------------------------------------
    //
    // NOTE: These names in/out are named for the directions 
    // in which they enter the noc. Not the MVMs they are 
    // connected to
    //
    // -------------------------------------------------------
    logic              axis_in_tvalid   [ROWS][COLUMNS];
    logic              axis_in_tready   [ROWS][COLUMNS];
    logic [TDATAW-1:0] axis_in_tdata    [ROWS][COLUMNS];
    logic              axis_in_tlast    [ROWS][COLUMNS];
    logic [TDESTW-1:0] axis_in_tdest    [ROWS][COLUMNS];

    logic              axis_out_tvalid  [ROWS][COLUMNS];
    logic              axis_out_tready  [ROWS][COLUMNS];
    logic [TDATAW-1:0] axis_out_tdata   [ROWS][COLUMNS];
    logic              axis_out_tlast   [ROWS][COLUMNS];
    logic [TDESTW-1:0] axis_out_tdest   [ROWS][COLUMNS];

    // -------------------------------------------------------
    // Module Instantions
    // -------------------------------------------------------

    rtl_mvm #(
        .DATAW          (512),                          // Bitwidth of axi-s tdata
        .BYTEW          (8),   		                    // Bitwidth of axi-s tkeep, tstrb
        .IDW            (32),                           // Bitwidth of axi-s tid
        .DESTW          (12),		                    // Bitwidth of axi-s tdest
        .USERW          (75),                           // Bitwidth of axi-s tuser
        .IPRECISION     (8),                            // Input precision in bits
        .OPRECISION     (32),                           // Output precision in bits
        .LANES          (DATAW / IPRECISION),           // Number of dot-product INT8 lanes
        .DPES           (LANES),                        // Number of dot-product engines
        .NODES          (512),		      	            // Max number of nodes in each NoC
        .NODESW         ($clog2(NODES)),                // Bitwidth of store node ID
        .RFDEPTH        (512),                          // Depth of register files (RFs)
        .RFADDRW        ($clog2(RFDEPTH)),              // Bitwidth of RF address
        .INSTW          (1 + NODESW + 2 * RFADDRW + 4), // Instruction bitwidth {release_op, release_dest, rf_raddr, accum_raddr, last, release, accum_en, reduce, jump, en}
        .INSTD          (512),                          // Depth of instruction FIFO
        .INSTADDRW      ($clog2(INSTD)),                // Bitwidth of instruction memory address
        .AXIS_OPS       (4),                            // Number of AXI-S operations (max 4) {instruction, reduction vector, input vector, matrix}
        .AXIS_OPSW      ($clog2(AXIS_OPS)),
        .FIFOD          (64),                           // Depth of input, accumulation, and output FIFOs
        .DATAPATH_DELAY (2)                             // Delay of datpath (inputs -> result)
    ) mvm_inst_1 (
        .clk(CLK),                                      // input
        .rst(~RST_N),                                   // input

        .axis_rx_tvalid  (axis_s_tvalid),               // input
        .axis_rx_tdata   (axis_s_tdata ),               // input
        // .axis_rx_tstrb(axis_s_tstrb ),               // input
        // .axis_rx_tkeep(axis_s_tkeep ),               // input
        // .axis_rx_tid  (axis_s_tid   ),               // input
        .axis_rx_tdest   (axis_s_tdest ),               // input
        .axis_rx_tuser   (axis_s_tuser ),               // input
        .axis_rx_tlast   (axis_s_tlast ),               // input
        .axis_rx_tready  (axis_s_tready),               // output

        .axis_tx_tvalid  (axis_in_tvalid  [0][0]),       // output
        .axis_tx_tdata   (axis_in_tdata   [0][0]),       // output
        // .axis_tx_tstrb(axis_in_tstrb   [0][0]),       // output
        // .axis_tx_tkeep(axis_in_tkeep   [0][0]),       // output
        // .axis_tx_tid  (axis_in_tid     [0][0]),       // output
        .axis_tx_tdest   (axis_in_tdest   [0][0]),       // output
        // .axis_tx_tuser(axis_in_tuser   [0][0]),       // output
        .axis_tx_tlast   (axis_in_tlast   [0][0]),       // output
        .axis_tx_tready  (axis_in_tready  [0][0])        // input
    );

        rtl_mvm #(
        .DATAW          (512),                          // Bitwidth of axi-s tdata
        .BYTEW          (8),   		                    // Bitwidth of axi-s tkeep, tstrb
        .IDW            (32),                           // Bitwidth of axi-s tid
        .DESTW          (12),		                    // Bitwidth of axi-s tdest
        .USERW          (75),                           // Bitwidth of axi-s tuser
        .IPRECISION     (8),                            // Input precision in bits
        .OPRECISION     (32),                           // Output precision in bits
        .LANES          (DATAW / IPRECISION),           // Number of dot-product INT8 lanes
        .DPES           (LANES),                        // Number of dot-product engines
        .NODES          (512),		      	            // Max number of nodes in each NoC
        .NODESW         ($clog2(NODES)),                // Bitwidth of store node ID
        .RFDEPTH        (512),                          // Depth of register files (RFs)
        .RFADDRW        ($clog2(RFDEPTH)),              // Bitwidth of RF address
        .INSTW          (1 + NODESW + 2 * RFADDRW + 4), // Instruction bitwidth {release_op, release_dest, rf_raddr, accum_raddr, last, release, accum_en, reduce, jump, en}
        .INSTD          (512),                          // Depth of instruction FIFO
        .INSTADDRW      ($clog2(INSTD)),                // Bitwidth of instruction memory address
        .AXIS_OPS       (4),                            // Number of AXI-S operations (max 4) {instruction, reduction vector, input vector, matrix}
        .AXIS_OPSW      ($clog2(AXIS_OPS)),
        .FIFOD          (64),                           // Depth of input, accumulation, and output FIFOs
        .DATAPATH_DELAY (2)                             // Delay of datpath (inputs -> result)
    ) mvm_inst_2 (
        .clk(CLK),                                      // input
        .rst(~RST_N),                                   // input

        .axis_rx_tvalid  (axis_out_tvalid [0][1]),       // input
        .axis_rx_tdata   (axis_out_tdata  [0][1]),       // input
        // .axis_rx_tstrb(axis_out_tstrb  [0][1]),       // input
        // .axis_rx_tkeep(axis_out_tkeep  [0][1]),       // input
        // .axis_rx_tid  (axis_out_tid    [0][1]),       // input
        .axis_rx_tdest   (axis_out_tdest  [0][1]),       // input
        // .axis_rx_tuser(axis_out_tuser  [0][1]),       // input
        .axis_rx_tlast   (axis_out_tlast  [0][1]),       // input
        .axis_rx_tready  (axis_out_tready [0][1]),       // output

        .axis_tx_tvalid  (axis_in_tvalid  [0][1]),       // output
        .axis_tx_tdata   (axis_in_tdata   [0][1]),       // output
        // .axis_tx_tstrb(axis_in_tstrb   [0][1]),       // output
        // .axis_tx_tkeep(axis_in_tkeep   [0][1]),       // output
        // .axis_tx_tid  (axis_in_tid     [0][1]),       // output
        .axis_tx_tdest   (axis_in_tdest   [0][1]),       // output
        // .axis_tx_tuser(axis_in_tuser   [0][1]),       // output
        .axis_tx_tlast   (axis_in_tlast   [0][1]),       // output
        .axis_tx_tready  (axis_in_tready  [0][1])        // input
    );

        rtl_mvm #(
        .DATAW          (512),                          // Bitwidth of axi-s tdata
        .BYTEW          (8),   		                    // Bitwidth of axi-s tkeep, tstrb
        .IDW            (32),                           // Bitwidth of axi-s tid
        .DESTW          (12),		                    // Bitwidth of axi-s tdest
        .USERW          (75),                           // Bitwidth of axi-s tuser
        .IPRECISION     (8),                            // Input precision in bits
        .OPRECISION     (32),                           // Output precision in bits
        .LANES          (DATAW / IPRECISION),           // Number of dot-product INT8 lanes
        .DPES           (LANES),                        // Number of dot-product engines
        .NODES          (512),		      	            // Max number of nodes in each NoC
        .NODESW         ($clog2(NODES)),                // Bitwidth of store node ID
        .RFDEPTH        (512),                          // Depth of register files (RFs)
        .RFADDRW        ($clog2(RFDEPTH)),              // Bitwidth of RF address
        .INSTW          (1 + NODESW + 2 * RFADDRW + 4), // Instruction bitwidth {release_op, release_dest, rf_raddr, accum_raddr, last, release, accum_en, reduce, jump, en}
        .INSTD          (512),                          // Depth of instruction FIFO
        .INSTADDRW      ($clog2(INSTD)),                // Bitwidth of instruction memory address
        .AXIS_OPS       (4),                            // Number of AXI-S operations (max 4) {instruction, reduction vector, input vector, matrix}
        .AXIS_OPSW      ($clog2(AXIS_OPS)),
        .FIFOD          (64),                           // Depth of input, accumulation, and output FIFOs
        .DATAPATH_DELAY (2)                             // Delay of datpath (inputs -> result)
    ) mvm_inst_3 (
        .clk(CLK),                                      // input
        .rst(~RST_N),                                   // input

        .axis_rx_tvalid  (axis_out_tvalid [1][0]),       // input
        .axis_rx_tdata   (axis_out_tdata  [1][0]),       // input
        // .axis_rx_tstrb(axis_out_tstrb  [1][0]),       // input
        // .axis_rx_tkeep(axis_out_tkeep  [1][0]),       // input
        // .axis_rx_tid  (axis_out_tid    [1][0]),       // input
        .axis_rx_tdest   (axis_out_tdest  [1][0]),       // input
        // .axis_rx_tuser(axis_out_tuser  [1][0]),       // input
        .axis_rx_tlast   (axis_out_tlast  [1][0]),       // input
        .axis_rx_tready  (axis_out_tready [1][0]),       // output

        .axis_tx_tvalid  (axis_in_tvalid  [1][0]),       // output
        .axis_tx_tdata   (axis_in_tdata   [1][0]),       // output
        // .axis_tx_tstrb(axis_in_tstrb   [1][0]),       // output
        // .axis_tx_tkeep(axis_in_tkeep   [1][0]),       // output
        // .axis_tx_tid  (axis_in_tid     [1][0]),       // output
        .axis_tx_tdest   (axis_in_tdest   [1][0]),       // output
        // .axis_tx_tuser(axis_in_tuser   [1][0]),       // output
        .axis_tx_tlast   (axis_in_tlast   [1][0]),       // output
        .axis_tx_tready  (axis_in_tready  [1][0])        // input
    );

        rtl_mvm #(
        .DATAW          (512),                          // Bitwidth of axi-s tdata
        .BYTEW          (8),   		                    // Bitwidth of axi-s tkeep, tstrb
        .IDW            (32),                           // Bitwidth of axi-s tid
        .DESTW          (12),		                    // Bitwidth of axi-s tdest
        .USERW          (75),                           // Bitwidth of axi-s tuser
        .IPRECISION     (8),                            // Input precision in bits
        .OPRECISION     (32),                           // Output precision in bits
        .LANES          (DATAW / IPRECISION),           // Number of dot-product INT8 lanes
        .DPES           (LANES),                        // Number of dot-product engines
        .NODES          (512),		      	            // Max number of nodes in each NoC
        .NODESW         ($clog2(NODES)),                // Bitwidth of store node ID
        .RFDEPTH        (512),                          // Depth of register files (RFs)
        .RFADDRW        ($clog2(RFDEPTH)),              // Bitwidth of RF address
        .INSTW          (1 + NODESW + 2 * RFADDRW + 4), // Instruction bitwidth {release_op, release_dest, rf_raddr, accum_raddr, last, release, accum_en, reduce, jump, en}
        .INSTD          (512),                          // Depth of instruction FIFO
        .INSTADDRW      ($clog2(INSTD)),                // Bitwidth of instruction memory address
        .AXIS_OPS       (4),                            // Number of AXI-S operations (max 4) {instruction, reduction vector, input vector, matrix}
        .AXIS_OPSW      ($clog2(AXIS_OPS)),
        .FIFOD          (64),                           // Depth of input, accumulation, and output FIFOs
        .DATAPATH_DELAY (2)                             // Delay of datpath (inputs -> result)
    ) mvm_inst_4 (
        .clk(CLK),                                      // input
        .rst(~RST_N),                                   // input

        .axis_rx_tvalid  (axis_out_tvalid [1][1]),       // input
        .axis_rx_tdata   (axis_out_tdata  [1][1]),       // input
        // .axis_rx_tstrb(axis_out_tstrb  [1][1]),       // input
        // .axis_rx_tkeep(axis_out_tkeep  [1][1]),       // input
        // .axis_rx_tid  (axis_out_tid    [1][1]),       // input
        .axis_rx_tdest   (axis_out_tdest  [1][1]),       // input
        // .axis_rx_tuser(axis_out_tuser  [1][1]),       // input
        .axis_rx_tlast   (axis_out_tlast  [1][1]),       // input
        .axis_rx_tready  (axis_out_tready [1][1]),       // output

        .axis_tx_tvalid  (axis_m_tvalid),                // output
        .axis_tx_tdata   (axis_m_tdata ),                // output
        // .axis_tx_tstrb(axis_m_tstrb ),                // output
        // .axis_tx_tkeep(axis_m_tkeep ),                // output
        // .axis_tx_tid  (axis_m_tid   ),                // output
        .axis_tx_tdest   (axis_m_tdest ),                // output
        .axis_tx_tuser   (axis_m_tuser ),                // output
        .axis_tx_tlast   (axis_m_tlast ),                // output
        .axis_tx_tready  (axis_m_tready)                 // input
    );

    // -------------------------------------------------------
    // Axis Mesh
    // -------------------------------------------------------

    axis_mesh #(
        .NUM_ROWS                   (ROWS),
        .NUM_COLS                   (COLUMNS),
        .PIPELINE_LINKS             (1),

        .TDEST_WIDTH                (TDESTW),
        .TDATA_WIDTH                (TDATAW),
        .SERIALIZATION_FACTOR       (4),
        .CLKCROSS_FACTOR            (1),
        .SINGLE_CLOCK               (1),
        .SERDES_IN_BUFFER_DEPTH     (4),
        .SERDES_OUT_BUFFER_DEPTH    (4),
        .SERDES_EXTRA_SYNC_STAGES   (0),

        .FLIT_BUFFER_DEPTH          (4),
        .ROUTING_TABLE_PREFIX       (ROUTING_TABLES_DIR),
        .ROUTER_PIPELINE_OUTPUT     (1),
        .DISABLE_SELFLOOP           (0),
        .ROUTER_FORCE_MLAB          (0)
    ) axis_mesh_inst (
        .clk_noc         (CLK_NOC),
        .clk_usr         (CLK),
        .rst_n           (RST_N),

        .axis_in_tvalid  (axis_in_tvalid),
        .axis_in_tready  (axis_in_tready),
        .axis_in_tdata   (axis_in_tdata),
        .axis_in_tlast   (axis_in_tlast),
        // .axis_in_tid  (axis_in_tid),
        .axis_in_tdest   (axis_in_tdest),

        .axis_out_tvalid (axis_out_tvalid),
        .axis_out_tready (axis_out_tready),
        .axis_out_tdata  (axis_out_tdata),
        .axis_out_tlast  (axis_out_tlast),
        // .axis_out_tid (axis_out_tid),
        .axis_out_tdest  (axis_out_tdest)
    );

endmodule