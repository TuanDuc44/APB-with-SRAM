# ------------------------------------
# Create clock
# ------------------------------------
create_clock -name PCLK -period 20.000 [get_ports PCLK]

# ------------------------------------
# Set input delays (so với clock)
# ------------------------------------
set_input_delay 2.0 -clock PCLK [get_ports {SWRITE SADDR[*] SWDATA[*] SSTRB[*] SPROT[*] transfer}]

# ------------------------------------
# Set output delays
# ------------------------------------
set_output_delay 2.0 -clock PCLK [get_ports PRDATA[*]]

# ------------------------------------
# Reset is asynchronous — exclude it from timing
# ------------------------------------
set_false_path -from [get_ports PRESETn]
