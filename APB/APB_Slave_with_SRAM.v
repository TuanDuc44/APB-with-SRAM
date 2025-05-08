module APB_Slave_with_SRAM #(
    parameter MEM_WIDTH = 32 , parameter MEM_DEPTH = 1024
) (
    input PSEL , PENABLE , PWRITE ,  
    input [31:0] PADDR , PWDATA ,
    input [3:0] PSTRB ,
    input [2:0] PPROT ,
    input PCLK , PRESETn ,
    output reg [31:0] PRDATA ,
    output PREADY ,
    output reg PSLVERR
);

// SRAM instance
wire [7:0] sram_dout;

sram_8_256_sky130A u_sram (
    .vdd   (1'b1),
    .gnd   (1'b0),
    .clk0  (PCLK),
    .csb0  (~PSEL),                 // active low chip select
    .web0  (~(PSEL && PWRITE)),    // active low write enable
    .addr0 (PADDR[7:0]),
    .din0  (PWDATA[7:0]),
    .dout0 (sram_dout)
);

always @ (posedge PCLK) begin
    if (~PRESETn) begin
        PSLVERR <= 0;
        PRDATA <= 0;
    end else if (PSEL && ~PWRITE) begin
        PRDATA <= {24'h0, sram_dout}; // zero-extend 8-bit to 32-bit
        PSLVERR <= 0;
    end
end

assign PREADY = (PSEL && PENABLE) ? 1 : 0;

endmodule