`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2024 12:07:31 PM
// Design Name: 
// Module Name: shift_reg
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


module shift_reg(
	input [0:0] clk,
	input [0:0] cr,
	input [0:0] s0,
	input [0:0] s1,
	input [0:0] sl,
	input [0:0] sr,
	input [7:0] input_data,
	output reg [7:0] data
);
    wire [7:0] left_shifted;
    wire [7:0] right_shifted;
    wire [7:0] shifted_data;
    assign left_shifted = { data[6:0], sl };
	assign right_shifted = { sr, data[7:1] };
	assign shifted_data = ( s0 & s1 )? input_data: ( s1? left_shifted: ( s0? right_shifted: data ) );
	initial data = 8'b0;
	always @(posedge clk or posedge cr) begin
	   data <= cr? 0: shifted_data;
	end
endmodule
