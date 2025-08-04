module fixedAddSub #(
    parameter DWIDTH = IDWIDTH,
    parameter MODE = 0 // 0 - Add, 1 - Sub
) (
    // Input Signals
    input [DWIDTH-1 : 0] iData1,
    input [DWIDTH-1 : 0] iData2,

    // Output Signal
    output logic [DWIDTH-1 : 0] oData
);

    // Adder Code
    generate
        if(MODE==0) begin : gen_adder
            assign oData = iData1 + iData2;    
        end
        else begin : gen_subtractor
            assign oData = iData1 + (~iData2 + 1'b1);
        end
    endgenerate

endmodule //fixedAddSub

