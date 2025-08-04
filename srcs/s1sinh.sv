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

module s1sinh #(
    parameter INT_WIDTH = I_INT_WIDTH,
    parameter FRA_WIDTH = I_FRA_WIDTH,
    parameter SIGN_WIDTH = I_SIGN_WIDTH,
    parameter DWIDTH = IDWIDTH
)(
    // Inputs
    input [DWIDTH-1 : 0] iData,

    // Output Signals
    output logic [DWIDTH-1 : 0] sinhOut,
);

    // sinh(0.5) implementation
    logic [DWIDTH-1 : 0] yshift2;
    logic [DWIDTH-1 : 0] yshift6;

    logic [DWIDTH-1 : 0] interVal [7];

    assign yshift2 = iData >>> 2;
    assign yshift6 = iData >>> 6;

    fixedAddSub #(.MODE(0)) ( .iData1(iData), .iData2(yshift2), .oData(interVal[0]));
    
    assign interVal[1] = interVal[0] >>> 4;
    fixedAddSub #(.MODE(0)) ( .iData1(interVal[1]), .iData2(yshift6), .oData(interVal[2]));

    fixedAddSub #(.MODE(0)) ( .iData1(interVal[0]), .iData2(interVal[2]), .oData(interVal[3]));
    
    assign interVal[4] = interVal[3] >>> 5;
    fixedAddSub #(.MODE(0)) ( .iData1(interVal[4]), .iData2(iData), .oData(interVal[5]));

    assign interVal[6] = interVal[5] >>> 1;
    assign sinhOut = interVal[6];

endmodule // stage1 sinh

