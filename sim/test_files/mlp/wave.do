onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/reduction_fifo_full}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/reduction_fifo_empty}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/reduction_fifo_idata}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/rf_rdata}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/rf_waddr}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/rf_wdata}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/rf_wen}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tready}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tvalid}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tdata}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tstrb}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tkeep}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tid}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tdest}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tuser}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tlast}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tvalid}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tdata}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tstrb}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tkeep}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tid}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tdest}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tuser}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_rx_tlast}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/axis_tx_tready}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/input_fifo_empty}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/input_fifo_full}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/input_fifo_idata}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/input_fifo_odata}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/accum_mem_waddr}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/accum_mem_rdata}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/datapath_results}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/truncated_datapath_results}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/inst_rf_raddr}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/inst_release_dest}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/inst_accum_raddr}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/accum_mem_waddr}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[0]/NUM_COLUMNS[1]/genblk1/genblk1/mvm_inst/accum_mem_rdata}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/reduction_fifo_full}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/reduction_fifo_empty}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/reduction_fifo_idata}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/reduction_fifo_odata}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/rf_rdata}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/rf_waddr}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/rf_wdata}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/rf_wen}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_rx_tready}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_tx_tvalid}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_tx_tdata}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_tx_tstrb}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_tx_tkeep}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_tx_tid}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_tx_tdest}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_tx_tuser}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_tx_tlast}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_rx_tvalid}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_rx_tdata}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_rx_tstrb}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_rx_tkeep}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_rx_tid}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_rx_tdest}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_rx_tuser}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_rx_tlast}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/axis_tx_tready}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/input_fifo_empty}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/input_fifo_full}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/input_fifo_idata}
add wave -noupdate {/mlp_noc_tb/top/NUM_ROWS[1]/NUM_COLUMNS[0]/genblk1/genblk1/mvm_inst/input_fifo_odata}
add wave -noupdate {/mlp_noc_tb/top/axis_in_tdata[0][0]}
add wave -noupdate {/mlp_noc_tb/top/axis_in_tdata[0][1]}
add wave -noupdate {/mlp_noc_tb/top/axis_in_tdata[1][0]}
add wave -noupdate {/mlp_noc_tb/top/axis_in_tdata[1][1]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {852708 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 485
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
WaveRestoreZoom {0 ps} {3314629 ps}
