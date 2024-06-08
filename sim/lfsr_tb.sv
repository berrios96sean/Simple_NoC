`timescale 1ns / 1ps
`include "parameters.sv"

module lfsr_tb();

    logic clk, rst_n;
    logic [LFSR_DW:0] o_data;

    // -------------------------------------
    // 100MHz Clock
    // -------------------------------------
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin

    rst_n = 1'b0;

    #(40ns);

    rst_n = 1'b1;

    #(200ns);
    $finish;

    end

    lfsr #(
        .LFSR_DW      (LFSR_DW),
        .LFSR_DEFAULT (LFSR_DEFAULT)
    ) lsfr_inst (

        .CLK          (clk),
        .RST_N        (rst_n),
        .O_DATA       (o_data)

    );


endmodule