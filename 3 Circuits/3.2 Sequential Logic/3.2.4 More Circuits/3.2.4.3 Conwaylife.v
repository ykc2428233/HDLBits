module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
    
     int neighbours;
    reg [15:0] data_2d [15:0];
    
    always @(posedge clk) begin
        if (load) 
            q <= data;
        else begin
            for (int j = 0; j < 16; j++) begin
                for (int k = 0; k < 16; k++) begin
                    neighbours = 0;
                    if (k-1<0?data_2d[j][k-1+16]:data_2d[j][k-1])
                        neighbours += 1;
                    
                    if (k+1>15?data_2d[j][k+1-16]:data_2d[j][k+1])
                        neighbours += 1;
                    
                    if (j+1>15?data_2d[j+1-16][k]:data_2d[j+1][k])
                        neighbours += 1;
                    
                    if (j-1<0?data_2d[j-1+16][k]:data_2d[j-1][k])
                        neighbours += 1;
                    
                    /*******************************/
                    if (j-1<0 && k-1<0) begin
                        if (data_2d[j-1+16][k-1+16])
                        	neighbours += 1;
                    end
                    else if (j-1<0 && k-1>=0) begin
                        if (data_2d[j-1+16][k-1])
                        	neighbours += 1;
                    end
					else if (j-1>=0 && k-1>=0) begin
                        if (data_2d[j-1][k-1])
                        	neighbours += 1;
                    end
                    else if (j-1>=0 && k-1<0) begin
                        if (data_2d[j-1][k-1+16])
                        	neighbours += 1;
                    end
                    /*******************************/
                    if (j+1>15 && k+1>15) begin
                        if (data_2d[j+1-16][k+1-16])
                        	neighbours += 1;
                    end
                    else if (j+1>15 && k+1<=15) begin
                        if (data_2d[j+1-16][k+1])
                        	neighbours += 1;
                    end
                    else if (j+1<=15 && k+1<=15) begin
                        if (data_2d[j+1][k+1])
                        	neighbours += 1;
                    end
                    else if (j+1<=15 && k+1>15) begin
                        if (data_2d[j+1][k+1-16])
                        	neighbours += 1;
                    end
                    /*******************************/
                    if (j+1>15 && k-1<0) begin
                        if (data_2d[j+1-16][k-1+16])
                        	neighbours += 1;
                    end
                    else if (j+1>15 && k-1>=0) begin
                        if (data_2d[j+1-16][k-1])
                        	neighbours += 1;
                    end
                    else if (j+1<=15 && k-1>=0) begin
                        if (data_2d[j+1][k-1])
                        	neighbours += 1;
                    end
                    else if (j+1<=15 && k-1<0) begin
                        if (data_2d[j+1][k-1+16])
                        	neighbours += 1;
                    end
                    /*******************************/
                    if (j-1<0 && k+1>15) begin
                        if (data_2d[j-1+16][k+1-16])
                        	neighbours += 1;
                    end
                    else if (j-1<0 && k+1<=15) begin
                        if (data_2d[j-1+16][k+1])
                        	neighbours += 1;
                    end
                    else if (j-1>=0 && k+1<=15) begin
                        if (data_2d[j-1][k+1])
                        	neighbours += 1;
                    end
                    else if (j-1>=0 && k+1>15) begin
                        if (data_2d[j-1][k+1-16])
                        	neighbours += 1;
                    end
                    /*******************************/
                    
                    if (neighbours == 0 || neighbours == 1 || neighbours >= 4)
                        q[j*16+k] <= 1'b0;
	            	else if (neighbours == 3)
    	                q[j*16+k] <= 1'b1;
        	        else if (neighbours == 2)
            	        q[j*16+k] <= q[j*16+k];
                end
            end
        end           
    end
    
    always @(negedge clk) begin
		for (int i = 15; i >= 0; i--) begin
			data_2d[i] <= q[16*i+15 -: 16];
        end
    end

endmodule

