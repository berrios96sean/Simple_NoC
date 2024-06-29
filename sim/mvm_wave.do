onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mvm_tb/uut/input_fifo_idata
add wave -noupdate /mvm_tb/uut/input_fifo_odata
add wave -noupdate /mvm_tb/uut/inst_fifo_idata
add wave -noupdate /mvm_tb/uut/inst_fifo_odata
add wave -noupdate /mvm_tb/uut/reduction_fifo_idata
add wave -noupdate /mvm_tb/uut/reduction_fifo_odata
add wave -noupdate /mvm_tb/uut/output_fifo_odata
add wave -noupdate /mvm_tb/uut/output_fifo_empty
add wave -noupdate /mvm_tb/uut/rf_rdata
add wave -noupdate /mvm_tb/uut/rf_waddr
add wave -noupdate /mvm_tb/uut/rf_wdata
add wave -noupdate /mvm_tb/uut/rf_wen
add wave -noupdate /mvm_tb/uut/tuser_op
add wave -noupdate /mvm_tb/uut/tuser_rf_addr
add wave -noupdate /mvm_tb/uut/tuser_rf_en
add wave -noupdate /mvm_tb/uut/tx_tuser_op
add wave -noupdate /mvm_tb/uut/output_data_fifo/idata
add wave -noupdate /mvm_tb/uut/output_data_fifo/odata
add wave -noupdate {/mvm_tb/uut/generate_datapath[0]/datapath_inst/i_dataa}
add wave -noupdate {/mvm_tb/uut/generate_datapath[0]/datapath_inst/i_datab}
add wave -noupdate {/mvm_tb/uut/generate_datapath[0]/datapath_inst/i_datac}
add wave -noupdate /mvm_tb/uut/rr_input_operands
add wave -noupdate /mvm_tb/uut/rr_inst_valid
add wave -noupdate /mvm_tb/uut/rf_rdata
add wave -noupdate /mvm_tb/uut/datapath_ovalid
add wave -noupdate /mvm_tb/uut/datapath_results
add wave -noupdate /mvm_tb/uut/truncated_datapath_results
add wave -noupdate /mvm_tb/uut/axis_rx_tready
add wave -noupdate /mvm_tb/uut/axis_tx_tready
add wave -noupdate /mvm_tb/uut/output_fifo_empty
add wave -noupdate {/mvm_tb/uut/generate_datapath[0]/datapath_inst/dpe_inst/i_valid}
add wave -noupdate {/mvm_tb/uut/generate_datapath[0]/datapath_inst/dpe_inst/o_valid}
add wave -noupdate {/mvm_tb/uut/generate_datapath[0]/datapath_inst/accum_inst/i_valid}
add wave -noupdate {/mvm_tb/uut/generate_datapath[0]/datapath_inst/accum_inst/o_valid}
add wave -noupdate {/mvm_tb/uut/generate_datapath[0]/datapath_inst/reduce_inst/i_valid}
add wave -noupdate {/mvm_tb/uut/generate_datapath[0]/datapath_inst/reduce_inst/o_valid}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {167543 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 297
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
WaveRestoreZoom {0 ps} {204750 ps}
