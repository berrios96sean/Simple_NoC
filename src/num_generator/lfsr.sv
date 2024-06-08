module lfsr #(
    parameter LFSR_DW       = 8,
    parameter LFSR_DEFAULT  = 8'h01
)(

    input  wire              CLK,
    input  wire              RST_N,
    output logic [LFSR_DW:0] O_DATA

);

    wire feedback;

    assign feedback = O_DATA[LFSR_DW] ^ O_DATA[0];

    always @ (posedge CLK or negedge RST_N) begin

        if (RST_N) begin
            O_DATA <= LFSR_DEFAULT;
        end else begin
            O_DATA <= {O_DATA[LFSR_DW - 1:0], feedback};
        end
    end

endmodule