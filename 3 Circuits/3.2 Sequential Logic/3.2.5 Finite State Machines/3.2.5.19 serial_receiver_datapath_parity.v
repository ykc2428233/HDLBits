//Note that the serial protocol sends the least significant bit first.
module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //
	
    parameter IDLE=0, START=1, RECEIVE=2, STOP=3, WAIT=4;
    reg [2:0] state, next;
    reg [8:0] dp;
    reg odd;
    int count;
    
    // Use FSM from Fsm_serial
    always @(*) begin
        case (state)
            IDLE: next = in?IDLE:START;
            START: next = RECEIVE;
            RECEIVE: next = (count==9)?(in?STOP:WAIT):RECEIVE;
            STOP: next = in?IDLE:START;
            WAIT: next = in?IDLE:WAIT;
        endcase
    end
    
        always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next;
    end
    
    always @(posedge clk) begin
        if (reset) begin
            done <= 0;
            count <= 0;
        end
        else begin
            case (next)
                RECEIVE: begin
                    done <= 0;
                    count = count+1;
                    odd = in?~odd:odd; 
                end
                STOP: begin
                    done <= odd;
                    count <= 0;
                    odd <= 0;
                end
                default: begin
                    done <= 0;
                    count <= 0;
                    odd <= 0;
                end
            endcase
        end
    end

    // New: Datapath to latch input bits.
    
    always @(posedge clk) begin
        if (reset)
            dp <= 9'b0;
        else if (next == RECEIVE)
            dp <= {dp[7:0], in};
    end
           
    assign out_byte = {dp[1], dp[2], dp[3], dp[4], dp[5], dp[6], dp[7], dp[8]};
    

endmodule


