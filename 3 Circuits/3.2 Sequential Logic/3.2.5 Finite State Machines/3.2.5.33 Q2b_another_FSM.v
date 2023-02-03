module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
	parameter A=0, B=1, C=2, D=3, E=4, F=5, G=6, H=7, I=8, J=9;
    reg [3:0] state, next;
    
    always @(*) begin
        case (state)
            A: next = B;
            B: next = C;
            C: next = x?D:C; //wrong
            D: next = x?D:E; //1
            E: next = x?F:C; //1,0
            F: next = y?I:G; //x=1,0,1; set g=1
            G: next = y?I:H; //y:0, g=1
            H: next = H; //y:0,0, y does not have 1
            I: next = I; //y has 1
        endcase
    end
    
    always @(posedge clk) begin
        if (~resetn)
            state <= A;
        else
            state <= next;
    end
    
    assign f = (state==B);
    assign g = (state == F || state==G || state==I);
endmodule

