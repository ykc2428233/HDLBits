module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter A=0, B=1, C=2;
    reg [1:0] state, next;
    
    always @(*) begin
        case (state)
            A: next = x?B:A; //first bit and bits with count in, output 0
            B: next = x?C:B; //bits without count in, output 1
            C: next = x?C:B; //bits without count in, output 0
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= A;
        else
        	state <= next;
    end
	
    assign z = (state == B);
    
endmodule

