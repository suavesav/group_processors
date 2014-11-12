onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate -divider {From DP}
add wave -noupdate /dcache_tb/dcif/dmemREN
add wave -noupdate /dcache_tb/dcif/dmemWEN
add wave -noupdate /dcache_tb/dcif/dmemstore
add wave -noupdate /dcache_tb/dcif/dmemaddr
add wave -noupdate -divider {TO DP}
add wave -noupdate /dcache_tb/dcif/dhit
add wave -noupdate /dcache_tb/dcif/dmemload
add wave -noupdate -divider {FROM CC}
add wave -noupdate {/dcache_tb/ccif/dload[0]}
add wave -noupdate {/dcache_tb/ccif/dwait[0]}
add wave -noupdate {/dcache_tb/ccif/ccwait[0]}
add wave -noupdate {/dcache_tb/ccif/ccinv[0]}
add wave -noupdate {/dcache_tb/ccif/ccsnoopaddr[0]}
add wave -noupdate -divider {TO CC}
add wave -noupdate {/dcache_tb/ccif/ccwrite[0]}
add wave -noupdate {/dcache_tb/ccif/cctrans[0]}
add wave -noupdate /dcache_tb/DUT/state
add wave -noupdate /dcache_tb/DUT/nextstate
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {62 ns} 0}
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
WaveRestoreZoom {0 ns} {499 ns}
