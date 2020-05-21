#IO_L11P_T1_SRCC_35
set_property PACKAGE_PIN K17 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 8.000 -name sys_clk_pin -waveform {0.000 4.000} -add [get_ports clk]

#IO_L20N_T3_34
set_property PACKAGE_PIN K18 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

#IO_L23P_T3_35
set_property PACKAGE_PIN M14 [get_ports led_out_i[0]]
set_property IOSTANDARD LVCMOS33 [get_ports led_out_i[0]]

set_property IOSTANDARD LVCMOS33 [get_ports {led_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[0]}]
set_property PACKAGE_PIN M14 [get_ports led_out]

set_property PACKAGE_PIN M14 [get_ports {led_out[0]}]
set_property PACKAGE_PIN M15 [get_ports {led_out[1]}]
set_property PACKAGE_PIN G14 [get_ports {led_out[2]}]
set_property PACKAGE_PIN D18 [get_ports {led_out[3]}]
