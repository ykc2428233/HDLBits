module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    
    parameter none=0, one=1, one_one=2, one_one_O=3, f=4;
    reg [2:0] state, next;
    
    always @(*) begin
        case (state)
            none: next = data?one:none;
            one:  next = data?one_one:none;
            one_one: next = data?one_one:one_one_O;
            one_one_O: next = data?f:none;
            f: next = f;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            state <= none;
        end
        else begin
            state <= next;
        end
    end
    
    assign start_shifting = (state==f);

endmodule

