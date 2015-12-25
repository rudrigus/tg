onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /processadorimagemgmaw_tb/pixel_entrada
add wave -noupdate -radix unsigned /processadorimagemgmaw_tb/i1/dado_escrita
add wave -noupdate -radix unsigned /processadorimagemgmaw_tb/i1/bloco_topo_base/q
add wave -noupdate /processadorimagemgmaw_tb/i1/bloco_topo_base/somaLinha
add wave -noupdate /processadorimagemgmaw_tb/clk_count
add wave -noupdate /processadorimagemgmaw_tb/in_clock
add wave -noupdate /processadorimagemgmaw_tb/in_janela
add wave -noupdate /processadorimagemgmaw_tb/bloco_atual
add wave -noupdate /processadorimagemgmaw_tb/i1/bloco_receptor/bloco_atual
add wave -noupdate /processadorimagemgmaw_tb/linha
add wave -noupdate /processadorimagemgmaw_tb/coluna
add wave -noupdate /processadorimagemgmaw_tb/i1/bloco_topo_base/somaHor
add wave -noupdate /processadorimagemgmaw_tb/i1/bloco_topo_base/derivadaHor
add wave -noupdate /processadorimagemgmaw_tb/i1/bloco_topo_base/posArameTopo
add wave -noupdate /processadorimagemgmaw_tb/i1/bloco_topo_base/posArameBase
add wave -noupdate -radix unsigned /processadorimagemgmaw_tb/i1/endereco_escrita
add wave -noupdate -radix unsigned /processadorimagemgmaw_tb/i1/endereco_leitura
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {51719265 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 309
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
WaveRestoreZoom {51674718 ps} {51777258 ps}
