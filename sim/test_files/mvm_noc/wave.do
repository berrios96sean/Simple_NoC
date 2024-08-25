onerror {resume}
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

add wave -noupdate -divider MVM0_1-Weights
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/rf_waddr}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/rf_wen}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/rf_wdata}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/rf_rdata}

add wave -noupdate -divider MVM0_1-Inputs
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tdata}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tdest}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tid}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tkeep}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tlast}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tready}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tstrb}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tuser}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tvalid}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tready}

add wave -noupdate -divider MVM0_1-Outputs
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tdata}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tdest}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tid}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tkeep}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tlast}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tready}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tstrb}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tuser}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tvalid}

add wave -noupdate -divider MVM0_1-IFIFO
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/input_fifo/clk}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/input_fifo/rst}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/input_fifo/push}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/input_fifo/idata}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/input_fifo/pop}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/input_fifo/odata}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/input_fifo/empty}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/input_fifo/full}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/input_fifo/almost_full}

add wave -noupdate -divider MVM1_0-Weights
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/rf_waddr}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/rf_wen}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/rf_wdata}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/rf_rdata}

add wave -noupdate -divider MVM1_0-Inputs
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_rx_tdata}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_rx_tdest}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_rx_tid}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_rx_tkeep}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_rx_tlast}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_rx_tready}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_rx_tstrb}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_rx_tuser}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_rx_tvalid}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_tx_tready}

add wave -noupdate -divider MVM1_0-Outputs
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_tx_tdata}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_tx_tdest}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_tx_tid}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_tx_tkeep}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_tx_tlast}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_tx_tready}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_tx_tstrb}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_tx_tuser}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_tx_tvalid}

add wave -noupdate -divider MVM1_0-IFIFO
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/input_fifo/clk}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/input_fifo/rst}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/input_fifo/push}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/input_fifo/idata}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/input_fifo/pop}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/input_fifo/odata}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/input_fifo/empty}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/input_fifo/full}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/input_fifo/almost_full}

add wave -noupdate -divider MVM1_1-Weights
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/rf_waddr}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/rf_wen}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/rf_wdata}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/rf_rdata}

add wave -noupdate -divider MVM1_1-Inputs
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tdata}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tdest}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tid}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tkeep}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tlast}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tready}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tstrb}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tuser}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tvalid}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tready}

add wave -noupdate -divider MVM1_1-Outputs
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tdata}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tdest}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tid}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tkeep}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tlast}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tready}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tstrb}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tuser}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tvalid}

add wave -noupdate -divider MVM1_1-IFIFO
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/input_fifo/clk}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/input_fifo/rst}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/input_fifo/push}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/input_fifo/idata}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/input_fifo/pop}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/input_fifo/odata}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/input_fifo/empty}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/input_fifo/full}
add wave -noupdate {/mvm_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/input_fifo/almost_full}

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
