`timescale 1ns / 1ps
`include "test_files/mlp/parameters.sv"

module mlp_noc_tb();

    logic clk, clk_noc, rst_n;
    integer i, j, k, file, input1_file, input2_file, output_file;
    integer rf_weights_file, input_vec_file, router_weights_s, input_vec_file2; 
    integer rf_weights_file_2;
    integer local_r;
    integer m,n;
    integer layer_mvm_file[NUM_LAYERS][2];  // 2D array to store file handles (assuming maximum 2 MVMs per layer)
    integer inst_layer_mvm_file[NUM_LAYERS][2];  // 2D array to store file handles (assuming maximum 2 MVMs per layer)
    integer input_file[NUM_MVMS[0]];

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
    logic [8:0      ] start_rf_addr_s;
    logic             weight_pass_s;
    logic [8:0      ] last_rf_addr_used [2]; // Store last RF address for each router
    integer NUM_PACKET_INJ = 10;

    logic [31:0] cycle_counter;
    logic counting;
    logic reset_counter;

    integer test; 

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

        for (i = 0; i < NUM_LAYERS; i = i + 1) begin
            for (j = 0; j < NUM_MVMS[i]; j = j + 1) begin
                // Use $sformatf to create the filename correctly
                string filename;
                filename = $sformatf("./test_files/mlp/layer%0d_mvm%0d_converted.mif", i, j);

                // Display the filename to debug any formatting issues
                $display("Attempting to open file: %s", filename);

                layer_mvm_file[i][j] = $fopen(filename, "r");

                if (layer_mvm_file[i][j] == 0) begin
                    $display("Error: Could not open weights file %s", filename);
                    $finish;
                end

            end
        end

        for (i = 0; i < NUM_LAYERS; i = i + 1) begin
            for (j = 0; j < NUM_MVMS[i]; j = j + 1) begin
                // Use $sformatf to create the filename correctly
                string filename;
                filename = $sformatf("./test_files/mlp/inst_layer%0d_mvm%0d_converted.mif", i, j);

                // Display the filename to debug any formatting issues
                $display("Attempting to open file: %s", filename);

                inst_layer_mvm_file[i][j] = $fopen(filename, "r");

                if (inst_layer_mvm_file[i][j] == 0) begin
                    $display("Error: Could not open weights file %s", filename);
                    $finish;
                end

            end
        end


        for (i = 0; i < NUM_MVMS[0]; i = i + 1) begin 

            string filename;
            filename = $sformatf("./test_files/mlp/inputs_mvm%0d_converted.mif", i);

            // Display the filename to debug any formatting issues
            $display("Attempting to open file: %s", filename);

            input_file[i] = $fopen(filename, "r");

            if (input_file[i] == 0) begin
                $display("Error: Could not open weights file %s", filename);
                $finish;
            end

        end

        // test = (65 + 64 - 1) / 64;  // This formula ensures rounding up if there's a remainder
        // $display("Value of test: %d", test);
        // test = (64 + 64 - 1) / 64;  // This formula ensures rounding up if there's a remainder
        // $display("Value of test: %d", test);
        // test = (128 + 64 - 1) / 64;  // This formula ensures rounding up if there's a remainder
        // $display("Value of test: %d", test);
        // test = (129 + 64 - 1) / 64;  // This formula ensures rounding up if there's a remainder
        // $display("Value of test: %d", test);

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
        // for (m = 0; m < NUM_LAYERS; m = m + 1) begin
        //     for (n = 0; n < NUM_MVMS[m]; n = n + 1) begin
        //         last_rf_addr_used[m][n] = 9'h0;  // Initialize RF addresses to 0
        //     end
        // end

        #(60ns);
        // Loop through layers to write weights
        for (i = 0; i < NUM_LAYERS; i = i + 1) begin
            start_dest_s <= 12'h001;

            for (j = 0; j < NUM_MVMS[i]; j = j + 1) begin
                // Use the last RF address for this destination, if available, otherwise start at 0
                if (last_rf_addr_used[j] === 9'hx) 
                    start_rf_addr_s <= 9'h0;  // Initialize RF address for the first time
                else
                    start_rf_addr_s <= last_rf_addr_used[j] + 9'h1; // Start from last used + 1

                for (k = 0; k < (LAYER_DIMENSION[i] + 64 - 1)/64; k = k + 1) begin

                    @(posedge clk);
                    while (!$feof(layer_mvm_file[i][j]) && line_count < USERW) begin

                        @(posedge clk);
                        read_and_parse(layer_mvm_file[i][j], local_r, data_word, axis_s_tvalid);

                        if (axis_s_tvalid) begin
                            axis_s_tdata[DATAW-1:0] = data_word;
                            axis_s_tuser[ 8:0] =   start_rf_addr_s; // Use the updated RF address
                            axis_s_tuser[10:9] =  2'b11; // Operation
                            axis_s_tdest = start_dest_s;

                            if (line_count > 11) begin 
                                axis_s_tuser[line_count-1] = 0; // 74:11
                            end
                            
                            axis_s_tuser[line_count] = 1;
                            axis_s_tlast = 1;
                            line_count = line_count + 1;
                        end
                    end

                    @(posedge clk);
                    axis_s_tuser[line_count - 1] = 0;
                    axis_s_tvalid = 0;
                    axis_s_tdata = 0;
                    axis_s_tlast = 0;



                    // Increment RF address for the next use
                    last_rf_addr_used[j] = start_rf_addr_s;
                    start_rf_addr_s = start_rf_addr_s + 9'h1; 
                    line_count = 11;
                end
                    @(posedge clk);
                    start_dest_s = start_dest_s + 12'h1;
            end
        end

        // @(posedge clk);
        // start_dest_s = 12'h001;

        // for (i = 0; i < NUM_MVMS[0]; i = i + 1) begin 

        //     while (!$feof(input_file[i])) begin

        //         @(posedge clk);
        //         read_and_parse(input_file[i], local_r, data_word, axis_s_tvalid);

        //         if (axis_s_tvalid) begin

        //         axis_s_tdata <= data_word;

        //         end

        //         axis_s_tuser[8:0  ] =   9'b0;
        //         axis_s_tuser[10:9 ] =  2'b10;
        //         axis_s_tuser[74:11] =  64'b0;
        //         axis_s_tdest = start_dest_s;
        //         axis_s_tlast = 1;

        //         @(posedge clk);
        //         axis_s_tvalid = 0;
        //         axis_s_tdata = 0;
        //         axis_s_tlast = 0;

        //     end

        //     @(posedge clk);
        //     start_dest_s = start_dest_s + 12'h001;
        // end

        // $finish;

        @(posedge clk);
        start_dest_s = 12'h001;

        for (k = 0; k < NUM_INSTRUCTIONS; k = k + 1) begin
            for (i = 0; i < NUM_LAYERS; i = i + 1) begin
                start_dest_s = 12'h001;
                for (j = 0; j < NUM_MVMS[i]; j = j + 1) begin

                    // Loop to read each line from the file until the end
                    while (!$feof(inst_layer_mvm_file[i][j])) begin

                        @(posedge clk);
                        // Read and parse each line of the file
                        read_and_parse(inst_layer_mvm_file[i][j], local_r, data_word, axis_s_tvalid);

                        // Set axis_s signals with parsed data
                        axis_s_tvalid = 1;
                        axis_s_tdata[    0] = data_word[ 0]; // RDC 7:0
                        axis_s_tdata[    1] = data_word[ 8]; // ACM EN 15:8
                        axis_s_tdata[    2] = data_word[16]; // RLS 23:16
                        axis_s_tdata[    3] = data_word[24]; // LST 31:24
                        axis_s_tdata[ 12:4] = {0, data_word[39:32]}; // ACCUM_ADDR
                        axis_s_tdata[21:13] = {0, data_word[47:40]}; // RF_ADDR 47:40
                        axis_s_tdata[30:22] = {0, data_word[55:48]}; // RLS_DEST 55:48
                        axis_s_tdata[   31] = data_word[56]; // RLS_OP

                        axis_s_tuser[8:0  ] =  9'b0;
                        axis_s_tuser[10:9 ] =  2'b0;
                        axis_s_tuser[74:11] = 64'b0;
                        axis_s_tlast = 1;
                        axis_s_tdest = start_dest_s;

                        @(posedge clk);
                        // Reset axis_s signals
                        axis_s_tvalid = 0;
                        axis_s_tdata = 0;
                        axis_s_tlast = 0;

                        
                    end // while loop for reading the entire file

                    start_dest_s = start_dest_s + 12'h001;
                    // #(500ns);

                end // inner for loop
            end // outer for loop for layers

        @(posedge clk);
        start_dest_s = 12'h001;
        counting = 1;
        reset_counter = 1;

        for (i = 0; i < NUM_MVMS[0]; i = i + 1) begin 

            while (!$feof(input_file[i])) begin

                @(posedge clk);
                read_and_parse(input_file[i], local_r, data_word, axis_s_tvalid);

                if (axis_s_tvalid) begin

                axis_s_tdata <= data_word;

                end

                axis_s_tuser[8:0  ] =   9'b0;
                axis_s_tuser[10:9 ] =  2'b10;
                axis_s_tuser[74:11] =  64'b0;
                axis_s_tdest = start_dest_s;
                axis_s_tlast = 1;

                @(posedge clk);
                axis_s_tvalid = 0;
                axis_s_tdata = 0;
                axis_s_tlast = 0;

            end

            @(posedge clk);
            start_dest_s = start_dest_s + 12'h001;
        end

            wait (axis_m_tvalid == 1);
            counting = 0;
            output_data_s[511:0] <= axis_m_tdata;

            @(posedge clk);
            $fwrite(output_file, "%h\n", output_data_s);

            $display("Calculation completed in %0d cycles", cycle_counter);
            $finish;

        end // outer for loop for instructions


    end

    // -----------------------------------------------------------------------------
    // Cycle Counter Logic
    // -----------------------------------------------------------------------------
    always @(posedge clk) begin
        if (!rst_n || reset_counter) begin
            cycle_counter <= 0;
            reset_counter <= 0;
        end else if (counting) begin
            cycle_counter <= cycle_counter + 1;
        end
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
