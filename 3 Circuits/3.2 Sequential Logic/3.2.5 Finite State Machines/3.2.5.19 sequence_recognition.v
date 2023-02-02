module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    parameter NONE=0, ONE=1, TWO=2, THREE=3, FOUR=4, FIVE=5, SIX=6, ERR=7, FLAG=8, DISC=9;
    reg [3:0] state, next;
    
    always @(*) begin
        case (state)
            NONE: next = in?ONE:NONE;
            ONE: next = in?TWO:NONE;
            TWO: next = in?THREE:NONE;
            THREE: next = in?FOUR:NONE;
            FOUR: next = in?FIVE:NONE;
            FIVE: next = in?SIX:DISC;
            SIX: next = in?ERR:FLAG;
            ERR: next = in?ERR:NONE;
            FLAG: next = in?ONE:NONE;
            DISC: next = in?ONE:NONE;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset)
            state <= NONE;
        else 
            state <= next;
    end
    
	assign disc = (state==DISC);
	assign flag = (state==FLAG);
	assign err = (state==ERR);
    
            
endmodule

