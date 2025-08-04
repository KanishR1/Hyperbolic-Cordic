//////////////////////////////////////////////////////////////////////////////////
// Lab            : Intelligent Hardware Systems Engineering (IHS) Lab
// College        : International Institute of Information Technology, Bangalore
//
// RTL Designer   : Kanish R
// Verified By    :
// 
// Design Name    : hyper_cordic
// Module Name    : stage1
// Project Name   : Hyperbolic Cordic
// Target Devices : All FPGA devices
//
// Description: 
//
// This code is currently written for 16-bit accuracy.
// 
//////////////////////////////////////////////////////////////////////////////////

`include "hyperCord_pkg.svh"
import hyperCord_pkg::*;

module s1cosh #(
    parameter INT_WIDTH = I_INT_WIDTH,
    parameter FRA_WIDTH = I_FRA_WIDTH,
    parameter SIGN_WIDTH = I_SIGN_WIDTH,
    parameter DWIDTH = IDWIDTH
)(
    // Inputs
    input [DWIDTH-1 : 0] iData,

    // Output Signals
    output logic [DWIDTH-1 : 0] coshOut,
);

    // cosh(0.5) computation
    logic [DWIDTH-1 : 0] xshift3;
    logic [DWIDTH-1 : 0] xshift2;

    logic [DWIDTH-1 : 0] interVal [6];

    assign xshift2 = iData >>> 2;
    assign xshift3 = iData >>> 3;

    fixedAddSub #(.MODE(0)) ( .iData1(iData), .iData2(xshift3), .oData(interVal[0]));
    fixedAddSub #(.MODE(0)) ( .iData1(iData), .iData2(xshift2), .oData(interVal[1]));

    assign interVal[2] = interVal[1] >>> 2;
    fixedAddSub #(.MODE(0)) ( .iData1(iData), .iData2(interVal[2]), .oData(interVal[3]));
    
    assign interVal[4] = interVal[3] >>> 9;
    fixedAddSub #(.MODE(0)) ( .iData1(interVal[0]), .iData2(interVal[4]), .oData(interVal[5]));

    assign coshOut = interVal[5];
    
endmodule // stage1 cosh

