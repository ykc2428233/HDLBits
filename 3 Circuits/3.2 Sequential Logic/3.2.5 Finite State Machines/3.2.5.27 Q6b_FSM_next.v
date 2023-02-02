module top_module (
    input [3:1] y,
    input w,
    output Y2);
    reg [3:1] A=3'h0, B=3'h1, C=3'h2, D=3'h3, E=3'h4, F=3'h5;
    reg [3:1] next;
    always @(*) begin
        case (y)
            A: next = w?A:B;
            B: next = w?D:C;
            C: next = w?D:E;
            D: next = w?A:F;
            E: next = w?D:E;
            F: next = w?D:C;
            default: next = A;
        endcase
    end
    
    assign Y2 = next[2];
            
endmodule

