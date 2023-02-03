module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);

    reg [3:1] A=3'h0, B=3'h1, C=3'h2, D=3'h3, E=3'h4, F=3'h5;
    reg [3:1] state, next;
    always @(*) begin
        case (state)
            A: next = w?A:B;
            B: next = w?D:C;
            C: next = w?D:E;
            D: next = w?A:F;
            E: next = w?D:E;
            F: next = w?D:C;
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

