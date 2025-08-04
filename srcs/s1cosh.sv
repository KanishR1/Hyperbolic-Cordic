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

module s1cosh #(
    parameter DWIDTH = IDWIDTH
)(
    // Inputs
    input [DWIDTH-1 : 0] iData,

    // Output Signals
    output logic [DWIDTH-1 : 0] coshOut
);

    // cosh(0.5) computation
    logic [DWIDTH-1 : 0] xshift3;
    logic [DWIDTH-1 : 0] xshift2;

    /* verilator lint_off UNOPTFLAT */
    logic [DWIDTH-1 : 0] interVal [6];
    /* verilator lint_on UNOPTFLAT */

    assign xshift2 = iData >>> 2;
    assign xshift3 = iData >>> 3;

    fixedAddSub #(.MODE(0)) add1(.iData1(iData), .iData2(xshift3), .oData(interVal[0]));
    fixedAddSub #(.MODE(0)) add2 (.iData1(iData), .iData2(xshift2), .oData(interVal[1]));

    assign interVal[2] = interVal[1] >>> 2;
    fixedAddSub #(.MODE(0)) add3 ( .iData1(iData), .iData2(interVal[2]), .oData(interVal[3]));
    
    assign interVal[4] = interVal[3] >>> 9;
    fixedAddSub #(.MODE(0)) add4 (.iData1(interVal[0]), .iData2(interVal[4]), .oData(interVal[5]));

    assign coshOut = interVal[5];
    
endmodule // stage1 cosh

