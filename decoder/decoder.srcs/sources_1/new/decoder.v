`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2024 11:25:04 AM
// Design Name: 
// Module Name: decoder
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


module decoder(
	input [0:0] A,
	input [0:0] B,
	input [0:0] C,
	input [0:0] g1,
	input [0:0] g2a,
	input [0:0] g2b,
	output [7:0] y
    );
	assign y[0] = g1 & (~g2a) & (~g2b) & (~C) & (~B) & (~A);
	assign y[1] = g1 & (~g2a) & (~g2b) & (~C) & (~B) & (A);
	assign y[2] = g1 & (~g2a) & (~g2b) & (~C) & (B) & (~A);
	assign y[3] = g1 & (~g2a) & (~g2b) & (~C) & (B) & (A);
	assign y[4] = g1 & (~g2a) & (~g2b) & (C) & (~B) & (~A);
	assign y[5] = g1 & (~g2a) & (~g2b) & (C) & (~B) & (A);
	assign y[6] = g1 & (~g2a) & (~g2b) & (C) & (B) & (~A);
	assign y[7] = g1 & (~g2a) & (~g2b) & (C) & (B) & (A);
endmodule

