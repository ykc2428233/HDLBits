module top_module (
    input clk,
    input j,
    input k,
    output Q); 

    always @(posedge clk) begin
        case({j,k})
            2'h0 : Q <= Q;
            2'h1 : Q <= 1'b0;
            2'h2 : Q <= 1'b1;
            2'h3 : Q <= ~Q;
        endcase
    end
            
endmodule

