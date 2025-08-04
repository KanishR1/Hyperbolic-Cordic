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

module s2cosh #(
    parameter DWIDTH = IDWIDTH
)(
    // Inputs
    input [DWIDTH-1 : 0] iData,
    input scomp,

    // Output Signals
    output logic [DWIDTH-1 : 0] coshOut
);

    // cosh(0.5) computation
    logic [DWIDTH-1 : 0] xshift8;
    logic [DWIDTH-1 : 0] xshift7;

    /* verilator lint_off UNOPTFLAT */
    logic [DWIDTH-1 : 0] interVal [4];
    /* verilator lint_on UNOPTFLAT */

    assign xshift8 = iData >>> 8;
    assign xshift7 = iData >>> 7;

    fixedAddSub #(.MODE(0)) add1(.iData1(iData), .iData2(xshift8), .oData(interVal[0]));

    assign interVal[1] = interVal[0] >>> 5;

    
    assign interVal[2] = scomp ?  interVal[1] : xshift7;
    fixedAddSub #(.MODE(0)) add2 (.iData1(interVal[2]), .iData2(iData), .oData(interVal[3]));

    assign coshOut = interVal[3];
    
endmodule // stage2 cosh

