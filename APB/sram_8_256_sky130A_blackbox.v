// Simplified blackbox model for OpenROAD
module sram_8_256_sky130A (
    vdd,
    gnd,
    clk0,
    csb0,
    web0,
    addr0,
    din0,
    dout0
);

  input vdd;
  input gnd;
  input clk0;
  input csb0;
  input web0;
  input [7:0] addr0;
  input [7:0] din0;
  output [7:0] dout0;

endmodule

