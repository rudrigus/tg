onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned -radixshowbase 0 /processadorimagemgmaw_tb/brilho_maximo
add wave -noupdate /processadorimagemgmaw_tb/in_clock
add wave -noupdate /processadorimagemgmaw_tb/in_janela
add wave -noupdate -radix unsigned -radixshowbase 0 /processadorimagemgmaw_tb/pixel_entrada
add wave -noupdate /processadorimagemgmaw_tb/I
add wave -noupdate /processadorimagemgmaw_tb/linha
add wave -noupdate /processadorimagemgmaw_tb/coluna
add wave -noupdate /processadorimagemgmaw_tb/end_of_simulation
add wave -noupdate /processadorimagemgmaw_tb/reset
add wave -noupdate /processadorimagemgmaw_tb/start_stop
add wave -noupdate /processadorimagemgmaw_tb/contador12b
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {280014 ps} 0}
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
WaveRestoreZoom {0 ps} {4270457 ps}
