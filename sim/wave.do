onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /axis_mesh_tb/clk
add wave -noupdate /axis_mesh_tb/rst_n
add wave -noupdate -expand -subitemconfig {{/axis_mesh_tb/axis_in_tvalid[0]} -expand {/axis_mesh_tb/axis_in_tvalid[1]} -expand} /axis_mesh_tb/axis_in_tvalid
add wave -noupdate /axis_mesh_tb/axis_in_tready
add wave -noupdate -expand -subitemconfig {{/axis_mesh_tb/axis_in_tdata[0]} -expand {/axis_mesh_tb/axis_in_tdata[1]} -expand} /axis_mesh_tb/axis_in_tdata
add wave -noupdate -expand -subitemconfig {{/axis_mesh_tb/axis_in_tlast[0]} -expand {/axis_mesh_tb/axis_in_tlast[1]} -expand} /axis_mesh_tb/axis_in_tlast
add wave -noupdate /axis_mesh_tb/axis_in_tdest
add wave -noupdate -expand -subitemconfig {{/axis_mesh_tb/axis_out_tvalid[0]} -expand {/axis_mesh_tb/axis_out_tvalid[1]} -expand} /axis_mesh_tb/axis_out_tvalid
add wave -noupdate -expand -subitemconfig {{/axis_mesh_tb/axis_out_tready[0]} -expand {/axis_mesh_tb/axis_out_tready[1]} -expand} /axis_mesh_tb/axis_out_tready
add wave -noupdate -expand -subitemconfig {{/axis_mesh_tb/axis_out_tdata[0]} -expand {/axis_mesh_tb/axis_out_tdata[1]} -expand} /axis_mesh_tb/axis_out_tdata
add wave -noupdate -expand -subitemconfig {{/axis_mesh_tb/axis_out_tlast[0]} -expand {/axis_mesh_tb/axis_out_tlast[1]} -expand} /axis_mesh_tb/axis_out_tlast
add wave -noupdate /axis_mesh_tb/axis_out_tdest
add wave -noupdate -divider {Adder Module}
add wave -noupdate -divider {State Machine}
add wave -noupdate /axis_mesh_tb/adder_inst/state
add wave -noupdate /axis_mesh_tb/adder_inst/next_state
add wave -noupdate /axis_mesh_tb/adder_inst/buffer
add wave -noupdate /axis_mesh_tb/adder_inst/sum
add wave -noupdate -divider {AXI-Stream Interface}
add wave -noupdate /axis_mesh_tb/adder_inst/AXIS_M_TDATA
add wave -noupdate /axis_mesh_tb/adder_inst/AXIS_M_TDEST
add wave -noupdate /axis_mesh_tb/adder_inst/AXIS_M_TID
add wave -noupdate /axis_mesh_tb/adder_inst/AXIS_M_TLAST
add wave -noupdate /axis_mesh_tb/adder_inst/AXIS_M_TREADY
add wave -noupdate /axis_mesh_tb/adder_inst/AXIS_M_TVALID
add wave -noupdate /axis_mesh_tb/adder_inst/AXIS_S_TDATA
add wave -noupdate /axis_mesh_tb/adder_inst/AXIS_S_TDEST
add wave -noupdate /axis_mesh_tb/adder_inst/AXIS_S_TID
add wave -noupdate /axis_mesh_tb/adder_inst/AXIS_S_TLAST
add wave -noupdate /axis_mesh_tb/adder_inst/AXIS_S_TREADY
add wave -noupdate /axis_mesh_tb/adder_inst/AXIS_S_TVALID
add wave -noupdate /axis_mesh_tb/done
add wave -noupdate /axis_mesh_tb/start
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {695000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 337
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
configure wave -timelineunits ps
update
WaveRestoreZoom {383543 ps} {821919 ps}
