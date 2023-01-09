module top_module (
    input clk,
    input d,
    output q
);
    reg temp0, temp1;
    always @(posedge clk) begin
        temp0 <= d;
    end
    
    always @(negedge clk) begin
        temp1 <= d;
    end
	assign q = clk?temp0:temp1;
endmodule

