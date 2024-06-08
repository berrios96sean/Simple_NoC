`timescale 1ns / 1ps
`include "parameters.sv"

module axis_mesh_tb();

    logic clk, clk_noc, rst_n;
    integer i, j;

    // -------------------------------------
    // 100MHz Clock
    // -------------------------------------
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    // -------------------------------------
    // 100MHz Clock
    // -------------------------------------
    initial begin
        clk_noc = 0;
        forever begin
            #5 clk_noc = ~clk_noc;
        end
    end

    // -------------------------------------
    // NoC Connections
    // -------------------------------------
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

    // -------------------------------------
    // Number Generator Connections
    // -------------------------------------
    logic        axis_s_tvalid;
    logic        axis_s_tready;
    logic [31:0] axis_s_tdata ;
    logic        axis_s_tlast ;
    logic [ 3:0] axis_s_tdest ;

    logic        axis_m_tvalid;
    logic        axis_m_tready;
    logic [31:0] axis_m_tdata ;
    logic        axis_m_tlast ;
    logic [ 3:0] axis_m_tdest ;

    logic        start;

    initial begin

        // for (i = 0; i < ROWS; i = i + 1) begin
        //     for (j = 0; j < COLUMNS; j = j + 1) begin
        //         axis_in_tvalid  [i][j] = 1'b0;
        //         axis_out_tready [i][j] = 1'b1;
        //     end
        // end

        rst_n = 1'b0;

        #(50ns);

        rst_n = 1'b1;

        #(120ns);

        start = 1'b1;

        #(10ns);

        start = 1'b1;

        // axis_in_tvalid [1][0] =  1'b1;
        // axis_in_tdest  [1][0] =  4'h1;
        // axis_in_tlast  [1][0] =  1'b1;
        // axis_in_tdata  [1][0] = 32'h1;

        #(640ns);
    	$finish;
    end

        num_gen #(
            .TDATAW         (TDATAW),
            .TDESTW         (TDESTW),
            .TIDW           (TIDW),
            .LFSR_DW        (LFSR_DW),
            .LFSR_DEFAULT   (LFSR_DEFAULT)
        ) num_gen_inst (
            .CLK           (clk),
            .RST_N         (rst_n),
    
            .START         (start),
    
            // -------------------------------------------------------
            // AXI-Stream Slave Interface
            // -------------------------------------------------------
            .AXIS_S_TVALID (axis_s_tvalid),
            .AXIS_S_TREADY (axis_s_tready),
            .AXIS_S_TDATA  (axis_s_tdata ),
            .AXIS_S_TLAST  (axis_s_tlast ),
            // .AXIS_S_TID (axis_s_tid   ),
            .AXIS_S_TDEST  (axis_s_tdest ),
    
            // -------------------------------------------------------
            // AXI-Stream Master Interface
            // -------------------------------------------------------
            .AXIS_M_TVALID (axis_m_tvalid),
            .AXIS_M_TREADY (axis_m_tready),
            .AXIS_M_TDATA  (axis_m_tdata ),
            .AXIS_M_TLAST  (axis_m_tlast ),
            // .AXIS_M_TID (axis_m_tid   ),
            .AXIS_M_TDEST  (axis_m_tdest )
        );

        //axis_in_tvalid[0][0] <= axis_m_tvalid;
        assign axis_in_tvalid  [0][0] = axis_m_tvalid;
        assign axis_out_tready [0][0] = axis_s_tready;
        assign axis_in_tdata   [0][0] = axis_m_tdata;
        assign axis_in_tlast   [0][0] = axis_m_tlast;
        assign axis_in_tdest   [0][0] = axis_m_tdest;

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
    ) dut (
        .clk_noc         (clk_noc),
        .clk_usr         (clk),
        .rst_n           (rst_n),

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

endmodule: axis_mesh_tb
