module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    reg [3:0] q;
    qreg reg1 (clk, resetn, in, q[3]);
    genvar i;
    generate
        for (i = 3; i > 0; i--) begin : test
        	qreg regs (clk, resetn, q[i], q[i-1]);
	    end
    endgenerate
    assign out = q[0];
endmodule
        
module qreg (
	input clk,
	input reset,
	input in,
	output out);
    always @(posedge clk) begin
        if (~reset)
            out <= 1'b0;
    	else
            out <= in;
    end
endmodule

