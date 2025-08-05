`include "hyperCord_pkg.svh"
/* verilator lint_off IMPORTSTAR */
import hyperCord_pkg::*;
/* verilator lint_on IMPORTSTAR */

module hyperCord #(
    parameter DWIDTH = IDWIDTH,
    parameter FRA_WIDTH = I_FRA_WIDTH
) (
    // Global Signals
    input clk,
    input aresetn,

    // Input Signals
    input [DWIDTH-1 : 0] Zin,

    // Output signals
    output [DWIDTH-1 : 0] coshOut,
    output [DWIDTH-1 : 0] sinhOut
);

    logic [DWIDTH-1 : 0] Xin;
    logic [DWIDTH-1 : 0] Yin;
    logic [DWIDTH-1 : 0] absZin;

    assign absZin = absval(Zin);

    // Coarse comparison logic

    always_comb begin
        if (absZin <= {1'b0,4'b0000,11'b11001001000}) begin
            Xin = DWIDTH'(1<<FRA_WIDTH);
            Yin = '0;
        end
        else if (absZin <= {1'b0,4'b0001,11'b10010010000}) begin
            Xin = {1'b0,4'b0010,11'b10000010100};
            Yin = {1'b1,4'b1101,11'b10110011010};
        end
        else if (absZin <= {1'b1,4'b0010,11'b01011011001}) begin
            Xin = {1'b0,4'b0010,11'b10000010100};
            Yin = {1'b0,4'b0010,11'b01001100110};
        end
        else begin
            Xin = {1'b0,4'b1011,11'b10010111000};
            Yin = {1'b1,4'b0100,11'b01110011010};
        end
    end

    logic [DWIDTH-1 : 0] Xstage[5];
    logic [DWIDTH-1 : 0] Xcomb[4];

    logic [DWIDTH-1 : 0] Ystage[5];
    logic [DWIDTH-1 : 0] Ycomb[4];

    logic [DWIDTH-1 : 0] Zstage[4];
    logic [DWIDTH-1 : 0] Zcomb[3];

    for (genvar i=0; i<4; i++) begin : gen_stages
        always_ff @(posedge clk, negedge aresetn ) begin
            if(!aresetn) begin
                Xstage[i] <= '0;
                Ystage [i] <= '0;
                Zstage [i] <= '0;
            end
            else if(i==0) begin
                Xstage[i] <= Xin;
                Ystage[i] <= Yin;
                Zstage[i] <= Zin;
            end
            else begin
               Xstage[i] <= Xcomb[i-1];
               Ystage[i] <= Ycomb[i-1];
               Zstage[i] <= Zcomb[i-1];
            end
        end
    end

    always_ff @( posedge clk, negedge aresetn ) begin
        if(!aresetn) begin
            Xstage[4] <= '0;
            Ystage [4] <= '0;
        end
        else begin
           Xstage[4] <= Xcomb[3];
           Ystage[4] <= Ycomb[3];
        end
    end

    stage1 s1 (.Xin(Xstage[0]), .Yin(Ystage[0]), .Zin(Zstage[0]), .Xout(Xcomb[0]), .Yout(Ycomb[0]), .Zout(Zcomb[0]));
    stage2 s2 (.Xin(Xstage[1]), .Yin(Ystage[1]), .Zin(Zstage[1]), .Xout(Xcomb[1]), .Yout(Ycomb[1]), .Zout(Zcomb[1]));
    stage3 s3 (.Xin(Xstage[2]), .Yin(Ystage[2]), .Zin(Zstage[2]), .Xout(Xcomb[2]), .Yout(Ycomb[2]), .Zout(Zcomb[2]));
    stage4 s4 (.Xin(Xstage[3]), .Yin(Ystage[3]), .Zin(Zstage[3]), .Xout(Xcomb[3]), .Yout(Ycomb[3]));

    assign coshOut = Xstage[4];
    assign sinhOut = Ystage[4];

endmodule
