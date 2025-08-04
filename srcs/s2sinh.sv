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

module s2sinh #(
    parameter DWIDTH = IDWIDTH
)(
    // Inputs
    input [DWIDTH-1 : 0] iData,
    input scomp,

    // Output Signals
    output logic [DWIDTH-1 : 0] sinhOut
);

    // sinh(0.5) implementation
    logic [DWIDTH-1 : 0] yshift9;
    logic [DWIDTH-1 : 0] yshift4;

    /* verilator lint_off UNOPTFLAT */
    logic [DWIDTH-1 : 0] interVal [5];
    /* verilator lint_on UNOPTFLAT */

    assign yshift9 = iData >>> 9;
    assign yshift4 = iData >>> 4;

    fixedAddSub #(.MODE(0)) add1 (.iData1(iData), .iData2(yshift9), .oData(interVal[0]));
    
    assign interVal[1] = interVal[0] >>> 3;
    fixedAddSub #(.MODE(0)) add2 (.iData1(yshift4), .iData2(iData), .oData(interVal[2]));

    assign interVal[3] = interVal[2] >>> 7;
    fixedAddSub #(.MODE(0)) add3 (.iData1(interVal[0]), .iData2(interVal[3]), .oData(interVal[4]));

    
    assign interVal[4] = interVal[3] >>> 2;
    assign sinhOut = scomp ? interVal[4] : interVal[1];

endmodule // stage2 sinh

