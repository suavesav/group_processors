onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -divider System
add wave -noupdate /system_tb/syif/halt
add wave -noupdate /system_tb/syif/load
add wave -noupdate -divider DataPath
add wave -noupdate -divider {Reg File}
add wave -noupdate -divider ALU
add wave -noupdate -divider {Request Unit}
add wave -noupdate -divider {Control Unit}
add wave -noupdate /system_tb/DUT/CPU/CM/instr
add wave -noupdate /system_tb/DUT/RAM/ramaddr
add wave -noupdate /system_tb/DUT/RAM/ramstore
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7686 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 73
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
WaveRestoreZoom {0 ps} {394326 ps}
