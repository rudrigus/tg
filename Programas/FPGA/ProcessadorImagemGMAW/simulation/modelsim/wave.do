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
add wave -noupdate /processadorimagemgmaw_tb/i1/medidas_arame/linha
add wave -noupdate /processadorimagemgmaw_tb/i1/medidas_arame/coluna
add wave -noupdate /processadorimagemgmaw_tb/i1/medidas_arame/somaHor
add wave -noupdate /processadorimagemgmaw_tb/i1/medidas_arame/derivadaHor
add wave -noupdate /processadorimagemgmaw_tb/i1/medidas_arame/max_derivada
add wave -noupdate -radix decimal /processadorimagemgmaw_tb/i1/regressao_linear1/mult1
add wave -noupdate -radix decimal /processadorimagemgmaw_tb/i1/regressao_linear1/mult2
add wave -noupdate -radix decimal /processadorimagemgmaw_tb/i1/regressao_linear1/mult3
add wave -noupdate -radix decimal /processadorimagemgmaw_tb/i1/regressao_linear1/mult4
add wave -noupdate /processadorimagemgmaw_tb/i1/regressao_linear1/intervalo
add wave -noupdate -radix decimal /processadorimagemgmaw_tb/i1/regressao_linear1/somatorio_di
add wave -noupdate -radix decimal /processadorimagemgmaw_tb/i1/regressao_linear1/somatorio_idi
add wave -noupdate -childformat {{/processadorimagemgmaw_tb/i1/regressao_linear1/R(0) -radix decimal} {/processadorimagemgmaw_tb/i1/regressao_linear1/R(1) -radix decimal}} -subitemconfig {/processadorimagemgmaw_tb/i1/regressao_linear1/R(0) {-height 17 -radix decimal} /processadorimagemgmaw_tb/i1/regressao_linear1/R(1) {-height 17 -radix decimal}} /processadorimagemgmaw_tb/i1/regressao_linear1/R
add wave -noupdate -radix decimal /processadorimagemgmaw_tb/i1/regressao_linear1/i
add wave -noupdate /processadorimagemgmaw_tb/i1/regressao_linear1/j
add wave -noupdate /processadorimagemgmaw_tb/i1/inicioArame
add wave -noupdate /processadorimagemgmaw_tb/i1/regressao_linear1/teste1
add wave -noupdate /processadorimagemgmaw_tb/i1/regressao_linear1/teste2
add wave -noupdate /processadorimagemgmaw_tb/i1/regressao_linear1/teste3
add wave -noupdate /processadorimagemgmaw_tb/i1/regressao_linear1/teste4
add wave -noupdate /processadorimagemgmaw_tb/i1/regressao_linear1/teste5
add wave -noupdate /processadorimagemgmaw_tb/i1/regressao_linear1/teste6
add wave -noupdate /processadorimagemgmaw_tb/i1/regressao_linear1/teste7
add wave -noupdate /processadorimagemgmaw_tb/i1/regressao_linear1/teste8
add wave -noupdate /processadorimagemgmaw_tb/i1/regressao_linear1/teste9
add wave -noupdate /processadorimagemgmaw_tb/i1/regressao_linear1/teste10
add wave -noupdate /processadorimagemgmaw_tb/i1/regressao_linear1/teste11
add wave -noupdate /processadorimagemgmaw_tb/i1/regressao_linear1/teste12
add wave -noupdate /processadorimagemgmaw_tb/i1/regressao_linear1/teste13
add wave -noupdate /processadorimagemgmaw_tb/i1/regressao_linear1/teste14
add wave -noupdate /processadorimagemgmaw_tb/i1/regressao_linear1/teste15
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1239919 ps} 0}
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
WaveRestoreZoom {0 ps} {26250 ns}
