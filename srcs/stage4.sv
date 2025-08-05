`include "hyperCord_pkg.svh"
/* verilator lint_off IMPORTSTAR */
import hyperCord_pkg::*;
/* verilator lint_on IMPORTSTAR */


module stage4 #(
    parameter DWIDTH = IDWIDTH
) (
    // Input Signals
    input [DWIDTH-1 : 0] Xin,
    input [DWIDTH-1 : 0] Yin,
    input [DWIDTH-1 : 0] Zin,

    // Output Signal
    output logic [DWIDTH-1 : 0] Xout,
    output logic [DWIDTH-1 : 0] Yout
);

    logic zSign;
    logic [DWIDTH-1 : 0] absZin;

    assign zSign = Zin[DWIDTH-1];
    assign absZin = absval(Zin);

    logic [3:0]k;
    assign k = absZin[DWIDTH-2 -: 4] + {3'b0, absZin[DWIDTH-5]};

    functionalUnitS4  xinst( .iData1(Xin), .iData2(Yin), .k(k), .iSign(zSign), .oData(Xout));
    functionalUnitS4  yinst( .iData1(Yin), .iData2(Xin), .k(k), .iSign(zSign), .oData(Yout));
    
endmodule // Stage 4

