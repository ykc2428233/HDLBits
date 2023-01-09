module top_module (
    input clk,
    input d, 
    input ar,   // asynchronous reset
    output q);
    always @(posedge clk, posedge ar)
        q <= ar?1'b0:d;
endmodule
