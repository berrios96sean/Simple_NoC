`include "parameters.sv"

module noc_adder_top (

    input  wire              CLK,
    input  wire              CLK_NOC,
    input  wire              RST_N,
    input  wire              START,
    input  wire              START2,
    output wire              DONE,
    output wire [TDATAW-1:0] DATA_O1,
    output wire [TDATAW-1:0] DATA_O2,
    output wire [TDATAW-1:0] DATA_O3

);

    // -------------------------------------------------------
    // NoC Connections
    // -------------------------------------------------------
    logic        axis_in_tvalid   [ROWS][COLUMNS];
    logic        axis_in_tready   [ROWS][COLUMNS];
    logic [31:0] axis_in_tdata    [ROWS][COLUMNS];
    logic        axis_in_tlast    [ROWS][COLUMNS];
    logic [ 3:0] axis_in_tdest    [ROWS][COLUMNS];

    logic        axis_out_tvalid  [ROWS][COLUMNS];
    logic        axis_out_tready  [ROWS][COLUMNS];
    logic [31:0] axis_out_tdata   [ROWS][COLUMNS];
    logic        axis_out_tlast   [ROWS][COLUMNS];
    logic [ 3:0] axis_out_tdest   [ROWS][COLUMNS];

    // -------------------------------------------------------
    // Module Instantions
    // -------------------------------------------------------

    // -------------------------------------------------------
    // Num Gen 1
    // -------------------------------------------------------

    num_gen #(
        .TDATAW        (TDATAW),
        .TDESTW        (TDESTW),
        .TIDW          (TIDW),
        .LFSR_DW       (LFSR_DW),
        .LFSR_DEFAULT  (LFSR_DEFAULT),
        .NUM_PACKETS   (NUM_PACKETS)
    ) num_gen1_inst (
        .CLK           (CLK),
        .RST_N         (RST_N),

        .START         (START),
        .DATA_O        (DATA_O1),

        // -------------------------------------------------------
        // AXI-Stream Slave Interface
        // -------------------------------------------------------
        .AXIS_S_TVALID (axis_out_tvalid [0][0]),
        .AXIS_S_TREADY (axis_out_tready [0][0]),
        .AXIS_S_TDATA  (axis_out_tdata  [0][0]),
        .AXIS_S_TLAST  (axis_out_tlast  [0][0]),
        // .AXIS_S_TID (axis_out_tid    [0][0]),
        .AXIS_S_TDEST  (axis_out_tdest  [0][0]),

        // -------------------------------------------------------
        // AXI-Stream Master Interface
        // -------------------------------------------------------
        .AXIS_M_TVALID (axis_in_tvalid  [0][0]),
        .AXIS_M_TREADY (axis_in_tready  [0][0]),
        .AXIS_M_TDATA  (axis_in_tdata   [0][0]),
        .AXIS_M_TLAST  (axis_in_tlast   [0][0]),
        // .AXIS_M_TID (axis_in_tid     [0][0]),
        .AXIS_M_TDEST  (axis_in_tdest   [0][0])
    );

    // -------------------------------------------------------
    // Adder
    // -------------------------------------------------------

    adder #(
        .TDATAW        (TDATAW),
        .TDESTW        (TDESTW),
        .TIDW          (TIDW)
    ) adder_inst (
        .CLK           (CLK),
        .RST_N         (RST_N),

        // -------------------------------------------------------
        // AXI-Stream Slave Interface
        // -------------------------------------------------------
        .AXIS_S_TVALID (axis_out_tvalid [0][1]),
        .AXIS_S_TREADY (axis_out_tready [0][1]),
        .AXIS_S_TDATA  (axis_out_tdata  [0][1]),
        .AXIS_S_TLAST  (axis_out_tlast  [0][1]),
        // .AXIS_S_TID (axis_out_tid    [0][1]),
        .AXIS_S_TDEST  (axis_out_tdest  [0][1]),

        // -------------------------------------------------------
        // AXI-Stream Master Interface
        // -------------------------------------------------------
        .AXIS_M_TVALID (axis_in_tvalid  [0][1]),
        .AXIS_M_TREADY (axis_in_tready  [0][1]),
        .AXIS_M_TDATA  (axis_in_tdata   [0][1]),
        .AXIS_M_TLAST  (axis_in_tlast   [0][1]),
        // .AXIS_M_TID (axis_in_tid     [0][1]),
        .AXIS_M_TDEST  (axis_in_tdest   [0][1])
    );

    // -------------------------------------------------------
    // Num Gen 2
    // -------------------------------------------------------

    num_gen #(
        .TDATAW        (TDATAW),
        .TDESTW        (TDESTW),
        .TIDW          (TIDW),
        .LFSR_DW       (LFSR_DW),
        .LFSR_DEFAULT  (8'h10),
        .NUM_PACKETS   (NUM_PACKETS)
    ) num_gen2_inst (
        .CLK           (CLK),
        .RST_N         (RST_N),

        .START         (START2),
        .DATA_O        (DATA_O2),

        // -------------------------------------------------------
        // AXI-Stream Slave Interface
        // -------------------------------------------------------
        .AXIS_S_TVALID (axis_out_tvalid [1][0]),
        .AXIS_S_TREADY (axis_out_tready [1][0]),
        .AXIS_S_TDATA  (axis_out_tdata  [1][0]),
        .AXIS_S_TLAST  (axis_out_tlast  [1][0]),
        // .AXIS_S_TID (axis_out_tid    [1][0]),
        .AXIS_S_TDEST  (axis_out_tdest  [1][0]),

        // -------------------------------------------------------
        // AXI-Stream Master Interface
        // -------------------------------------------------------
        .AXIS_M_TVALID (axis_in_tvalid  [1][0]),
        .AXIS_M_TREADY (axis_in_tready  [1][0]),
        .AXIS_M_TDATA  (axis_in_tdata   [1][0]),
        .AXIS_M_TLAST  (axis_in_tlast   [1][0]),
        // .AXIS_M_TID (axis_in_tid     [1][0]),
        .AXIS_M_TDEST  (axis_in_tdest   [1][0])
    );

    // -------------------------------------------------------
    // Output Module
    // -------------------------------------------------------

    output_module #(
        .TDATAW        (TDATAW),
        .TDESTW        (TDESTW),
        .TIDW          (TIDW)
    ) output_module_inst (
        .CLK           (CLK),
        .RST_N         (RST_N),

        .DONE          (DONE),
        .DATA_O        (DATA_O3),

        // -------------------------------------------------------
        // AXI-Stream Slave Interface
        // -------------------------------------------------------
        .AXIS_S_TVALID (axis_out_tvalid [1][1]),
        .AXIS_S_TREADY (axis_out_tready [1][1]),
        .AXIS_S_TDATA  (axis_out_tdata  [1][1]),
        .AXIS_S_TLAST  (axis_out_tlast  [1][1]),
        // .AXIS_S_TID (axis_out_tid    [1][1]),
        .AXIS_S_TDEST  (axis_out_tdest  [1][1]),

        // -------------------------------------------------------
        // AXI-Stream Master Interface
        // -------------------------------------------------------
        .AXIS_M_TVALID (axis_in_tvalid  [1][1]),
        .AXIS_M_TREADY (axis_in_tready  [1][1]),
        .AXIS_M_TDATA  (axis_in_tdata   [1][1]),
        .AXIS_M_TLAST  (axis_in_tlast   [1][1]),
        // .AXIS_M_TID (axis_in_tid     [1][1]),
        .AXIS_M_TDEST  (axis_in_tdest   [1][1])
    );

    // -------------------------------------------------------
    // Axis Mesh
    // -------------------------------------------------------

    axis_mesh #(
        .NUM_ROWS                   (ROWS),
        .NUM_COLS                   (COLUMNS),
        .PIPELINE_LINKS             (1),

        .TDEST_WIDTH                (4),
        .TDATA_WIDTH                (TDATAW),
        .SERIALIZATION_FACTOR       (4),
        .CLKCROSS_FACTOR            (1),
        .SINGLE_CLOCK               (1),
        .SERDES_IN_BUFFER_DEPTH     (4),
        .SERDES_OUT_BUFFER_DEPTH    (4),
        .SERDES_EXTRA_SYNC_STAGES   (0),

        .FLIT_BUFFER_DEPTH          (4),
        .ROUTING_TABLE_PREFIX       ("../routing_tables/mesh_2x2/"),
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