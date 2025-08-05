module functionalUnitS4 #(
    parameter DWIDTH = IDWIDTH
) (
    // Input Signals
    input [DWIDTH-1 : 0] iData1,
    input [DWIDTH-1 : 0] iData2,
    input [3:0] k,
    input iSign,

    // Output Signal
    output logic [DWIDTH-1 : 0] oData
);

    logic [DWIDTH-1 : 0] a;



    s4sinhcosh inst1 (.iData(iData2), .k(k), .oData(a));


    logic [DWIDTH-1 : 0] interVal [2];

    fixedAddSub #(.MODE(0)) adder (.iData1(iData1), .iData2(a), .oData(interVal[0]));
    fixedAddSub #(.MODE(1)) sub (.iData1(iData1), .iData2(a), .oData(interVal[1]));

    assign oData = iSign ? interVal[0] : interVal[1];

endmodule // Functional Unit Stage 4

