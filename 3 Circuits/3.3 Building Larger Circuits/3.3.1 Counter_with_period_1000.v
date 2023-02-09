module top_module (
    input clk,
    input reset,
    output [9:0] q);
	int count;
    always @(posedge clk) begin
        if (reset)
            count = 0;
        if (count < 1000)
            q = count;
        else begin
            count = 0;
            q = count;
        end
        count += 1;
    end
endmodule

