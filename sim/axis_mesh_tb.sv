`timescale 1ns / 1ps
`include "parameters.sv"

module axis_mesh_tb();

    logic clk, clk_noc, rst_n;
    integer i, j, file, input1_file, input2_file, output_file;

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

    // -------------------------------------------------------
    // Misc Signals
    // -------------------------------------------------------

    logic              start;
    logic              start2;
    logic              done;
    logic [TDATAW-1:0] data_o1;
    logic [TDATAW-1:0] data_o2;
    logic [TDATAW-1:0] data_o3;

    initial begin

        file = $fopen("sim_status.txt", "w");

        if (file == 0) begin

            $display("Error: Could not open output file.");
            $finish;

        end

        input1_file = $fopen("input1.in", "w");

        if (input1_file == 0) begin

            $display("Error: Could not open input1 file.");
            $finish;

        end

        input2_file = $fopen("input2.in", "w");

        if (input2_file == 0) begin

            $display("Error: Could not open input2 file.");
            $finish;

        end

        output_file = $fopen("output.out", "w");

        if (output_file == 0) begin

            $display("Error: Could not open output file.");
            $finish;

        end

        rst_n  = 1'b0;

        #(50ns);

        rst_n  = 1'b1;

        #(125ns);

        for (int i = 0; i < NUM_PACKET_INJ; i++) begin

            start  = 1'b1;

            #(5ns);

            $fwrite(input1_file, "Input: %h\n", data_o1);
            $fwrite(input2_file, "Input: %h\n", data_o2);

            #(5ns);

            start  = 1'b0;

            wait (done == 1);

            #(5ns);

            $fwrite(output_file, "Sum: %h\n", data_o3[8:0]);

            #(15ns);

        end

        #(200ns);
        $fwrite(file, "Simulation finished");
    	$finish;
    end

    noc_adder_top top (

        .CLK      (clk),
        .CLK_NOC  (clk_noc),
        .RST_N    (rst_n),
        .START    (start),
        .DONE     (done),
        .IDATA_O1 (data_o1),
        .IDATA_O2 (data_o2),
        .ODATA_O  (data_o3)

    );


endmodule: axis_mesh_tb
