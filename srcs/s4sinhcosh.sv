module s4sinhcosh #(
    parameter DWIDTH = IDWIDTH
) (
    input [DWIDTH-1 : 0] iData,
    input [3:0] k,
    output logic [DWIDTH-1 : 0] oData
);

    logic [DWIDTH-1 : 0] shift9;
    assign shift9 = iData >>> 9;

    /* verilator lint_off UNUSEDSIGNAL */
    logic [DWIDTH+4-1 : 0] interMUL;
    /* verilator lint_on UNUSEDSIGNAL */

    assign interMUL = $signed (shift9) * $signed(k);

    assign oData = interMUL[DWIDTH+4-1 -: DWIDTH];
    
endmodule
