transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/db {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/db/pll_altpll.v}
vlog -vlog01compat -work work +incdir+/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/db {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/db/deserializer_lvds_rx.v}
vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/ImagensRAM.vhd}
vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/common.vhd}
vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/pll.vhd}
vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/deserializer.vhd}
vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/ReceptorDados.vhd}
vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/Multiplicador8B16B.vhd}
vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/FiltroGaussiana.vhd}
vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/MedidasArame.vhd}
vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/SeletorImagem.vhd}
vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/ProcessadorImagemGMAW.vhd}
vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/Bordas.vhd}

vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/ProcessadorImagemGMAW-TB.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneiv_hssi -L cycloneiv_pcie_hip -L cycloneiv -L rtl_work -L work -voptargs="+acc"  ProcessadorImagemGMAW_TB

do {wave.do}
view wave
view structure
view signals
run 100 us
