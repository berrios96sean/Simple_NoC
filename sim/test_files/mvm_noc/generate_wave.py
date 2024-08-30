import argparse

def generate_wave_do(rows, columns, output_file="wave.do"):
    with open(output_file, 'w') as f:
        # Common setup for the wave.do file
        f.write("""onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mvm_noc_tb/clk
add wave -noupdate /mvm_noc_tb/clk_noc
add wave -noupdate /mvm_noc_tb/rst_n
add wave -noupdate /mvm_noc_tb/axis_s_tdata
add wave -noupdate /mvm_noc_tb/axis_m_tdata
add wave -noupdate /mvm_noc_tb/data_word
add wave -noupdate /mvm_noc_tb/axis_s_tvalid
add wave -noupdate /mvm_noc_tb/top/mesh_in_tdata
add wave -noupdate /mvm_noc_tb/top/mesh_out_tdata
add wave -noupdate /mvm_noc_tb/router_weights_s
add wave -noupdate /mvm_noc_tb/weight_pass_s
add wave -noupdate /mvm_noc_tb/output_data_s
add wave -noupdate -divider axis_passthrough
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst/CLK
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst/RST_N
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst/AXIS_S_TVALID
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst/AXIS_S_TDATA
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst/AXIS_S_TLAST
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst/AXIS_S_TID
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst/AXIS_S_TUSER
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst/AXIS_S_TDEST
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst/AXIS_M_TREADY
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst/AXIS_S_TREADY
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst/AXIS_M_TVALID
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst/AXIS_M_TDATA
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst/AXIS_M_TLAST
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst/AXIS_M_TID
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst/AXIS_M_TUSER
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst/AXIS_M_TDEST
""")
        
        # Generating waves for each MVM instance
        for i in range(rows):
            for j in range(columns):
                if (i == 0 and j == 0) | (i == 1 and j == 1):
                    continue  # Skip axis_passthrough at [0][0] and [1][1]
                
                instance_name = f"/mvm_noc_tb/top/NUM_ROWS[{i}]/NUM_COLUMNS[{j}]/genblk1/genblk1/mvm_inst"
                
                f.write(f"\nadd wave -noupdate -divider MVM{i}_{j}-Weights\n")
                f.write(f"add wave -noupdate {{{instance_name}/rf_waddr}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/rf_wen}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/rf_wdata}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/rf_rdata}}\n")

                f.write(f"\nadd wave -noupdate -divider MVM{i}_{j}-Inputs\n")
                f.write(f"add wave -noupdate {{{instance_name}/axis_rx_tdata}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/axis_rx_tdest}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/axis_rx_tid}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/axis_rx_tkeep}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/axis_rx_tlast}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/axis_rx_tready}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/axis_rx_tstrb}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/axis_rx_tuser}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/axis_rx_tvalid}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/axis_tx_tready}}\n")

                f.write(f"\nadd wave -noupdate -divider MVM{i}_{j}-Outputs\n")
                f.write(f"add wave -noupdate {{{instance_name}/axis_tx_tdata}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/axis_tx_tdest}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/axis_tx_tid}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/axis_tx_tkeep}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/axis_tx_tlast}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/axis_tx_tready}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/axis_tx_tstrb}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/axis_tx_tuser}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/axis_tx_tvalid}}\n")

                f.write(f"\nadd wave -noupdate -divider MVM{i}_{j}-IFIFO\n")
                f.write(f"add wave -noupdate {{{instance_name}/input_fifo/clk}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/input_fifo/rst}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/input_fifo/push}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/input_fifo/idata}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/input_fifo/pop}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/input_fifo/odata}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/input_fifo/empty}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/input_fifo/full}}\n")
                f.write(f"add wave -noupdate {{{instance_name}/input_fifo/almost_full}}\n")

                f.write(f"""
                    add wave -noupdate -divider MVM{i}_{j}-Test_signals\n
                    add wave -noupdate {{{instance_name}/output_fifo_empty}}\n
                    add wave -noupdate {{{instance_name}/output_fifo_full}}\n
                    add wave -noupdate {{{instance_name}/output_fifo_almost_full}}\n
                    add wave -noupdate {{{instance_name}/output_fifo_odest}}\n
                    add wave -noupdate {{{instance_name}/output_fifo_oop}}\n
                    add wave -noupdate {{{instance_name}/output_fifo_odata}}\n
                    add wave -noupdate {{{instance_name}/output_fifo_pop}}\n
                    add wave -noupdate {{{instance_name}/accum_mem_waddr}}\n
                    add wave -noupdate {{{instance_name}/accum_mem_rdata}}\n
                    add wave -noupdate {{{instance_name}/datapath_results}}\n
                    add wave -noupdate {{{instance_name}/datapath_ovalid}}\n
                    add wave -noupdate {{{instance_name}/datapath_dest}}\n
                    add wave -noupdate {{{instance_name}/datapath_op}}"")\n
                        """)
                
        # Additional common signals
        f.write("""
add wave -noupdate -divider AXIS-Passthrough-Output
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst2/AXIS_S_TVALID
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst2/AXIS_S_TDATA
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst2/AXIS_S_TLAST
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst2/AXIS_S_TID
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst2/AXIS_S_TUSER
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst2/AXIS_S_TDEST
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst2/AXIS_M_TREADY
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst2/AXIS_S_TREADY
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst2/AXIS_M_TVALID
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst2/AXIS_M_TDATA
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst2/AXIS_M_TLAST
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst2/AXIS_M_TID
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst2/AXIS_M_TUSER
add wave -noupdate /mvm_noc_tb/top/axis_passthrough_inst2/AXIS_M_TDEST            
add wave -noupdate -divider AXIS-Mesh-NOC
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_in_tdest
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_in_tdata
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_out_tdata
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_out_tdest
add wave -noupdate -divider SHIM-GEN
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_in_tvalid
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_in_tdata
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_in_tlast
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_in_tid
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_in_tdest
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_out_tready
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_in_tready
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_out_tvalid
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_out_tdata
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_out_tlast
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_out_tid
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_out_tdest
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/data_in
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/dest_in
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/data_out
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/dest_out
add wave -noupdate -divider MESH
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/noc/clk
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/noc/rst_n
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/noc/data_in
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/noc/dest_in
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/noc/is_tail_in
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/noc/send_in
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/noc/credit_in
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/noc/credit_out
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/noc/data_out
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/noc/dest_out
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/noc/is_tail_out
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/noc/send_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1501553 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 362
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {2724750 ps}
""")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate wave.do file based on ROWS and COLUMNS.")
    parser.add_argument("--rows", type=int, required=True, help="Number of ROWS in the design")
    parser.add_argument("--columns", type=int, required=True, help="Number of COLUMNS in the design")
    parser.add_argument("--output", type=str, default="wave.do", help="Output filename for wave.do")
    
    args = parser.parse_args()
    
    generate_wave_do(args.rows, args.columns, args.output)
