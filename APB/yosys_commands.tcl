#Read modules from verilog
read_verilog APB_Wrapper.v
read_verilog sram_8_256_sky130A_blackbox.v
read_verilog APB_Master.v
read_verilog APB_Slave_with_SRAM.v

# Đánh dấu SRAM là macro và giữ nguyên
blackbox sram_8_256_sky130A

#Elaborate design hierarchy
hierarchy -check -top APB_Wrapper

#Translate Processes to netlist
proc

#mapping to the internal cell library
techmap

#mapping flip-flops to lib
dfflibmap -liberty /home/tuan/Desktop/OpenROAD/test/sky130hd/sky130_fd_sc_hd__tt_025C_1v80.lib
opt


#mapping logic to lib
abc -liberty /home/tuan/Desktop/OpenROAD/test/sky130hd/sky130_fd_sc_hd__tt_025C_1v80.lib


#remove unused cells
clean

#write the synthesized design in a verilog file
stat -liberty /home/tuan/Desktop/OpenROAD/test/sky130hd/sky130_fd_sc_hd__tt_025C_1v80.lib

write_verilog -noattr APB_synth.v

