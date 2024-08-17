onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mvm_noc_tb/clk
add wave -noupdate /mvm_noc_tb/clk_noc
add wave -noupdate /mvm_noc_tb/rst_n
add wave -noupdate -divider MVM1-Weights
add wave -noupdate /mvm_noc_tb/top/mvm_inst_1/rf_wen
add wave -noupdate /mvm_noc_tb/top/mvm_inst_1/rf_wdata
add wave -noupdate /mvm_noc_tb/top/mvm_inst_1/rf_rdata
add wave -noupdate /mvm_noc_tb/top/mvm_inst_1/rf_waddr
add wave -noupdate -divider MVM2-Weights
add wave -noupdate /mvm_noc_tb/top/mvm_inst_2/rf_waddr
add wave -noupdate /mvm_noc_tb/top/mvm_inst_2/rf_wen
add wave -noupdate /mvm_noc_tb/top/mvm_inst_2/rf_wdata
add wave -noupdate /mvm_noc_tb/top/mvm_inst_2/rf_rdata
add wave -noupdate -divider MVM3-Weights
add wave -noupdate /mvm_noc_tb/top/mvm_inst_3/rf_waddr
add wave -noupdate /mvm_noc_tb/top/mvm_inst_3/rf_wen
add wave -noupdate /mvm_noc_tb/top/mvm_inst_3/rf_wdata
add wave -noupdate /mvm_noc_tb/top/mvm_inst_3/rf_rdata
add wave -noupdate -divider MVM4-Weights
add wave -noupdate /mvm_noc_tb/top/mvm_inst_4/rf_waddr
add wave -noupdate /mvm_noc_tb/top/mvm_inst_4/rf_wen
add wave -noupdate /mvm_noc_tb/top/mvm_inst_4/rf_wdata
add wave -noupdate /mvm_noc_tb/top/mvm_inst_4/rf_rdata
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {103572 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {4304 ps} {105696 ps}
