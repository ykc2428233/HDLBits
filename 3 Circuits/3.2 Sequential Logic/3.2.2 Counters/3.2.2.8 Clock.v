module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    
    counter10 sec1 (clk, reset, ena, ss[3:0]);
    counter6 sec10 (clk, reset, ena&&ss[3:0]==4'h9, ss[7:4]);
    counter10 min1 (clk, reset, ena&&ss[3:0]==4'h9&&ss[7:4]==4'h5, mm[3:0]);
    counter6 min10 (clk, reset, ena&&ss[3:0]==4'h9&&ss[7:4]==4'h5&&mm[3:0]==4'h9, mm[7:4]);
    counter12 hour11 (clk, reset, ena&&ss[3:0]==4'h9&&ss[7:4]==4'h5&&mm[3:0]==4'h9&&mm[7:4]==4'h5, hh[7:0]);
    
    always @(posedge clk) begin
        pm <= (ena && ss[3:0]==4'h9 && ss[7:4]==4'h5 && mm[3:0]==4'h9 && mm[7:4]==4'h5 && hh[7:0]==8'h11)? ~pm : pm;
    end

endmodule

module counter10 (
    input clk,
    input reset,
    input ena,
    output [3:0] out);
    always @(posedge clk) begin
        if (reset || (ena && out == 4'h9))
            out <= 4'h0;
        else if(~reset && ena)
            out <= out + 4'h1;
    end
endmodule

module counter6 (
    input clk,
    input reset,
    input ena,
    output [3:0] out);
    always @(posedge clk) begin
        if (reset || (ena && out == 4'h5))
            out <= 4'h0;
        else if(~reset && ena)
            out <= out + 4'h1;
    end
endmodule

module counter12 (
    input clk,
    input reset,
    input ena,
    output [7:0] out);
    always @(posedge clk) begin
        if (reset)
            out <= 8'h12;
        else if(~reset && ena && out == 8'h09)
            out <= 8'h10;
        else if(~reset && ena && out == 8'h12)
            out <= 8'h01;
        else if(~reset && ena)
            out <= out + 8'h1;
    end
endmodule


