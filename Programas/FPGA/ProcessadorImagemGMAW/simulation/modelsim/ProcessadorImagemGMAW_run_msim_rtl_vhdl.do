transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/ImagensRAM.vhd}
vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/common.vhd}
vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/imagensteste.vhd}
vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/pll.vhd}
vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/deserializer.vhd}
vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/ReceptorDados.vhd}
vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/MedidasArame.vhd}
vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/SeletorImagem.vhd}
vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/ProcessadorImagemGMAW.vhd}
vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/RegressaoLinear.vhd}
vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/BordasPoca.vhd}

vcom -93 -work work {/home/rudrigus/UNB/TG/Programas/FPGA/ProcessadorImagemGMAW/ProcessadorImagemGMAW-TB.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneiv_hssi -L cycloneiv_pcie_hip -L cycloneiv -L rtl_work -L work -voptargs="+acc"  ProcessadorImagemGMAW_TB

do {wave.do}
view wave
view structure
view signals
run 200 us
