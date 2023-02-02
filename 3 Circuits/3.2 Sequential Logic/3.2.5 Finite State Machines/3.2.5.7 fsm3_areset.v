module top_module(
    input clk,
    input in,
    input areset,
    output out); //
	
    parameter A=0, B=1, C=2, D=3;
    reg [1:0] state, next;
    // State transition logic
    always @(*) begin
        case (state)
            A: next = in?B:A;
            B: next = in?B:C;
            C: next = in?D:A;
            D: next = in?B:C;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next;
    end
    // Output logic
    assign out = (state==D);

endmodule

