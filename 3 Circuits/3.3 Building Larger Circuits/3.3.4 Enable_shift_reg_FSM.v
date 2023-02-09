module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
	parameter A=0, B=1, C=2, D=3, E=4;
    reg [2:0] state, next;
    
    always @(*) begin
        case (state)
            A: next = reset?B:A;
            B: next = C;
            C: next = D;
            D: next = E;
            E: next = A;
        endcase
    end
    
    always @(posedge clk) begin
		state <= next;
    end
    
    assign shift_ena = ~(state==A);
endmodule

