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
add wave -noupdate -divider -height 25 {Valid - Debugging}
add wave -noupdate -divider Deserializer
add wave -noupdate {/axis_mesh_tb/axis_mesh_inst/shim_gen/for_rows[0]/for_cols[1]/shim_out/deserializer_gen/genblk1/deserializer_inst/axis_in_tdata}
add wave -noupdate {/axis_mesh_tb/axis_mesh_inst/shim_gen/for_rows[0]/for_cols[1]/shim_out/deserializer_gen/genblk1/deserializer_inst/axis_in_tdest}
add wave -noupdate {/axis_mesh_tb/axis_mesh_inst/shim_gen/for_rows[0]/for_cols[1]/shim_out/deserializer_gen/genblk1/deserializer_inst/axis_in_tlast}
add wave -noupdate {/axis_mesh_tb/axis_mesh_inst/shim_gen/for_rows[0]/for_cols[1]/shim_out/deserializer_gen/genblk1/deserializer_inst/axis_in_tready}
add wave -noupdate {/axis_mesh_tb/axis_mesh_inst/shim_gen/for_rows[0]/for_cols[1]/shim_out/deserializer_gen/genblk1/deserializer_inst/axis_in_tvalid}
add wave -noupdate {/axis_mesh_tb/axis_mesh_inst/shim_gen/for_rows[0]/for_cols[1]/shim_out/deserializer_gen/genblk1/deserializer_inst/axis_out_tdata}
add wave -noupdate {/axis_mesh_tb/axis_mesh_inst/shim_gen/for_rows[0]/for_cols[1]/shim_out/deserializer_gen/genblk1/deserializer_inst/axis_out_tdest}
add wave -noupdate {/axis_mesh_tb/axis_mesh_inst/shim_gen/for_rows[0]/for_cols[1]/shim_out/deserializer_gen/genblk1/deserializer_inst/axis_out_tlast}
add wave -noupdate {/axis_mesh_tb/axis_mesh_inst/shim_gen/for_rows[0]/for_cols[1]/shim_out/deserializer_gen/genblk1/deserializer_inst/axis_out_tready}
add wave -noupdate {/axis_mesh_tb/axis_mesh_inst/shim_gen/for_rows[0]/for_cols[1]/shim_out/deserializer_gen/genblk1/deserializer_inst/axis_out_tvalid}
add wave -noupdate -divider Shim
add wave -noupdate {/axis_mesh_tb/axis_mesh_inst/shim_gen/for_rows[0]/for_cols[1]/shim_out/clkcross_gen/genblk1/shim_inst/axis_tdata}
add wave -noupdate {/axis_mesh_tb/axis_mesh_inst/shim_gen/for_rows[0]/for_cols[1]/shim_out/clkcross_gen/genblk1/shim_inst/axis_tdest}
add wave -noupdate {/axis_mesh_tb/axis_mesh_inst/shim_gen/for_rows[0]/for_cols[1]/shim_out/clkcross_gen/genblk1/shim_inst/axis_tlast}
add wave -noupdate {/axis_mesh_tb/axis_mesh_inst/shim_gen/for_rows[0]/for_cols[1]/shim_out/clkcross_gen/genblk1/shim_inst/axis_tready}
add wave -noupdate {/axis_mesh_tb/axis_mesh_inst/shim_gen/for_rows[0]/for_cols[1]/shim_out/clkcross_gen/genblk1/shim_inst/axis_tvalid}
add wave -noupdate {/axis_mesh_tb/axis_mesh_inst/shim_gen/for_rows[0]/for_cols[1]/shim_out/clkcross_gen/genblk1/shim_inst/buffer_empty}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {855291 ps} 0}
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
WaveRestoreZoom {135066 ps} {871839 ps}
