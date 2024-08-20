onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mvm_noc_tb/clk
add wave -noupdate /mvm_noc_tb/clk_noc
add wave -noupdate /mvm_noc_tb/rst_n
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
add wave -noupdate -divider MVM2-Weights
add wave -noupdate /mvm_noc_tb/top/mvm_inst_2/rf_waddr
add wave -noupdate /mvm_noc_tb/top/mvm_inst_2/rf_wen
add wave -noupdate /mvm_noc_tb/top/mvm_inst_2/rf_wdata
add wave -noupdate /mvm_noc_tb/top/mvm_inst_2/rf_rdata
add wave -noupdate -divider MVM2-Inputs
add wave -noupdate /mvm_noc_tb/top/mvm_inst_2/axis_rx_tdata
add wave -noupdate /mvm_noc_tb/top/mvm_inst_2/axis_rx_tdest
add wave -noupdate /mvm_noc_tb/top/mvm_inst_2/axis_rx_tid
add wave -noupdate /mvm_noc_tb/top/mvm_inst_2/axis_rx_tkeep
add wave -noupdate /mvm_noc_tb/top/mvm_inst_2/axis_rx_tlast
add wave -noupdate /mvm_noc_tb/top/mvm_inst_2/axis_rx_tstrb
add wave -noupdate /mvm_noc_tb/top/mvm_inst_2/axis_rx_tuser
add wave -noupdate /mvm_noc_tb/top/mvm_inst_2/axis_rx_tvalid
add wave -noupdate /mvm_noc_tb/top/mvm_inst_2/axis_tx_tready
add wave -noupdate -divider MVM3-Weights
add wave -noupdate /mvm_noc_tb/top/mvm_inst_3/rf_waddr
add wave -noupdate /mvm_noc_tb/top/mvm_inst_3/rf_wen
add wave -noupdate /mvm_noc_tb/top/mvm_inst_3/rf_wdata
add wave -noupdate /mvm_noc_tb/top/mvm_inst_3/rf_rdata
add wave -noupdate -divider MVM3-Inputs
add wave -noupdate /mvm_noc_tb/top/mvm_inst_3/axis_rx_tvalid
add wave -noupdate /mvm_noc_tb/top/mvm_inst_3/axis_rx_tdata
add wave -noupdate /mvm_noc_tb/top/mvm_inst_3/axis_rx_tstrb
add wave -noupdate /mvm_noc_tb/top/mvm_inst_3/axis_rx_tkeep
add wave -noupdate /mvm_noc_tb/top/mvm_inst_3/axis_rx_tid
add wave -noupdate /mvm_noc_tb/top/mvm_inst_3/axis_rx_tdest
add wave -noupdate /mvm_noc_tb/top/mvm_inst_3/axis_rx_tuser
add wave -noupdate /mvm_noc_tb/top/mvm_inst_3/axis_rx_tlast
add wave -noupdate /mvm_noc_tb/top/mvm_inst_3/axis_tx_tready
add wave -noupdate -divider MVM4-Weights
add wave -noupdate /mvm_noc_tb/top/mvm_inst_4/rf_waddr
add wave -noupdate /mvm_noc_tb/top/mvm_inst_4/rf_wen
add wave -noupdate /mvm_noc_tb/top/mvm_inst_4/rf_wdata
add wave -noupdate /mvm_noc_tb/top/mvm_inst_4/rf_rdata
add wave -noupdate -divider MVM4-Inputs
add wave -noupdate /mvm_noc_tb/top/mvm_inst_4/axis_rx_tvalid
add wave -noupdate /mvm_noc_tb/top/mvm_inst_4/axis_rx_tdata
add wave -noupdate /mvm_noc_tb/top/mvm_inst_4/axis_rx_tstrb
add wave -noupdate /mvm_noc_tb/top/mvm_inst_4/axis_rx_tkeep
add wave -noupdate /mvm_noc_tb/top/mvm_inst_4/axis_rx_tid
add wave -noupdate /mvm_noc_tb/top/mvm_inst_4/axis_rx_tdest
add wave -noupdate /mvm_noc_tb/top/mvm_inst_4/axis_rx_tuser
add wave -noupdate /mvm_noc_tb/top/mvm_inst_4/axis_rx_tlast
add wave -noupdate /mvm_noc_tb/top/mvm_inst_4/axis_tx_tready
add wave -noupdate -divider AXIS-Mesh-NOC
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_in_tdest
add wave -noupdate -subitemconfig {{/mvm_noc_tb/top/axis_mesh_inst/axis_in_tdata[0]} -expand {/mvm_noc_tb/top/axis_mesh_inst/axis_in_tdata[1]} -expand} /mvm_noc_tb/top/axis_mesh_inst/axis_in_tdata
add wave -noupdate -expand -subitemconfig {{/mvm_noc_tb/top/axis_mesh_inst/axis_in_tuser[0]} -expand} /mvm_noc_tb/top/axis_mesh_inst/axis_in_tuser
add wave -noupdate -subitemconfig {{/mvm_noc_tb/top/axis_mesh_inst/axis_out_tdata[0]} -expand {/mvm_noc_tb/top/axis_mesh_inst/axis_out_tdata[1]} -expand} /mvm_noc_tb/top/axis_mesh_inst/axis_out_tdata
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_out_tdest
add wave -noupdate -expand /mvm_noc_tb/top/axis_mesh_inst/axis_out_tuser
add wave -noupdate -divider SHIM-GEN
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_in_tvalid
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_in_tdata
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_in_tlast
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_in_tuser
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_in_tid
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_in_tdest
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_out_tready
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_in_tready
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_out_tvalid
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_out_tdata
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_out_tlast
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_out_tuser
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_out_tid
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/axis_out_tdest
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/data_in
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/dest_in
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/user_in
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/data_out
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/dest_out
add wave -noupdate /mvm_noc_tb/top/axis_mesh_inst/user_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3238057 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 307
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
WaveRestoreZoom {0 ps} {3722250 ps}
