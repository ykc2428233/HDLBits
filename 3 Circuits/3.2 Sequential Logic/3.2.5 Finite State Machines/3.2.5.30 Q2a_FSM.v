module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    input w,
    output z
);

    reg [3:1] A=3'h0, B=3'h1, C=3'h2, D=3'h3, E=3'h4, F=3'h5;
    reg [3:1] state, next;
    always @(*) begin
        case (state)
            A: next = w?B:A;
            B: next = w?C:D;
            C: next = w?E:D;
            D: next = w?F:A;
            E: next = w?E:D;
            F: next = w?C:D;
            default: next = A;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) 
            state <= A;
	    else
            state <= next;
    end
    
    assign z = (state==E) || (state==F);
            
endmodule


