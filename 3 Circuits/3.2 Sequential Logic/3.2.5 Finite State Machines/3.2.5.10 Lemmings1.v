module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    // parameter LEFT=0, RIGHT=1, ...
    reg state, next_state;
    parameter L=0, R=1;

    always @(*) begin
        // State transition logic
        case (state)
            L: next_state = bump_left?R:L;
            R: next_state = bump_right?L:R;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset)
            state <= L;
        else
            state <= next_state;
    end

    // Output logic
    assign walk_left = (state == L);
    assign walk_right = (state == R);

endmodule

