module output_module #(
    parameter TDATAW       = 32,
    parameter TDESTW       =  4,
    parameter TIDW         =  2
)(
    input   wire                  CLK,
    input   wire                  RST_N,

    output  logic                 DONE,
    output  logic   [TDATAW-1:0]  DATA_O,

    // -------------------------------------------------------
    // AXI-Stream Slave Interface
    // -------------------------------------------------------
    input   wire                  AXIS_S_TVALID,
    output  logic                 AXIS_S_TREADY,
    input   wire    [TDATAW-1:0]  AXIS_S_TDATA,
    input   wire                  AXIS_S_TLAST,
    input   wire      [TIDW-1:0]  AXIS_S_TID,
    input   wire    [TDESTW-1:0]  AXIS_S_TDEST,

    // -------------------------------------------------------
    // AXI-Stream Master Interface
    // -------------------------------------------------------
    output  logic                 AXIS_M_TVALID,
    input   wire                  AXIS_M_TREADY,
    output  logic   [TDATAW-1:0]  AXIS_M_TDATA,
    output  logic                 AXIS_M_TLAST,
    output  logic     [TIDW-1:0]  AXIS_M_TID,
    output  logic   [TDESTW-1:0]  AXIS_M_TDEST
);

    logic [TDATAW-1:0] buffer;
    logic [TDESTW-1:0] dest;

    always @ (posedge CLK or negedge RST_N) begin

        if (~RST_N) begin

            AXIS_S_TREADY <= 1'b0;
            DONE          <= 0;

        end else begin

            // -------------------------------------------------------
            // Flow Control
            // -------------------------------------------------------
            if (AXIS_M_TREADY == 1) begin

                AXIS_S_TREADY <= 1'b1;

            end else begin

                AXIS_S_TREADY <= 1'b0;

            end

            if (AXIS_S_TVALID && AXIS_S_TREADY) begin

                buffer   <= AXIS_S_TDATA;
                dest     <= AXIS_S_TDEST;

                DATA_O   <= AXIS_S_TDATA;

                if (AXIS_S_TVALID) begin

                    DONE <= 1'b1;

                end

            end else begin

                DONE <= 0;

            end

        end

    end

    // -------------------------------------------------------
    // No Valid Outputs Drive low
    // -------------------------------------------------------
    assign AXIS_M_TVALID    = 0;
    assign AXIS_M_TDATA     = 0;
    assign AXIS_M_TLAST     = 0;
    assign AXIS_M_TID       = 0;
    assign AXIS_M_TDEST     = 0;

endmodule