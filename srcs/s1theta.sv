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

module s1theta #(
    parameter INT_WIDTH = I_INT_WIDTH,
    parameter FRA_WIDTH = I_FRA_WIDTH,
    parameter SIGN_WIDTH = I_SIGN_WIDTH,
    parameter DWIDTH = IDWIDTH
)(
    // Inputs
    input [DWIDTH-1 : 0] iData,
    input [DWIDTH-1 : 0] absiData,
    input iSign,
    input compin,

    // Output Signals
    output logic [DWIDTH-1 : 0] zOut,
);

    logic [DWIDTH-1 : 0] mux1Out;
    logic [DWIDTH-1 : 0] microRot [2];
    logic [DWIDTH-1 : 0] iData2;

    assign iData2 = {1'b0,{INT_WIDTH{1'b0}},{1'b1,{FRA_WIDTH{1'b0}}}};

    fixedAddSub #(.MODE(1)) subS1 (.iData1(iData), .iData2(iData2), .oData(microRot[0]))
    fixedAddSub #(.MODE(0)) addS1 (.iData1(iData), .iData2(iData2), .oData(microRot[1]))

    assign mux1Out = iSign ? microRot[1] : microRot[0];

    assign zOut = compin ? iData : mux1Out;

endmodule // stage1 thetaOut

