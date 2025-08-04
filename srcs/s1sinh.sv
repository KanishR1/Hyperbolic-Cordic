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

module s1sinh #(
    parameter DWIDTH = IDWIDTH
)(
    // Inputs
    input [DWIDTH-1 : 0] iData,

    // Output Signals
    output logic [DWIDTH-1 : 0] sinhOut
);

    // sinh(0.5) implementation
    logic [DWIDTH-1 : 0] yshift2;
    logic [DWIDTH-1 : 0] yshift6;

    /* verilator lint_off UNOPTFLAT */
    logic [DWIDTH-1 : 0] interVal [7];
    /* verilator lint_on UNOPTFLAT */

    assign yshift2 = iData >>> 2;
    assign yshift6 = iData >>> 6;

    fixedAddSub #(.MODE(0)) add1 (.iData1(iData), .iData2(yshift2), .oData(interVal[0]));
    
    assign interVal[1] = interVal[0] >>> 4;
    fixedAddSub #(.MODE(0)) add2 (.iData1(interVal[1]), .iData2(yshift6), .oData(interVal[2]));

    fixedAddSub #(.MODE(0)) add3 (.iData1(interVal[0]), .iData2(interVal[2]), .oData(interVal[3]));
    
    assign interVal[4] = interVal[3] >>> 5;
    fixedAddSub #(.MODE(0)) add4 (.iData1(interVal[4]), .iData2(iData), .oData(interVal[5]));

    assign interVal[6] = interVal[5] >>> 1;
    assign sinhOut = interVal[6];

endmodule // stage1 sinh

