`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 06:22:03 PM
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
    reg clk;
    wire edd_en;
    wire [2:0] edd_selc;
    wire [7:0] edd_seg;
    top d1( clk, edd_en, edd_selc, edd_seg );
    initial begin
		for(integer i=0; i<=1000; i=i+1) begin
			clk = 0; #10;
			clk = 1; #10;
		end
    end
endmodule
