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

module s3cosh #(
    parameter DWIDTH = IDWIDTH
)(
    // Inputs
    input [DWIDTH-1 : 0] iData,
    input scomp,

    // Output Signals
    output logic [DWIDTH-1 : 0] coshOut
);

    // cosh(0.5) computation
    logic [DWIDTH-1 : 0] xshift9;
    logic [DWIDTH-1 : 0] xshift11;

    /* verilator lint_off UNOPTFLAT */
    logic [DWIDTH-1 : 0] interVal[2];
    /* verilator lint_on UNOPTFLAT */

    assign xshift9 = iData >>> 9;
    assign xshift11 = iData >>> 11;
    assign interVal[0] = scomp ?  xshift9 : xshift11;

    fixedAddSub #(.MODE(0)) add1(.iData1(iData), .iData2(interVal[0]), .oData(interVal[1]));    

    assign coshOut = interVal[1];
    
endmodule // stage3 cosh

