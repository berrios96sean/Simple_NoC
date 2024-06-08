onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /axis_mesh_tb/clk
add wave -noupdate /axis_mesh_tb/rst_n
add wave -noupdate /axis_mesh_tb/axis_in_tvalid
add wave -noupdate /axis_mesh_tb/axis_in_tready
add wave -noupdate /axis_mesh_tb/axis_in_tdata
add wave -noupdate /axis_mesh_tb/axis_in_tlast
add wave -noupdate /axis_mesh_tb/axis_in_tdest
add wave -noupdate /axis_mesh_tb/axis_out_tvalid
add wave -noupdate /axis_mesh_tb/axis_out_tready
add wave -noupdate /axis_mesh_tb/axis_out_tdata
add wave -noupdate /axis_mesh_tb/axis_out_tlast
add wave -noupdate /axis_mesh_tb/axis_out_tdest
add wave -noupdate /axis_mesh_tb/dut/noc/send_router_in
add wave -noupdate /axis_mesh_tb/dut/noc/send_router_out
add wave -noupdate /axis_mesh_tb/num_gen_inst/lsfr_inst_data/O_DATA
add wave -noupdate /axis_mesh_tb/num_gen_inst/lsfr_inst_dest/O_DATA
add wave -noupdate /axis_mesh_tb/num_gen_inst/AXIS_S_TREADY
add wave -noupdate /axis_mesh_tb/num_gen_inst/AXIS_M_TVALID
add wave -noupdate /axis_mesh_tb/num_gen_inst/AXIS_M_TLAST
add wave -noupdate /axis_mesh_tb/num_gen_inst/AXIS_M_TID
add wave -noupdate /axis_mesh_tb/num_gen_inst/AXIS_M_TDEST
add wave -noupdate /axis_mesh_tb/num_gen_inst/AXIS_M_TDATA
add wave -noupdate /axis_mesh_tb/num_gen_inst/START
add wave -noupdate /axis_mesh_tb/num_gen_inst/AXIS_S_TVALID
add wave -noupdate /axis_mesh_tb/num_gen_inst/AXIS_S_TLAST
add wave -noupdate /axis_mesh_tb/num_gen_inst/AXIS_S_TID
add wave -noupdate /axis_mesh_tb/num_gen_inst/AXIS_S_TDEST
add wave -noupdate /axis_mesh_tb/num_gen_inst/AXIS_S_TDATA
add wave -noupdate /axis_mesh_tb/num_gen_inst/AXIS_M_TREADY
add wave -noupdate /axis_mesh_tb/num_gen_inst/o_dest
add wave -noupdate /axis_mesh_tb/num_gen_inst/g_dest
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {454672 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 281
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
WaveRestoreZoom {0 ps} {736773 ps}
