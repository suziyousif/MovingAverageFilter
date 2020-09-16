# ============================================================================
# Name        : testbench.do
# Author      : Renan Augusto Starke
# Version     : 0.1
# Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
# Description : Exemplo de script de compilação ModelSim
# ============================================================================

#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom rom_ram.vhd MovingAverage.vhd testbench.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns work.testbench

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda

add wave -label clk /clk
add wave -label rst /rst
add wave -label we /MovingAverage_inst/we
add wave -label data_in -radix dec /data_in
add wave -label average -radix dec /average
add wave -label r_add -radix unsigned /MovingAverage_inst/read_address
add wave -label w_add -radix unsigned /MovingAverage_inst/write_address
add wave -label average_sum -radix unsigned /MovingAverage_inst/average_sum
add wave -label ram -radix dec /MovingAverage_inst/rom_gen/ram
add wave -label q -radix dec /MovingAverage_inst/rom_gen/q
add wave -label buff_value -radix dec /MovingAverage_inst/buff_value

#Simula até um 500ns
run 800ns

wave zoomfull
write wave wave.ps
