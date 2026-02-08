onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/dut/clk_i
add wave -noupdate /top/dut/wr_rd_i
add wave -noupdate /top/dut/rst_i
add wave -noupdate /top/dut/valid_i
add wave -noupdate /top/dut/addr_i
add wave -noupdate /top/dut/wdata_i
add wave -noupdate /top/dut/rdata_o
add wave -noupdate /top/dut/ready_o
add wave -noupdate /top/dut/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 40
configure wave -valuecolwidth 40
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
WaveRestoreZoom {102 ns} {104 ns}
