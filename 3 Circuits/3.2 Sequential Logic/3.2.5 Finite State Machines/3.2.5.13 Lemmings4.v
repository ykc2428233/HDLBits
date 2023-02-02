module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    parameter WL=0, WR=1, FL=2, FR=3, DL=4, DR=5, SP=6;
    reg [2:0] state, next;
    int count;
    
    always @(*) begin
        case (state)
			WL: next = ground?(dig?(DL):(bump_left?WR:WL)):(FL);
			WR: next = ground?(dig?(DR):(bump_right?WL:WR)):(FR);
            FL: next = ground?((count>19)?SP:WL):FL;
            FR: next = ground?((count>19)?SP:WR):FR;
	        DL: next = ground?DL:FL;
			DR: next = ground?DR:FR;
            SP: next = SP;
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= WL;
            count <= 0;
        end
        else begin
            if (state == FL || state == FR) begin
                count <= count + 1;
            end
            else begin 
                count <= 0;
            end
            state <= next;
        end
    end

    assign walk_left = (state == WL);
    assign walk_right = (state == WR);
    assign aaah = (state == FL || state == FR);
    assign digging = (state == DL || state == DR);
    

endmodule

