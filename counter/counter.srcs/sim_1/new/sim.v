`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2024 12:48:29 PM
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
    reg clk, nct, nld, ud;
    wire max_min, rco;
    reg [3:0] d;
    wire [3:0] out;
    counter d1( clk, nct, nld, ud, d, max_min, rco, out);
    initial begin
        clk=0; nld = 0; nct = 0; ud = 0; d = 15; #10;
        clk=1; #10;
        clk=0; nld = 1; nct = 1; #10;
        clk=1; #10;
        clk=0; nct = 0; ud = 0; #10;
        clk=1; #10;
        clk=0; #10;
        clk=1; #10;
        clk=0; ud = 1; #10;
        clk=1; #10;
        clk=0; #10;
        clk=1; #10;
        
    end
endmodule
