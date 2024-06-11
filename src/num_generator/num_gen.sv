module num_gen #(
    parameter TDATAW       = 32,
    parameter TDESTW       =  4,
    parameter TIDW         =  2,
    parameter LFSR_DW      =  7,
    parameter LFSR_DEFAULT =  8'h00,
    parameter NUM_PACKETS  =  1
)(
    input   wire    CLK,
    input   wire    RST_N,

    input   wire    START,

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

    const  var ZERO_PAD = 24'h000000;

    logic [8:0] packet_counter;

    logic [LFSR_DW:0] g_data;
    logic [LFSR_DW:0] o_data;
    logic [1:0] g_dest;
    logic [1:0] o_dest;

    assign AXIS_M_TDATA = {ZERO_PAD,o_data};
    assign AXIS_M_TDEST = {2'b00,o_dest};
    assign AXIS_M_TID   = 0;

    always @ (posedge CLK or negedge RST_N) begin
        if (~RST_N) begin
            AXIS_S_TREADY  <=  0;
            AXIS_M_TVALID  <=  0;
            AXIS_M_TLAST   <=  0;
            o_data         <=  0;
            o_dest         <=  0;
            packet_counter <= 0;
        end else begin

            // -------------------------------------------------------
            // Flow Control
            // -------------------------------------------------------
            if (AXIS_M_TREADY == 1) begin

                AXIS_S_TREADY <= 1'b1;

            end else begin

                AXIS_S_TREADY <= 1'b0;

            end

            if (START & AXIS_M_TREADY) begin

                o_data         <= g_data;
                o_dest         <= 2'b01;

                AXIS_M_TVALID  <= 1'b1;
                packet_counter <= packet_counter + 1;
                if (packet_counter == NUM_PACKETS - 1) begin
                AXIS_M_TLAST   <= 1'b1;
                end

            end else begin

                packet_counter <= 0;
                AXIS_M_TVALID  <= 1'b0;
                AXIS_M_TLAST   <= 1'b0;

            end

        end
    end

    lfsr #(
        .LFSR_DW      (LFSR_DW),
        .LFSR_DEFAULT (LFSR_DEFAULT)
    ) lsfr_inst_data (

        .CLK          (CLK),
        .RST_N        (RST_N),
        .O_DATA       (g_data)

    );

    lfsr #(
        .LFSR_DW      (1),
        .LFSR_DEFAULT (2'b00)
    ) lsfr_inst_dest (

        .CLK          (CLK),
        .RST_N        (RST_N),
        .O_DATA       (g_dest)

    );

endmodule