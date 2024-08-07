`timescale 1ns / 1ps

module mvm_tb;

  integer rf_weights_file, input_vec_file, output_file; 
  reg [8*128:1] line;
  reg [6:0] line_count = 0;
  reg [511:0] data_word;
  integer r;

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

  // -----------------------------------------------------------------------------
  // Function to Read a data word from I/O
  // -----------------------------------------------------------------------------
  task read_and_parse(input integer file_handle, output reg [511:0] data_out, output reg valid_out);
      
    reg [8*128:1] local_line;  // Local line buffer for the task
    integer local_r;

    begin
        valid_out = 0;
        // Read a line from the file
        local_r = $fgets(local_line, file_handle);
        if (local_r != 0) begin
            // Parse the line into a 512-bit data word
            local_r = $sscanf(local_line, "%h", data_out);
            if (local_r == 1) begin
                valid_out = 1;
            end
        end
    end

  endtask

  initial begin

    // -----------------------------------------------------------------------------
    // Setup stimulus files for w/r
    // -----------------------------------------------------------------------------

    rf_weights_file = $fopen("./test_files/mvm_test/rf_weights.in", "r");

    if (rf_weights_file == 0) begin
        $display("Error: Could not open weights file.");
        $finish;

    end

    input_vec_file = $fopen("./test_files/mvm_test/input_vec.in", "r");

    if (input_vec_file == 0) begin

        $display("Error: Could not open input file.");
        $finish;

    end

    output_file = $fopen("./test_files/mvm_test/output.out", "w");

    if (output_file == 0) begin

        $display("Error: Could not open output file.");
        $finish;

    end

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
    line_count = 11;

    #10 rst = 0;
    
    // -----------------------------------------------------------------------------
    // Using Dummy Data for now for all vectors, will adjust for different 
    // testcases later 
    // -----------------------------------------------------------------------------

    // -----------------------------------------------------------------------------
    // Test case: Write Register File 1
    // -----------------------------------------------------------------------------
    @(posedge clk);

    // -----------------------------------------------------------------------------
    // Loop through the input file for 64 lines to write data to each register file 
    // from input file
    // -----------------------------------------------------------------------------
    while (!$feof(rf_weights_file) && line_count < 76) begin

        read_and_parse(rf_weights_file, data_word, axis_rx_tvalid);
        
        if (axis_rx_tvalid) begin

            axis_rx_tdata <= data_word;
            axis_rx_tuser[8:0  ] =   9'h1;
            axis_rx_tuser[10:9 ] =  2'b11;

            if (line_count > 11) begin 
              axis_rx_tuser[line_count-1] = 0; 
            end
            
            axis_rx_tuser[line_count] = 1;
            axis_rx_tlast = 1;
            line_count = line_count + 1;

        end
        @(posedge clk);
    end

    @(posedge clk);
    axis_rx_tvalid = 0;
    axis_rx_tdata = 0;
    axis_rx_tlast = 0;

    // -----------------------------------------------------------------------------
    // Test case: Load input vector
    // -----------------------------------------------------------------------------
    @(posedge clk);
    read_and_parse(input_vec_file, data_word, axis_rx_tvalid);

    if (axis_rx_tvalid) begin

      axis_rx_tdata <= data_word;

    end

    // axis_rx_tvalid = 1;
    // axis_rx_tdata = { (DATAW/8){8'h01} };
    axis_rx_tuser[8:0  ] =   9'b0;
    axis_rx_tuser[10:9 ] =  2'b10;
    axis_rx_tuser[74:11] =  64'b0;
    axis_rx_tlast = 1;

    @(posedge clk);
    axis_rx_tvalid = 0;
    axis_rx_tdata = 0;
    axis_rx_tlast = 0;

    // -----------------------------------------------------------------------------
    // Test case: Load reduction vector
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
    // Test case: Load instruction
    // -----------------------------------------------------------------------------
    @(posedge clk);
    axis_rx_tvalid = 1;
    axis_rx_tdata[    0] = 1'b0; // RDC
    axis_rx_tdata[    1] = 1'b1; // ACM EN
    axis_rx_tdata[    2] = 1'b1; // RLS
    axis_rx_tdata[    3] = 1'b1; // LST
    axis_rx_tdata[ 12:4] = 9'b0; // ACCUM_ADDR
    axis_rx_tdata[21:13] = 9'h1; // RF_ADDR
    axis_rx_tdata[30:22] = 9'b0; // RLS_DEST
    axis_rx_tdata[   31] = 1'b1; // RLS_OP

    axis_rx_tuser[8:0  ] =  9'b0;
    axis_rx_tuser[10:9 ] =  2'b0;
    axis_rx_tuser[74:11] = 64'b0;
    axis_rx_tlast = 1;

    @(posedge clk);
    axis_rx_tvalid = 0;
    axis_rx_tdata = 0;
    axis_rx_tlast = 0;

    // -----------------------------------------------------------------------------
    // Test case: Observe output
    // -----------------------------------------------------------------------------
    @(posedge clk);
    // #300; 

    wait (axis_tx_tvalid == 1);
    if (axis_tx_tvalid) begin
      $fwrite(output_file, "Output Data: %h\n", axis_tx_tdata);
    end

    #100;
    $display("DONE");
    $finish;
  end

  // -----------------------------------------------------------------------------
  // Clock Generation
  // -----------------------------------------------------------------------------
  always #5 clk = ~clk; 

endmodule
