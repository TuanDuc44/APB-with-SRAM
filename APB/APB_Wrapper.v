module APB_Wrapper (
    input PCLK, PRESETn,
    input SWRITE,
    input [31:0] SADDR, SWDATA,
    input [3:0] SSTRB,
    input [2:0] SPROT,
    input transfer,
    output [31:0] PRDATA
);

wire PSEL, PENABLE, PWRITE;
wire [31:0] PADDR, PWDATA;
wire [3:0] PSTRB;
wire [2:0] PPROT;
wire PREADY, PSLVERR;
wire [31:0] prdata_internal;

assign PRDATA = prdata_internal;

// APB Master Instance
APB_Master Master (
    .PCLK(PCLK),
    .PRESETn(PRESETn),
    .SWRITE(SWRITE),
    .SADDR(SADDR),
    .SWDATA(SWDATA),
    .SSTRB(SSTRB),
    .SPROT(SPROT),
    .transfer(transfer),
    .PSEL(PSEL),
    .PENABLE(PENABLE),
    .PWRITE(PWRITE),
    .PADDR(PADDR),
    .PWDATA(PWDATA),
    .PSTRB(PSTRB),
    .PPROT(PPROT),
    .PREADY(PREADY),
    .PSLVERR(PSLVERR)
);

// APB Slave Instance
APB_Slave_with_SRAM Slave (
    .PCLK(PCLK),
    .PRESETn(PRESETn),
    .PSEL(PSEL),
    .PENABLE(PENABLE),
    .PWRITE(PWRITE),
    .PADDR(PADDR),
    .PWDATA(PWDATA),
    .PSTRB(PSTRB),
    .PPROT(PPROT),
    .PREADY(PREADY),
    .PSLVERR(PSLVERR),
    .PRDATA(prdata_internal)
);

endmodule
