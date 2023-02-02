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
    
    parameter WL=0, WR=1, FL=2, FR=3, DL=4, DR=5;
    reg [2:0] state, next;
    
    always @(*) begin
        case (state)
            WL: next = ground?(dig?(DL):(bump_left?WR:WL)):(FL);
            WR: next = ground?(dig?(DR):(bump_right?WL:WR)):(FR);
            FL: next = ground?WL:FL;
            FR: next = ground?WR:FR;
            DL: next = ground?DL:FL;
            DR: next = ground?DR:FR;
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= WL;
        else
            state <= next;
    end
    
    assign walk_left = (state == WL);
    assign walk_right = (state == WR);
    assign aaah = (state == FL || state == FR);
    assign digging = (state == DL || state == DR);

endmodule

