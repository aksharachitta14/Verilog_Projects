onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/dut/wr_clk_i
add wave -noupdate /top/dut/rd_clk_i
add wave -noupdate /top/dut/rst_i
add wave -noupdate /top/dut/wr_en_i
add wave -noupdate /top/dut/rd_en_i
add wave -noupdate /top/dut/wdata_i
add wave -noupdate /top/dut/rdata_o
add wave -noupdate /top/dut/full_o
add wave -noupdate /top/dut/overflow_o
add wave -noupdate /top/dut/empty_o
add wave -noupdate /top/dut/underflow_o
add wave -noupdate /top/dut/wr_ptr
add wave -noupdate /top/dut/rd_ptr
add wave -noupdate /top/dut/wr_ptr_rd_clk
add wave -noupdate /top/dut/rd_ptr_wr_clk
add wave -noupdate /top/dut/wr_toggle_f_rd_clk
add wave -noupdate /top/dut/rd_toggle_f_wr_clk
add wave -noupdate /top/dut/wr_toggle_f
add wave -noupdate /top/dut/rd_toggle_f
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
WaveRestoreZoom {0 ns} {104 ns}
