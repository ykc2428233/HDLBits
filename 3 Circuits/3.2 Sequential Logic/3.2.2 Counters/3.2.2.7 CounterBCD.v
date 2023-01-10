module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    wire [3:0] q1, q10, q100, q1000;
    assign ena = { q1==9 && q10==9 && q100 == 9, q1==9 && q10==9, q1==9};
    assign q = {q1000, q100, q10, q1};
    BCD_counter one (clk, reset, 1'b1, q1);
    BCD_counter ten (clk, reset, ena[1], q10);
    BCD_counter hun (clk, reset, ena[2], q100);
    BCD_counter tho (clk, reset, ena[3], q1000);
endmodule

module BCD_counter (
    input clk,
    input reset,
    input ena,
    output [3:0] q);
    always @(posedge clk) begin
        if (reset || (q == 4'h9 && ena))
            q <= 4'h0;
        else if (ena && ~reset)
            q <= q + 4'h1;
    end
            
endmodule
