onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ALU_tb/aluif/Zero
add wave -noupdate /ALU_tb/aluif/Negative
add wave -noupdate /ALU_tb/aluif/Overflow
add wave -noupdate /ALU_tb/aluif/Port_A
add wave -noupdate /ALU_tb/aluif/Port_B
add wave -noupdate /ALU_tb/aluif/Output_Port
add wave -noupdate /ALU_tb/aluif/ALUOP
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {358 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ns} {1 us}
