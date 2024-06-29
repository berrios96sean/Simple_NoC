`timescale 1ns / 1ps

module mvm_tb;

  parameter DATAW = 512;
  parameter BYTEW = 8;
  parameter IDW = 32;
  parameter DESTW = 12;
  parameter USERW = 75;
  parameter IPRECISION = 8;
  parameter OPRECISION = 32;
  parameter LANES = DATAW / IPRECISION;
  parameter DPES = LANES;
  parameter NODES = 512;
  parameter NODESW = $clog2(NODES);
  parameter RFDEPTH = 512;
  parameter RFADDRW = $clog2(RFDEPTH);
  parameter INSTW = 1 + NODESW + 2 * RFADDRW + 4;
  parameter INSTD = 512;
  parameter INSTADDRW = $clog2(INSTD);
  parameter AXIS_OPS = 4;
  parameter AXIS_OPSW = $clog2(AXIS_OPS);
  parameter FIFOD = 64;
  parameter DATAPATH_DELAY = 12;

  reg clk;
  reg rst;
  reg axis_rx_tvalid;
  reg [DATAW-1:0] axis_rx_tdata;
  reg [BYTEW-1:0] axis_rx_tstrb;
  reg [BYTEW-1:0] axis_rx_tkeep;
  reg [IDW-1:0] axis_rx_tid;
  reg [DESTW-1:0] axis_rx_tdest;
  reg [USERW-1:0] axis_rx_tuser;
  reg axis_rx_tlast;
  wire axis_rx_tready;
  
  wire axis_tx_tvalid;
  wire [DATAW-1:0] axis_tx_tdata;
  wire [BYTEW-1:0] axis_tx_tstrb;
  wire [BYTEW-1:0] axis_tx_tkeep;
  wire [IDW-1:0] axis_tx_tid;
  wire [DESTW-1:0] axis_tx_tdest;
  wire [USERW-1:0] axis_tx_tuser;
  wire axis_tx_tlast;
  reg axis_tx_tready;

  rtl_mvm #(
    .DATAW(DATAW),
    .BYTEW(BYTEW),
    .IDW(IDW),
    .DESTW(DESTW),
    .USERW(USERW),
    .IPRECISION(IPRECISION),
    .OPRECISION(OPRECISION),
    .LANES(LANES),
    .DPES(DPES),
    .NODES(NODES),
    .NODESW(NODESW),
    .RFDEPTH(RFDEPTH),
    .RFADDRW(RFADDRW),
    .INSTW(INSTW),
    .INSTD(INSTD),
    .INSTADDRW(INSTADDRW),
    .AXIS_OPS(AXIS_OPS),
    .AXIS_OPSW(AXIS_OPSW),
    .FIFOD(FIFOD),
    .DATAPATH_DELAY(DATAPATH_DELAY)
  ) uut (
    .clk(clk),
    .rst(rst),
    .axis_rx_tvalid(axis_rx_tvalid),
    .axis_rx_tdata(axis_rx_tdata),
    .axis_rx_tstrb(axis_rx_tstrb),
    .axis_rx_tkeep(axis_rx_tkeep),
    .axis_rx_tid(axis_rx_tid),
    .axis_rx_tdest(axis_rx_tdest),
    .axis_rx_tuser(axis_rx_tuser),
    .axis_rx_tlast(axis_rx_tlast),
    .axis_rx_tready(axis_rx_tready),
    .axis_tx_tvalid(axis_tx_tvalid),
    .axis_tx_tdata(axis_tx_tdata),
    .axis_tx_tstrb(axis_tx_tstrb),
    .axis_tx_tkeep(axis_tx_tkeep),
    .axis_tx_tid(axis_tx_tid),
    .axis_tx_tdest(axis_tx_tdest),
    .axis_tx_tuser(axis_tx_tuser),
    .axis_tx_tlast(axis_tx_tlast),
    .axis_tx_tready(axis_tx_tready)
  );

  initial begin
    clk = 0;
    rst = 1;
    axis_rx_tvalid = 0;
    axis_rx_tdata = 0;
    axis_rx_tstrb = 0;
    axis_rx_tkeep = 0;
    axis_rx_tid = 0;
    axis_rx_tdest = 0;
    axis_rx_tuser = 0;
    axis_rx_tlast = 0;
    axis_tx_tready = 1;

    #10 rst = 0;
    
    // -----------------------------------------------------------------------------
    // Using Dummy Data for now for all vectors, will adjust for different 
    // testcases later 
    // -----------------------------------------------------------------------------
    
    // -----------------------------------------------------------------------------
    // Test case 1: Load instruction
    // -----------------------------------------------------------------------------
    @(posedge clk);
    axis_rx_tvalid = 1;
    axis_rx_tdata = {32'h00000001, { (INSTW-32){1'b0} }};
    axis_rx_tuser[8:0  ] =  9'b0;
    axis_rx_tuser[10:9 ] =  2'b0;
    axis_rx_tuser[74:11] = 64'b0;
    axis_rx_tlast = 1;

    @(posedge clk);
    axis_rx_tvalid = 0;
    axis_rx_tdata = 0;
    axis_rx_tlast = 0;

    // -----------------------------------------------------------------------------
    // Test case 2: Load input vector
    // -----------------------------------------------------------------------------
    @(posedge clk);
    axis_rx_tvalid = 1;
    axis_rx_tdata = { (DATAW/8){8'h01} };
    axis_rx_tuser[8:0  ] =   9'b0;
    axis_rx_tuser[10:9 ] =  2'b10;
    axis_rx_tuser[74:11] =  64'b0;
    axis_rx_tlast = 1;

    @(posedge clk);
    axis_rx_tvalid = 0;
    axis_rx_tdata = 0;
    axis_rx_tlast = 0;

    // -----------------------------------------------------------------------------
    // Test case 3: Load reduction vector
    // -----------------------------------------------------------------------------
    @(posedge clk);
    axis_rx_tvalid = 1;
    axis_rx_tdata = { (DATAW/8){8'h02} };
    axis_rx_tuser[8:0  ] =   9'b0;
    axis_rx_tuser[10:9 ] =  2'b01;
    axis_rx_tuser[74:11] =  64'b0;
    axis_rx_tlast = 1;

    @(posedge clk);
    axis_rx_tvalid = 0;
    axis_rx_tdata = 0;
    axis_rx_tlast = 0;

    // -----------------------------------------------------------------------------
    // Test case 4: Observe output
    // -----------------------------------------------------------------------------
    @(posedge clk);
    #100; 

    if (axis_tx_tvalid) begin
      $display("Output data: %h", axis_tx_tdata);
      $display("Output tuser: %h", axis_tx_tuser);
    end

    $stop;
  end

  // -----------------------------------------------------------------------------
  // Clock Generation
  // -----------------------------------------------------------------------------
  always #5 clk = ~clk; 

endmodule
