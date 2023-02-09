module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
    always @(posedge clk) begin
        if (a==b)
            state <= b;
        else
            state <= state;
    end
    assign q = state?~(a^b):(a^b);
endmodule

