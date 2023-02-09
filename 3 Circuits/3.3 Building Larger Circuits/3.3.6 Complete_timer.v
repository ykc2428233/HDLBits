module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    
    parameter IDLE=0, PT0=1, PT1=2, PT2=3, PT3=4, SFT1=5, SFT2=6, SFT3=7, CNT=8, DONE=9;
    reg [3:0] state, next;
    reg shift_ena, done_counting;
    int delay;
    
    always @(*) begin
        case (state)
            IDLE: next = data?PT0:IDLE;
            PT0: next = data?PT1:IDLE;
            PT1: next = data?PT1:PT2;
            PT2: next = data?PT3:IDLE;
            PT3: next = SFT1;
            SFT1: next = SFT2;
            SFT2: next = SFT3;
            SFT3: next = CNT;
            CNT: next = (delay==0)?DONE:CNT;
            DONE: next = ack?IDLE:DONE;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end
        else begin
            state <= next;
        end
    end

	assign shift_ena = (state==PT3 || state==SFT1 || state==SFT2 || state==SFT3);
	assign counting = (state==CNT);
    assign done = (state==DONE);
    
    always @(posedge clk) begin
        if (counting) begin
            delay <= delay-1;
            count <= (delay-1) / 1000;
        end
		else if (shift_ena) begin
            count <= {count[2:0], data};	
            delay <= ({count[2:0], data}+1)*1000-1;
        end
    end
endmodule

