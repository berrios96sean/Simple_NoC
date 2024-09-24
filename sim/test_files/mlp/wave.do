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
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {925094 ps} 0}
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
WaveRestoreZoom {0 ps} {4142250 ps}
