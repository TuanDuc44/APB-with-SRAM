module APB_Master (
    // External system signals
    input SWRITE,
    input [31:0] SADDR, SWDATA,
    input [3:0] SSTRB,
    input [2:0] SPROT,
    input transfer,

    // APB signals (outputs from master)
    output reg PSEL, PENABLE, PWRITE,
    output reg [31:0] PADDR, PWDATA,
    output reg [3:0] PSTRB,
    output reg [2:0] PPROT,

    input PCLK, PRESETn,
    input PREADY,
    input PSLVERR
);

    // FSM states
    localparam IDLE   = 2'b00,
               SETUP  = 2'b01,
               ACCESS = 2'b10;

    reg [1:0] cs, ns;

    // State transition
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn)
            cs <= IDLE;
        else
            cs <= ns;
    end

    // Next state logic
    always @(*) begin
        case (cs)
            IDLE:    ns = (transfer) ? SETUP : IDLE;
            SETUP:   ns = ACCESS;
            ACCESS:  ns = (PREADY) ? (transfer ? SETUP : IDLE) : ACCESS;
            default: ns = IDLE;
        endcase
    end

    // Output logic (registered)
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            PSEL    <= 1'b0;
            PENABLE <= 1'b0;
            PWRITE  <= 1'b0;
            PADDR   <= 32'b0;
            PWDATA  <= 32'b0;
            PSTRB   <= 4'b0;
            PPROT   <= 3'b0;
        end else begin
            case (ns)
                IDLE: begin
                    PSEL    <= 1'b0;
                    PENABLE <= 1'b0;
                end
                SETUP: begin
                    PSEL    <= 1'b1;
                    PENABLE <= 1'b0;
                    PWRITE  <= SWRITE;
                    PADDR   <= SADDR;
                    PWDATA  <= SWDATA;
                    PSTRB   <= SSTRB;
                    PPROT   <= SPROT;
                end
                ACCESS: begin
                    PSEL    <= 1'b1;
                    PENABLE <= 1'b1;
                end
            endcase
        end
    end

endmodule

