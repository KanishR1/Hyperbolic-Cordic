`include "hyperCord_pkg.svh"
import hyperCord_pkg::*;

module functionalUnit #(
    parameter INT_WIDTH = I_INT_WIDTH,
    parameter FRA_WIDTH = I_FRA_WIDTH,
    parameter SIGN_WIDTH = I_SIGN_WIDTH,
    parameter DWIDTH = IDWIDTH,
    parameter MODE = 0 // 0 - Add, 1 - Sub
) (
    // Input Signals
    input [DWIDTH-1 : 0] Xin,
    input [DWIDTH-1 : 0] Yin,
    input [DWIDTH-1 : 0] Zin

    // Output Signal
    output logic [DWIDTH-1 : 0] Xout,
    output logic [DWIDTH-1 : 0] Yout,
    output logic [DWIDTH-1 : 0] Zout
);

    // Finding the absolute value of theta
    logic zSign;
    logic [DWIDTH-1 : 0] absZ;
    
    assign zSign = Zin[DWIDTH-1];
    assign absZ = absval(Zin);

    logic [DWIDTH-1 : 0] Ysinh;
    logic [DWIDTH-1 : 0] Xsinh;

    logic [DWIDTH-1 : 0] Ycosh;
    logic [DWIDTH-1 : 0] Xcosh;

    s1cosh xcosinst



endmodule //Stage 1


