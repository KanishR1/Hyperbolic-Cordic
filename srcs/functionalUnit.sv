module functionalUnit #(
    parameter DWIDTH = IDWIDTH
) (
    // Input Signals
    input [DWIDTH-1 : 0] iData1,
    input [DWIDTH-1 : 0] iData2,
    input iSign,
    input compin,
    

    // Output Signal
    output logic [DWIDTH-1 : 0] oData
);

    logic [DWIDTH-1 : 0] acosh;
    logic [DWIDTH-1 : 0] bsinh;

    logic [DWIDTH-1 : 0] mux1Out;


    s1cosh acosinst (.iData(iData1), .coshOut(acosh));
    s1sinh bsininst (.iData(iData2), .sinhOut(bsinh));

    logic [DWIDTH-1 : 0] interVal [2];

    fixedAddSub #(.MODE(0)) adder (.iData1(acosh), .iData2(bsinh), .oData(interVal[0]));
    fixedAddSub #(.MODE(1)) sub (.iData1(acosh), .iData2(bsinh), .oData(interVal[1]));

    assign mux1Out = iSign ? interVal[1] : interVal[0];

    assign oData = compin ? iData1 : mux1Out;

endmodule // Functional Unit
