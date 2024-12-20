/**
Datapath Module
Facilitates the workflow of data for a singular DPE of the MVM module

Parameters:
LANES: The number of elements each DPE can handle at once (Max number of elements in a subset of the input vector)
DATAW: Bit width of data
IPREC: Precision of elements in reduction vector
OPREC: Precision of elements in output vector
MEM_DEPTH: Depth of the accumulation memory
ADDRW: Width of the memory address used for accumulation

Inputs:
i_valid: Valid signal for all data
i_dataa: Vector data
i_datab: Weight data
i_datac: Reduce data
i_accum_addr: Accumulation memory address
i_accum: Enable signal for accumulation
i_last: The last subset in the input vector. (Release)
i_reduce: Enable signal for reduction

Outputs:
o_valid: Valid signal for output result
o_result: Result
**/
module datapath # (
	parameter LANES = 64,
	parameter DATAW = 512,
	parameter IPREC = 8,
	parameter OPREC = 32,
	parameter MEM_DEPTH = 512,
	parameter ADDRW = $clog2(MEM_DEPTH)
)(
	input              	clk,
	input              	rst,
	input              	i_valid,
	input  [DATAW-1:0]	i_dataa,
	input  [DATAW-1:0]	i_datab,
	input  [IPREC-1:0] 	i_datac,
	input  [ADDRW-1:0] 	i_accum_addr,
	input              	i_accum,
	input              	i_last,
	input              	i_reduce,
	output             	o_valid,
	output [OPREC-1:0] 	o_result
);

localparam DPE_LATENCY = 8;
localparam ACCUM_LATENCY = 2;

wire dpe_valid, dpe_accum, dpe_last, accum_valid, accum_valid_r, accum_reduce;
wire dpe_valid_delayed, dpe_accum_delayed, dpe_last_delayed;
wire [OPREC-1:0] dpe_result, accum_result, accum_result_r;
wire [OPREC-1:0] dpe_result_delayed;
wire [IPREC-1:0] accum_datac;
wire [ADDRW-1:0] dpe_accum_addr;
wire [ADDRW-1:0] dpe_accum_addr_delayed;

reg [7:0] valid_counter;  // Counter to track the number of valid signals
wire      v_count_rst;

// Counter logic
always @(posedge clk or posedge rst) begin
	if (v_count_rst || rst) begin
		valid_counter <= 8'd0;
	end else if (i_valid) begin
		valid_counter <= valid_counter + 8'd1;
	end
end


pipeline # (
	.DELAY(DPE_LATENCY),
	.WIDTH(ADDRW+2)
) dpe_pipeline (
	.clk(clk),
	.rst(rst),
	.data_in({i_accum_addr, i_accum, i_last}),
	.data_out({dpe_accum_addr, dpe_accum, dpe_last})
);

pipeline # (
	.DELAY(DPE_LATENCY+ACCUM_LATENCY+2),
	.WIDTH(IPREC+1)
) accum_pipeline (
	.clk(clk),
	.rst(rst),
	.data_in({i_datac, i_reduce}),
	.data_out({accum_datac, accum_reduce})
);

dpe # (
	.LANES(LANES),
	.DATAW(DATAW),
	.IPREC(IPREC),
	.OPREC(OPREC)
) dpe_inst (
	.clk(clk),
	.rst(rst),
	.i_valid(i_valid),
	.i_dataa(i_dataa),
	.i_datab(i_datab),
	.o_valid(dpe_valid),
	.o_result(dpe_result)
);

accum # (
	.DATAW(OPREC),
	.DEPTH(MEM_DEPTH)
) accum_inst (
	.clk(clk),
	.rst(rst),
	.i_valid(dpe_valid),
	.i_data(dpe_result),
	.i_addr(dpe_accum_addr),
	.i_accum(dpe_accum),
	.i_last(dpe_last),
	.num_valids(valid_counter),
	.o_valid(accum_valid),
	.v_count_rst(v_count_rst),
	.o_result(accum_result)
);

pipeline # (
	.DELAY(ACCUM_LATENCY),
	.WIDTH(OPREC+1)
) accum_pipeline2 (
	.clk(clk),
	.rst(rst),
	.data_in({accum_result, accum_valid}),
	.data_out({accum_result_r, accum_valid_r})
);

reduce # (
	.IPREC(IPREC),
	.OPREC(OPREC)
) reduce_inst (
	.clk(clk),
	.rst(rst),
	.i_valid(accum_valid_r),
	.i_dataa(accum_result_r),
	.i_datab(accum_datac),
	.i_reduce(accum_reduce),
	.o_valid(o_valid),
	.o_result(o_result)
);

endmodule