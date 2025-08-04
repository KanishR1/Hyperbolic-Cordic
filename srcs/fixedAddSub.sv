`include "hyperCord_pkg.svh"
import hyperCord_pkg::*;

module fixedAddSub #(
    parameter INT_WIDTH = I_INT_WIDTH,
    parameter FRA_WIDTH = I_FRA_WIDTH,
    parameter SIGN_WIDTH = I_SIGN_WIDTH,
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

