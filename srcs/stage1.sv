`include "hyperCord_pkg.svh"
/* verilator lint_off IMPORTSTAR */
import hyperCord_pkg::*;
/* verilator lint_on IMPORTSTAR */


module stage1 #(
    parameter FRA_WIDTH = I_FRA_WIDTH,
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

    assign zSign = Zin[DWIDTH-1];
    assign absZin = absval(Zin);
    assign comp = (absZin <= DWIDTH'(1 << (FRA_WIDTH - 2)));

    functionalUnitS1 xinst( .iData1(Xin), .iData2(Yin), .iSign(zSign), .compin(comp), .oData(Xout));
    functionalUnitS1 yinst( .iData1(Yin), .iData2(Xin), .iSign(zSign), .compin(comp), .oData(Yout));
    s1theta zinst (.iData(Zin), .iSign(zSign), .compin(comp), .zOut(Zout));

endmodule // Stage 1


