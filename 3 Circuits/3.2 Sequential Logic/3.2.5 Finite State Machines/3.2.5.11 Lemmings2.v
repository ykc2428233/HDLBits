module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter WR=0, WL=1, FR=2, FL=3;
    reg [1:0] state, next;
    
    always @(*) begin
        case (state)
            WR: next = ground?(bump_right?WL:WR):(FR);
            WL: next = ground?(bump_left?WR:WL):(FL);
            FL: next = ground?WL:FL;
            FR: next = ground?WR:FR;
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
    assign aaah = (state == FR || state == FL);
endmodule

