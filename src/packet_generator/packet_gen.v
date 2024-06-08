`include "define.h"

module packet_gen (

    // ------------------------------------------
    // Inputs
    // ------------------------------------------
    input wire        CLK,
    input wire        RST_N,
    input wire [7:0]  I_NUM.
    input wire [1:0]  SRC,
    input wire [1:0]  DST,
    input wire [1:0]  VCH,
    input wire [3:0]  LEN,

    // ------------------------------------------
    // Outputs
    // ------------------------------------------
    output reg [34:0] O_DATA,
    output reg        O_VALID,
    output reg [1:0]  O_VCH

);

    reg [3:0] id_r;
    reg [3:0] flit_count;

    always @ (posedge CLK or negedge RST_N) begin
        if (RST_N) begin

        end else if (flit_count < LEN) begin

            flit_count <= flit_count + 1;

        end else begin

            O_VALID    <= 1'b0;
        end
        end

endmodule