module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
	parameter NONE=0, ONE=1, ONE_ZERO=2;
    reg [1:0] state, next;
    reg [2:0] seq;
    always @(*) begin
        case (state)
            NONE: next = x?ONE:NONE;
            ONE: next = x?ONE:ONE_ZERO;
            ONE_ZERO: next = x?ONE:NONE;
        endcase
    end
    
    always @(posedge clk, negedge aresetn) begin
        if (~aresetn)
            state <= NONE;
        else
            state <= next;
    end

    assign z = (state==ONE_ZERO && x==1);
    
endmodule

