package hyperCord_pkg;

    parameter int I_INT_WIDTH = 5;
    parameter int I_FRA_WIDTH = 2;
    parameter int I_SIGN_WIDTH = 1;

    // Inputs are in 2's complement format
    parameter IDWIDTH = I_SIGN_WIDTH + I_INT_WIDTH + I_FRA_WIDTH;

    // Function to compute absolute value
    function automatic logic [IDWIDTH-1 : 0] absval (input logic [IDWIDTH-1 : 0] iData);
        begin
            
            logic signbit;
            logic [IDWIDTH-2 : 0] onesComp;
            logic [IDWIDTH-1 : 0] twosComp;
            logic [IDWIDTH-1 : 0] absres;

            signbit = iData[IDWIDTH-1];
            onesComp = iData[IDWIDTH-2:0] ^ {(IDWIDTH-1){signbit}};
            twosComp = onesComp + {{(IDWIDTH-2){1'b0}},signbit};

            assign absval = {1'b0,twosComp[IDWIDTH-2:0]};
            return absval;
        end
    endfunction

endpackage