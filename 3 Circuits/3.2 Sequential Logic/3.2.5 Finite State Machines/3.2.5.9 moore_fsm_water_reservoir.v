module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    reg [3:1] previous;
    always @(posedge clk) begin
        if (reset) begin
            dfr <= 1;
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            previous <= {3{1'b0}};
        end
        else begin
			case (s[3:1])
    	        3'h0 : begin fr1 <= 1; fr2 <= 1; fr3 <= 1; end
	    	    3'h1 : begin fr1 <= 1; fr2 <= 1; fr3 <= 0; end
    	    	3'h3 : begin fr1 <= 1; fr2 <= 0; fr3 <= 0; end
        	    3'h7 : begin fr1 <= 0; fr2 <= 0; fr3 <= 0; end
		    endcase
            if (previous > s[3:1]) begin
    	        dfr <= 1;
        	    //fr3 = 0;
            	//fr2 = 0;
	            //fr1 = 0;
    	    end
            else if (previous < s[3:1]) begin
    	        dfr <= 0;
    		end
            previous <= s[3:1];
    	end
    end

endmodule

