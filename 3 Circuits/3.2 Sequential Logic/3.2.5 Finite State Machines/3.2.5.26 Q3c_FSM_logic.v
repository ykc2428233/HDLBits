module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
	parameter A=0, B=1, C=2, D=3, E=4;
    reg [2:0] Y;
    
    always @(*) begin
        //state = y;
        case (y)
            A: Y = x?B:A;
            B: Y = x?E:B;
            C: Y = x?B:C;
            D: Y = x?C:B;
            E: Y = x?E:D;
        endcase
    end
		
    /*always @(posedge clk) begin
        state <= Y;
    end*/
    
    assign z = (y==D) || (y==E);
    assign Y0 = Y[0];
endmodule

