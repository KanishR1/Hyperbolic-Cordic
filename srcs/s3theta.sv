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
module s3theta #(
    parameter INT_WIDTH = I_INT_WIDTH,
    parameter FRA_WIDTH = I_FRA_WIDTH,
    parameter DWIDTH = IDWIDTH
)(
    // Inputs
    input [DWIDTH-1 : 0] iData,
    input iSign,
    input compin,
    input scomp,

    // Output Signals
    output logic [DWIDTH-1 : 0] zOut
);

    logic [DWIDTH-1 : 0] mux1Out;
    logic [DWIDTH-1 : 0] mux2Out;
    logic [DWIDTH-1 : 0] mux3Out;

    logic [DWIDTH-1 : 0] microRot [4];
    logic [DWIDTH-1 : 0] iData2;
    logic [DWIDTH-1 : 0] iData3;

    assign iData2 = DWIDTH'({1'b0, {INT_WIDTH{1'b0}}, 4'b0001, {(FRA_WIDTH > 4 ? FRA_WIDTH-4 : 0){1'b0}}});
    assign iData3 = DWIDTH'({1'b0, {INT_WIDTH{1'b0}}, 5'b00001, {(FRA_WIDTH > 5 ? FRA_WIDTH-5 : 0){1'b0}}});


    fixedAddSub #(.MODE(1)) subS1 (.iData1(iData), .iData2(iData2), .oData(microRot[0]));
    fixedAddSub #(.MODE(0)) addS1 (.iData1(iData), .iData2(iData2), .oData(microRot[1]));

    fixedAddSub #(.MODE(1)) subS2 (.iData1(iData), .iData2(iData3), .oData(microRot[2]));
    fixedAddSub #(.MODE(0)) addS2 (.iData1(iData), .iData2(iData3), .oData(microRot[3]));



    assign mux1Out = iSign ? microRot[1] : microRot[0];
    assign mux2Out = iSign ? microRot[3] : microRot[2];

    assign mux3Out = scomp ? mux1Out : mux2Out;

    assign zOut = compin ? iData : mux3Out;

endmodule // stage3 thetaOut

