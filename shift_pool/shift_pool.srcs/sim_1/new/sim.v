`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2024 12:19:07 PM
// Design Name: 
// Module Name: sim
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sim();
    reg s0, s1, sl, sr, cr, clk;
    reg [0:7] input_data;
    wire [0:7] out;
    shift_reg d1( clk, cr, s0, s1, sl, sr, input_data, out );
    initial begin
        clk = 0; cr = 1; s0 = 0; s1 = 0; sl = 0; sr = 0; input_data = 0; #10;
        clk = 1; #10;
        clk = 0; cr = 0; s0 = 1; s1 = 1; sl = 0; sr = 0; input_data = 13; #10;
        clk = 1; #10;
        clk = 0; cr = 0; s0 = 0; s1 = 1; sl = 0; sr = 0; input_data = 13; #10;
        clk = 1; #10;
        clk = 0; cr = 0; s0 = 0; s1 = 1; sl = 1; sr = 0; input_data = 13; #10;
        clk = 1; #10;
        clk = 0; cr = 0; s0 = 1; s1 = 0; sl = 0; sr = 0; input_data = 13; #10;
        clk = 1; #10;
        clk = 0; cr = 0; s0 = 1; s1 = 0; sl = 1; sr = 1; input_data = 13; #10;
        clk = 1; #10;
        clk = 0; cr = 1; #10; 
    end
endmodule
