module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
	parameter A=0, B=1;
    reg state, next;
    int i,j;
    
    always @(*) begin
        case (state)
            A: next = s?B:A;
            B: next = B;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset)
            state <= A;
        else 
            state <= next;
    end
    
    always @(posedge clk) begin
        if (state==A||reset) begin
            i = 0;
	    j = 0;
        end
        if (state==B) begin
            z = 0;
            if (w)
                j = j + 1;
			i = i + 1;
            if (i%3==0) begin
                if (j==2)
                    z <= 1;
                else
                    z <= 0;
                j = 0;
            end

        end
    end
                
endmodule

