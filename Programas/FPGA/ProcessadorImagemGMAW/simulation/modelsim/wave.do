onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /processadorimagemgmaw_tb/pixel_entrada
add wave -noupdate -radix unsigned /processadorimagemgmaw_tb/i1/endereco_escrita
add wave -noupdate -radix unsigned /processadorimagemgmaw_tb/i1/endereco_leitura
add wave -noupdate /processadorimagemgmaw_tb/clk_count
add wave -noupdate /processadorimagemgmaw_tb/in_clock
add wave -noupdate /processadorimagemgmaw_tb/linha
add wave -noupdate /processadorimagemgmaw_tb/coluna
add wave -noupdate -radix unsigned /processadorimagemgmaw_tb/i1/limEsqPoca
add wave -noupdate -radix unsigned /processadorimagemgmaw_tb/i1/limDirPoca
add wave -noupdate /processadorimagemgmaw_tb/FVAL_teste
add wave -noupdate /processadorimagemgmaw_tb/LVAL_teste
add wave -noupdate /processadorimagemgmaw_tb/after_line
add wave -noupdate /processadorimagemgmaw_tb/inicio_imagem
add wave -noupdate /processadorimagemgmaw_tb/i1/posArameTopo
add wave -noupdate /processadorimagemgmaw_tb/i1/posArameBase
add wave -noupdate /processadorimagemgmaw_tb/i1/medidas_arame/somaHor
add wave -noupdate /processadorimagemgmaw_tb/i1/medidas_arame/derivadaHor
add wave -noupdate /processadorimagemgmaw_tb/i1/medidas_arame/max_derivada
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {27338826 ps} 0}
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
WaveRestoreZoom {0 ps} {105000448 ps}
