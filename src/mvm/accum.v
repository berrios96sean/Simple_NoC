module accum # (
	parameter DATAW = 32,
	parameter DEPTH = 512,
	parameter ADDRW = $clog2(DEPTH),
	parameter NUM_VALIDS = 10  // New parameter to specify the number of valids to accumulate for
)(
	input              clk,
	input              rst,
	input              i_valid,
	input  [DATAW-1:0] i_data,
	input  [ADDRW-1:0] i_addr,
	input              i_accum,
	input              i_last,
	input  [7:0]       num_valids,  // Number of valids to accumulate for
	output             o_valid,
	output             v_count_rst,
	output [DATAW-1:0] o_result
);

reg [ADDRW-1:0] accum_mem_waddr;
reg [DATAW-1:0] accum_mem_wdata;
wire [DATAW-1:0] accum_mem_rdata;
reg accum_mem_wen;

reg r_accum, rr_accum, r_valid, rr_valid, rrr_valid, r_last, rr_last;
reg r3_last, r4_last;
reg r3_valid, r3_accum, r4_valid, r4_accum;
reg v_count_rst_r1;
reg [ADDRW-1:0] r_addr, rr_addr;
reg [ADDRW-1:0] r3_addr, r4_addr;
reg [DATAW-1:0] r_data, rr_data, r_result;
reg [DATAW-1:0] r3_data, r4_data;

// Counter for valid accumulations
reg [7:0] valid_count;

reg fifo_pop;
reg sim_pop;
wire [DATAW-1:0] fifo_data;
wire fifo_accum;


// State machine states
localparam IDLE = 2'd0;
localparam ACCUMULATE = 2'd1;
localparam WAIT_CYCLES = 2'd2;

reg [1:0] state, next_state;
reg [1:0] wait_counter;

memory_block # (
	.DATAW(DATAW),
	.DEPTH(DEPTH)
) accum_mem (
	.clk(clk),
	.rst(rst),
	.waddr(accum_mem_waddr),
	.wen(accum_mem_wen),
	.wdata(r_result),
	.raddr(i_addr),
	.rdata(accum_mem_rdata)
);

// FIFO instance
fifo # (
	.DATAW(DATAW+1),
	.DEPTH(128),
	.ADDRW($clog2(128))
) data_fifo (
	.clk(clk),
	.rst(rst),
	.push(i_valid),
	.idata({i_data, i_accum}),
	.pop(fifo_pop),
	.odata({fifo_data,fifo_accum}),
	.empty(fifo_empty),
	.full(),
	.almost_full()
);


always @ (posedge clk or posedge rst) begin
	if (rst) begin
		state <= IDLE;
		wait_counter <= 2'd0;
		valid_count <= 8'd0;
		fifo_pop <= 1'b0;
		accum_mem_wen <= 1'b0;
		r_result <= 'd0;
	end else begin
		state <= next_state;
		if (state == WAIT_CYCLES) begin
			wait_counter <= wait_counter + 1;
		end else begin
			wait_counter <= 2'd0;
		end
		if (state == ACCUMULATE) begin
			valid_count <= valid_count + 1;
			accum_mem_wen <= 1'b1;
		end else begin
			accum_mem_wen <= 1'b0;
		end
	end
end

always @ (*) begin
	next_state = state;
	fifo_pop = 1'b0;
	case (state)
		IDLE: begin
			if (r_valid && !fifo_empty) begin
				next_state = ACCUMULATE;
				fifo_pop = 1'b1;
			end
		end
		ACCUMULATE: begin
			if (valid_count < num_valids) begin
				next_state = WAIT_CYCLES;
			end else begin
				next_state = IDLE;
			end
		end
		WAIT_CYCLES: begin
			if (wait_counter == 2'd3) begin
				if (!fifo_empty) begin
					next_state = ACCUMULATE;
					fifo_pop = 1'b1;
				end else begin 
					next_state = ACCUMULATE;
					sim_pop = 1'b1;
				end
			end
		end
	endcase
end

// Pipeline inputs to align with memory output
always @ (posedge clk or posedge rst) begin
	if (rst) begin
		r_accum <= 1'b0; rr_accum <= 1'b0;
		r3_accum <= 1'b0; r4_accum <= 1'b0;
		r_valid <= 1'b0; rr_valid <= 1'b0; rrr_valid <= 1'b0;
		r3_valid <= 1'b0; r4_valid <= 1'b0;
		r_addr <= 'd0; rr_addr <= 'd0;
		r3_addr <= 'd0; r4_addr <= 'd0;
		r_data <= 'd0; rr_data <= 'd0;
		r3_data <= 'd0; r4_data <= 'd0;
		r_last <= 1'b0; rr_last <= 1'b0;
		r3_last <= 1'b0; r4_last <= 1'b0;
	end else begin
		r_accum  <= i_accum;
		rr_accum <= r_accum;
		r3_accum <= rr_accum;
		r4_accum <= r3_accum;
		r_addr   <= i_addr;
		rr_addr  <= r_addr;
		r3_addr  <= rr_addr;
		r4_addr  <= r3_addr;
		r_valid  <= i_valid;
		rr_valid <= r_valid;
		r3_valid <= rr_valid;
		r4_valid <= r3_valid;
		r_last   <= i_last;
		rr_last  <= r_last;
		r3_last  <= rr_last;
		r4_last  <= r3_last;
		r_data   <= i_data;
		rr_data  <= r_data;
		r3_data  <= rr_data;
		r4_data  <= r3_data;
		
		// Perform accumulation
		if (fifo_pop && fifo_accum) begin
			r_result <= fifo_data + accum_mem_rdata;
			if (valid_count == num_valids - 1) begin 
				rrr_valid <= 1;
				v_count_rst_r1 <= 1; 
			end
		end else if (fifo_pop) begin
			r_result <= fifo_data;
			if (valid_count == num_valids - 1) begin 
				rrr_valid <= 1;
				v_count_rst_r1 <= 1; 
			end
		end else begin
			rrr_valid <= 0;
			v_count_rst_r1 <= 0;
		end
		accum_mem_waddr <= rr_addr;

		if (valid_count >= num_valids) begin 
			valid_count <= 0;
		end
	end
end

assign v_count_rst = v_count_rst_r1;
assign o_valid = rrr_valid;
assign o_result = r_result;

endmodule
