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
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {143415 ps} 0}
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
WaveRestoreZoom {0 ps} {183750 ps}
