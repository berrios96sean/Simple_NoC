module adder #(
    parameter TDATAW       = 32,
    parameter TDESTW       =  4,
    parameter TIDW         =  2
)(
    input   wire    CLK,
    input   wire    RST_N,

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

    typedef enum logic [4:0] {

        IDLE,
        WAIT_SECOND,
        SEND_RESULT

    } state_t;

    state_t state, next_state;
    logic [TDATAW-1:0] buffer;
    logic [TDATAW-1:0] sum;

    always_ff @(posedge CLK or negedge RST_N) begin

        if (~RST_N) begin

            state  <= IDLE;
            buffer <= 0;
            sum    <= 0;

        end else begin

            state <= next_state;

        end

    end

    always_comb begin

        next_state = state;
        AXIS_S_TREADY = 0;
        AXIS_M_TVALID = 0;
        AXIS_M_TDATA = 0;
        AXIS_M_TLAST = 0;
        AXIS_M_TID = 0;
        AXIS_M_TDEST = 0;

        case (state)
            IDLE: begin

                AXIS_S_TREADY = 1;

                if (AXIS_S_TVALID) begin
                    buffer = AXIS_S_TDATA;
                    next_state = WAIT_SECOND;
                end

            end

            WAIT_SECOND: begin

                AXIS_S_TREADY = 1;

                if (AXIS_S_TVALID) begin
                    sum = buffer + AXIS_S_TDATA;
                    next_state = SEND_RESULT;
                end

            end

            SEND_RESULT: begin

                AXIS_M_TVALID = 1;
                AXIS_M_TDATA = sum;
                AXIS_M_TLAST = 1;
                AXIS_M_TDEST = 32'h00000011;

                if (AXIS_M_TREADY) begin
                    next_state = IDLE;
                end

            end

        endcase
    end

endmodule