`timescale 1ns / 1ps
`include "parameters.sv"

module mvm_noc_tb();

    logic clk, clk_noc, rst_n;
    integer i, j, file, input1_file, input2_file, output_file;
    logic [8*128:1] line;
    logic [6:0] line_count = 0;
    logic [511:0] data_word;
    integer r;



    logic rst;
    logic             axis_rx_tvalid;
    logic [DATAW-1:0] axis_rx_tdata;
    logic [BYTEW-1:0] axis_rx_tstrb;
    logic [BYTEW-1:0] axis_rx_tkeep;
    logic [  IDW-1:0] axis_rx_tid;
    logic [DESTW-1:0] axis_rx_tdest;
    logic [USERW-1:0] axis_rx_tuser;
    logic             axis_rx_tlast;
    wire              axis_rx_tready;
    
    wire              axis_tx_tvalid;
    wire [DATAW-1:0]  axis_tx_tdata;
    wire [BYTEW-1:0]  axis_tx_tstrb;
    wire [BYTEW-1:0]  axis_tx_tkeep;
    wire [  IDW-1:0]  axis_tx_tid;
    wire [DESTW-1:0]  axis_tx_tdest;
    wire [USERW-1:0]  axis_tx_tuser;
    wire              axis_tx_tlast;
    logic             axis_tx_tready;

    logic             axis_s_tvalid;
    logic [DATAW-1:0] axis_s_tdata;
    logic [  IDW-1:0] axis_s_tid;
    logic [DESTW-1:0] axis_s_tdest;
    logic [USERW-1:0] axis_s_tuser;
    logic             axis_s_tlast;
    wire              axis_s_tready;
    
    wire              axis_m_tvalid;
    wire [DATAW-1:0]  axis_m_tdata;
    wire [  IDW-1:0]  axis_m_tid;
    wire [DESTW-1:0]  axis_m_tdest;
    wire [USERW-1:0]  axis_m_tuser;
    wire              axis_m_tlast;
    logic             axis_m_tready;

    integer NUM_PACKET_INJ = 10;

    // -------------------------------------------------------
    // 100MHz Clock
    // -------------------------------------------------------
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    // -------------------------------------------------------
    // 100MHz Clock
    // -------------------------------------------------------
    initial begin
        clk_noc = 0;
        forever begin
            #5 clk_noc = ~clk_noc;
        end
    end


    initial begin

        rst_n = 1'b0;

        #(40ns);

        rst_n = 1'b1;

        $display("Starting Simulation");
        #(200ns);
        $display("Simulation Finished");
    	$finish;

    end

    mvm_top top (

        .CLK           (           clk ),
        .CLK_NOC       (       clk_noc ),
        .RST_N         (         rst_n ),
        .AXIS_S_TVALID ( axis_s_tvalid ),
        .AXIS_S_TREADY ( axis_s_tready ),
        .AXIS_S_TDATA  (  axis_s_tdata ),
        .AXIS_S_TLAST  (  axis_s_tlast ),
        .AXIS_S_TID    (    axis_s_tid ),
        .AXIS_S_TUSER  (  axis_s_tuser ),
        .AXIS_S_TDEST  (  axis_s_tdest ),
        .AXIS_M_TVALID ( axis_m_tvalid ),
        .AXIS_M_TREADY ( axis_m_tready ),
        .AXIS_M_TDATA  (  axis_m_tdata ),
        .AXIS_M_TLAST  (  axis_m_tlast ),
        .AXIS_M_TID    (    axis_m_tid ),
        .AXIS_M_TUSER  (  axis_m_tuser ),
        .AXIS_M_TDEST  (  axis_m_tdest )
    );


endmodule: mvm_noc_tb
