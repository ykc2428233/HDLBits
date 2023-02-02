module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    parameter none=0, b1=1, b2=2, d=3;
    reg [1:0] state, next;
    reg [7:0] p_in;
    // FSM from fsm_ps2
    always @(*) begin
        case (state)
            none: next = in[3]?b1:none;
            b1: next = b2;
            b2: next = d;
            d: next = in[3]?b1:none;
        endcase
    end
    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= none;
            p_in <= in;
        end
        else begin
            state <= next;
         	p_in <= in;
        end
    end
    // New: Datapath to store incoming bytes.
    always @(posedge clk) begin
        if (reset)
            out_bytes <= 24'b0;
		else
            out_bytes <= {out_bytes[15:8], out_bytes[7:0], in};
    end
    
    assign done = (state==d);

endmodule

