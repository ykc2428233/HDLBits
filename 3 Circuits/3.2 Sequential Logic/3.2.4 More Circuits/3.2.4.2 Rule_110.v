module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 
    wire [511:0] q0 ,q1;
    assign q0 = {1'b0, q[511:1]};
    assign q1 = {q[510:0], 1'b0};
    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= (q&~q1) | (~q0&q) | (~q&q1);
    end

endmodule

