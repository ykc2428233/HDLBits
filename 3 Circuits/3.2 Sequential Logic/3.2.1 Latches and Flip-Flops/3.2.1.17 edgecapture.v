module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] temp;
    always @(posedge clk) begin
        temp <= in;
        out <= reset?8'h0:out|(temp&~in);
    end
    
endmodule

