`include "hyperCord_pkg.svh"
/* verilator lint_off IMPORTSTAR */
import hyperCord_pkg::*;
/* verilator lint_on IMPORTSTAR */


module stage2 #(
    parameter FRA_WIDTH = I_FRA_WIDTH,
    parameter INT_WIDTH = I_INT_WIDTH,
    parameter DWIDTH = IDWIDTH
) (
    // Input Signals
    input [DWIDTH-1 : 0] Xin,
    input [DWIDTH-1 : 0] Yin,
    input [DWIDTH-1 : 0] Zin,

    // Output Signal
    output logic [DWIDTH-1 : 0] Xout,
    output logic [DWIDTH-1 : 0] Yout,
    output logic [DWIDTH-1 : 0] Zout
);

    logic zSign;
    logic [DWIDTH-1 : 0] absZin;
    logic comp;
    logic scomp;

    assign zSign = Zin[DWIDTH-1];
    assign absZin = absval(Zin);

    assign scomp  = (absZin > DWIDTH'({1'b0, {INT_WIDTH{1'b0}}, 4'b0011, {(FRA_WIDTH > 4 ? FRA_WIDTH-4 : 0){1'b0}}}));
    assign comp = (absZin <= DWIDTH'(1 << (FRA_WIDTH - 4)));

    functionalUnitS2  xinst( .iData1(Xin), .iData2(Yin), .iSign(zSign), .compin(comp), .scomp(scomp), .oData(Xout));
    functionalUnitS2  yinst( .iData1(Yin), .iData2(Xin), .iSign(zSign), .compin(comp), .scomp(scomp), .oData(Yout));
    
    
    s2theta zinst (.iData(Zin), .iSign(zSign), .compin(comp), .scomp(scomp), .zOut(Zout));

endmodule // Stage 2
