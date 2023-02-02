module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //

    parameter none=0, b1=1, b2=2, d=3;
    reg [1:0] state, next;
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            none: next = in[3]?b1:none;
            b1: next = b2;
            b2: next = d;
            d: next = in[3]?b1:none;
        endcase
    end
    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset)
            state = none;
        else
            state = next;
    end
    // Output logic
    assign done = (state==d);
endmodule

