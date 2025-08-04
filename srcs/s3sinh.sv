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

module s3sinh #(
    parameter DWIDTH = IDWIDTH
)(
    // Inputs
    input [DWIDTH-1 : 0] iData,
    input scomp,

    // Output Signals
    output logic [DWIDTH-1 : 0] sinhOut
);

    // sinh(0.5) implementation
    logic [DWIDTH-1 : 0] yshift7;
    logic [DWIDTH-1 : 0] yshift4;


    assign yshift7 = iData >>> 7;
    assign yshift4 = iData >>> 4;

    assign sinhOut = scomp ? yshift4 : yshift7;

endmodule // stage3 sinh

