`timescale 1ns / 1ps
`include "parameters.sv"

module mlp_noc_tb();

    logic clk, clk_noc, rst_n;
    integer i, j, file, input1_file, input2_file, output_file;
    integer rf_weights_file, input_vec_file, router_weights_s, input_vec_file2; 
    integer rf_weights_file_2;
    integer local_r;
    logic [8*(DATAW):1] line;
    logic [6:0] line_count = 0;
    logic [(DATAW)-1:0] data_word;
    integer r;

    logic [(DATAW)-1:0] output_data_s;


    logic rst;

    logic             axis_s_tvalid;
    logic [ DATAW-1:0] axis_s_tdata;
    logic [  IDW-1:0] axis_s_tid;
    logic [DESTW-1:0] axis_s_tdest;
    logic [USERW-1:0] axis_s_tuser;
    logic             axis_s_tlast;
    wire              axis_s_tready;
    
    wire              axis_m_tvalid;
    wire [ DATAW-1:0]  axis_m_tdata;
    wire [  IDW-1:0]  axis_m_tid;
    wire [DESTW-1:0]  axis_m_tdest;
    wire [USERW-1:0]  axis_m_tuser;
    wire              axis_m_tlast;
    logic             axis_m_tready;

    logic [DESTW-1:0] start_dest_s;
    logic             weight_pass_s;
    integer NUM_PACKET_INJ = 10;

    // -----------------------------------------------------------------------------
    // Function to Read a data word from I/O
    // -----------------------------------------------------------------------------
    task read_and_parse(input integer file_handle, input integer local_r, output reg [(DATAW):0] data_out, output reg valid_out);
      
        reg [8*(DATAW):1] local_line;  // Local line buffer for the task

        begin
            //valid_out = 0;
            // Read a line from the file
            local_r = $fgets(local_line, file_handle);
            if (local_r != 0) begin
                // Parse the line into a N-bit data word
                local_r = $sscanf(local_line, "%h", data_out);
                if (local_r == 1) begin
                    valid_out = 1;
                end else begin
                    valid_out = 0;
                end
            end
        end

    endtask

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

        // -----------------------------------------------------------------------------
        // Setup stimulus files for w/r
        // -----------------------------------------------------------------------------

        rf_weights_file = $fopen("./test_files/mlp/layer0_mvm0_converted.mif", "r");

        if (rf_weights_file == 0) begin
            $display("Error: Could not open weights file.");
            $finish;

        end

        rf_weights_file_2 = $fopen("./test_files/mlp/layer1_mvm0_converted.mif", "r");

        if (rf_weights_file_2 == 0) begin
            $display("Error: Could not open weights file.");
            $finish;

        end

        input_vec_file = $fopen("./test_files/mlp/inputs_mvm0_converted.mif", "r");

        if (input_vec_file == 0) begin

            $display("Error: Could not open input file.");
            $finish;

        end

        input_vec_file2 = $fopen("./test_files/mlp/inputs_mvm1_converted.mif", "r");

        if (input_vec_file2 == 0) begin

            $display("Error: Could not open input file.");
            $finish;

        end

        output_file = $fopen("./test_files/mlp/output.out", "w");

        if (output_file == 0) begin

            $display("Error: Could not open output file.");
            $finish;

        end


        rst_n = 1'b0;

        axis_s_tvalid = 0;
        axis_s_tdata = 107'b0;
        axis_s_tid = 0;
        axis_s_tdest = 0;
        axis_s_tuser = 0;
        axis_s_tlast = 0;
        axis_m_tready = 1;
        router_weights_s = 1;
        start_dest_s = 12'h001;
        line_count = 11;
        weight_pass_s = 1'h0;

        #10 rst_n = 1'b1;

        $display("Starting Simulation");

        // -----------------------------------------------------------------------------
        // Test case: Write Register File NOC 1 
        // -----------------------------------------------------------------------------
        #(60ns);

        // -----------------------------------------------------------------------------
        // Loop through the input file for 64 lines to write data to each register file 
        // from input file
        // -----------------------------------------------------------------------------
        //while (router_weights_s < (ROWS * COLUMNS) - 2) begin 

            @(posedge clk);
            while (!$feof(rf_weights_file) && line_count < USERW) begin

                @(posedge clk);
                read_and_parse(rf_weights_file, local_r, data_word, axis_s_tvalid);
                
                if (axis_s_tvalid) begin


                    axis_s_tdata[DATAW-1:0] = data_word;
                    axis_s_tuser[ 8:0] =   9'h1; // RF Address
                    axis_s_tuser[10:9] =  2'b11; // Operation
                    axis_s_tdest = 12'h001;

                    if (line_count > 11) begin 
                    axis_s_tuser[line_count-1] = 0; // 74:11
                    end
                    
                    axis_s_tuser[line_count] = 1;
                    axis_s_tlast = 1;
                    line_count = line_count + 1;

                end
                //@(posedge clk);
            end

            @(posedge clk);
            axis_s_tuser[line_count - 1] = 0;
            axis_s_tvalid = 0;
            axis_s_tdata = 0;
            axis_s_tlast = 0;

            @(posedge clk);

            //local_r = $fseek(rf_weights_file, 0, 0); // resets mvm input to first line to read
            //router_weights_s <= router_weights_s + 1; 
            //start_dest_s     <= start_dest_s + 12'h001;
            line_count = 11;


            @(posedge clk);
            while (!$feof(rf_weights_file_2) && line_count < USERW) begin

                @(posedge clk);
                read_and_parse(rf_weights_file_2, local_r, data_word, axis_s_tvalid);
                
                if (axis_s_tvalid) begin


                    axis_s_tdata[DATAW-1:0] = data_word;
                    axis_s_tuser[ 8:0] =   9'h2; // RF Address
                    axis_s_tuser[10:9] =  2'b11; // Operation
                    axis_s_tdest = 12'h001;

                    if (line_count > 11) begin 
                    axis_s_tuser[line_count-1] = 0; // 74:11
                    end
                    
                    axis_s_tuser[line_count] = 1;
                    axis_s_tlast = 1;
                    line_count = line_count + 1;

                end
                //@(posedge clk);
            end

            @(posedge clk);
            axis_s_tuser[line_count - 1] = 0;
            axis_s_tvalid = 0;
            axis_s_tdata = 0;
            axis_s_tlast = 0;

            @(posedge clk);

            //local_r = $fseek(rf_weights_file, 0, 0); // resets mvm input to first line to read
            //router_weights_s <= router_weights_s + 1; 
            //start_dest_s     <= start_dest_s + 12'h001;
            line_count = 11;

        //end


            // Write weights to second MVM
            @(posedge clk);
            while (!$feof(rf_weights_file) && line_count < USERW) begin

                @(posedge clk);
                read_and_parse(rf_weights_file, local_r, data_word, axis_s_tvalid);
                
                if (axis_s_tvalid) begin


                    axis_s_tdata[DATAW-1:0] = data_word;
                    axis_s_tuser[ 8:0] =   9'h1; // RF Address
                    axis_s_tuser[10:9] =  2'b11; // Operation
                    axis_s_tdest = 12'h002;

                    if (line_count > 11) begin 
                    axis_s_tuser[line_count-1] = 0; // 74:11
                    end
                    
                    axis_s_tuser[line_count] = 1;
                    axis_s_tlast = 1;
                    line_count = line_count + 1;

                end
                //@(posedge clk);
            end

            @(posedge clk);
            axis_s_tuser[line_count - 1] = 0;
            axis_s_tvalid = 0;
            axis_s_tdata = 0;
            axis_s_tlast = 0;

            @(posedge clk);

            //local_r = $fseek(rf_weights_file, 0, 0); // resets mvm input to first line to read
            //router_weights_s <= router_weights_s + 1; 
            //start_dest_s     <= start_dest_s + 12'h001;
            line_count = 11;

        // -----------------------------------------------------------------------------
        // Load an Input vector 1 to router 1
        // -----------------------------------------------------------------------------
        @(posedge clk);
        read_and_parse(input_vec_file, local_r, data_word, axis_s_tvalid);

        if (axis_s_tvalid) begin

        axis_s_tdata <= data_word;

        end

        axis_s_tuser[8:0  ] =   9'b0;
        axis_s_tuser[10:9 ] =  2'b10;
        axis_s_tuser[74:11] =  64'b0;
        axis_s_tdest = 12'h001;
        axis_s_tlast = 1;

        @(posedge clk);
        axis_s_tvalid = 0;
        axis_s_tdata = 0;
        axis_s_tlast = 0;

                @(posedge clk);
        read_and_parse(input_vec_file2, local_r, data_word, axis_s_tvalid);

        if (axis_s_tvalid) begin

        axis_s_tdata <= data_word;

        end

        axis_s_tuser[8:0  ] =   9'b0;
        axis_s_tuser[10:9 ] =  2'b10;
        axis_s_tuser[74:11] =  64'b0;
        axis_s_tdest = 12'h002;
        axis_s_tlast = 1;

        @(posedge clk);
        axis_s_tvalid = 0;
        axis_s_tdata = 0;
        axis_s_tlast = 0;

        //local_r = $fseek(input_vec_file, 0, 0); // reset file pointer for input vector
        // load second input vector to second mvm router

        // -----------------------------------------------------------------------------
        // Test case: Load first MVM instruction router 1 set to accumulate
        // -----------------------------------------------------------------------------
        @(posedge clk);
        axis_s_tvalid = 1;
        axis_s_tdata[    0] = 1'b0; // RDC
        axis_s_tdata[    1] = 1'b0; // ACM EN
        axis_s_tdata[    2] = 1'b1; // RLS
        axis_s_tdata[    3] = 1'b1; // LST
        axis_s_tdata[ 12:4] = 9'h1; // ACCUM_ADDR
        axis_s_tdata[21:13] = 9'h1; // RF_ADDR
        axis_s_tdata[30:22] = 9'h2; // RLS_DEST
        axis_s_tdata[   31] = 1'b0; // RLS_OP

        axis_s_tuser[8:0  ] =  9'b0;
        axis_s_tuser[10:9 ] =  2'b0;
        axis_s_tuser[74:11] = 64'b0;
        axis_s_tlast = 1;
        axis_s_tdest = 12'h001;

        @(posedge clk);
        axis_s_tvalid = 0;
        axis_s_tdata = 0;
        axis_s_tlast = 0;

        // second mvm for output send to first layer
        @(posedge clk);
        axis_s_tvalid = 1;
        axis_s_tdata[    0] = 1'b1; // RDC
        axis_s_tdata[    1] = 1'b0; // ACM EN
        axis_s_tdata[    2] = 1'b1; // RLS
        axis_s_tdata[    3] = 1'b1; // LST
        axis_s_tdata[ 12:4] = 9'h1; // ACCUM_ADDR
        axis_s_tdata[21:13] = 9'h1; // RF_ADDR
        axis_s_tdata[30:22] = 9'h1; // RLS_DEST
        axis_s_tdata[   31] = 1'b1; // RLS_OP

        axis_s_tuser[8:0  ] =  9'b0;
        axis_s_tuser[10:9 ] =  2'b0;
        axis_s_tuser[74:11] = 64'b0;
        axis_s_tlast = 1;
        axis_s_tdest = 12'h002;

        @(posedge clk);
        axis_s_tvalid = 0;
        axis_s_tdata = 0;
        axis_s_tlast = 0;

        // second mvm output accumulated with first MVM output
        @(posedge clk);
        axis_s_tvalid = 1;
        axis_s_tdata[    0] = 1'b0; // RDC
        axis_s_tdata[    1] = 1'b0; // ACM EN
        axis_s_tdata[    2] = 1'b1; // RLS
        axis_s_tdata[    3] = 1'b1; // LST
        axis_s_tdata[ 12:4] = 9'b0; // ACCUM_ADDR
        axis_s_tdata[21:13] = 9'h2; // RF_ADDR
        axis_s_tdata[30:22] = 9'h3; // RLS_DEST
        axis_s_tdata[   31] = 1'b1; // RLS_OP

        axis_s_tuser[8:0  ] =  9'b0;
        axis_s_tuser[10:9 ] =  2'b0;
        axis_s_tuser[74:11] = 64'b0;
        axis_s_tlast = 1;
        axis_s_tdest = 12'h001;

        @(posedge clk);
        axis_s_tvalid = 0;
        axis_s_tdata = 0;
        axis_s_tlast = 0;

        wait (axis_m_tvalid == 1);
        output_data_s[511:0] <= axis_m_tdata;

        @(posedge clk);
        $fwrite(output_file, "%h\n", output_data_s);


        #(2000ns); // wait for data to go through design
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


endmodule: mlp_noc_tb
