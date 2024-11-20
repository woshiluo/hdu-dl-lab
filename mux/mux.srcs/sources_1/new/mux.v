`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2024 11:54:01 AM
// Design Name: 
// Module Name: mux
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


module mux(
	input [0:0] nen,
	input [1:0] s,
	input [3:0] a,
	input [3:0] b,
	input [3:0] c,
	input [3:0] d,
	output [3:0] y
);
	wire [3:0] result;
	assign result = s[1]? ( s[0]? d: c ): ( s[0]? b: a );
	assign y = nen? 0: result;
endmodule
