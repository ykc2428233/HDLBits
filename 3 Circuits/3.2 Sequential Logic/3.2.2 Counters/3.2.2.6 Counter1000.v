module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //
    wire [3:0] One, Ten, Hundred;
    assign c_enable = {  One==9&&Ten==9, One==9, 1'b1 };
    bcdcount counter0 (clk, reset, c_enable[2], Hundred);
    bcdcount counter1 (clk, reset, c_enable[1], Ten);
    bcdcount counter2 (clk, reset, c_enable[0], One);
    assign OneHertz = ((Hundred == 9) && (Ten == 9) && (One == 9));

endmodule

