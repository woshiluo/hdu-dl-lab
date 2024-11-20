`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2024 12:32:36 PM
// Design Name: 
// Module Name: counter
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


module counter(
	input [0:0] clk,
	input [0:0] nct,
	input [0:0] nld,
	input [0:0] ud,
	input [3:0] d,
	output [0:0] max_min,
	output [0:0] rco,
	output reg [3:0] q
);
    wire [3:0] data;
    assign rco = clk | nct | (~max_min);
    initial q = 0;
    assign data = nct? q: (ud? (q - 1): (q + 1));
	assign max_min = ud? (q == 0): (q == 'b1111);
	always @(posedge clk or negedge nld) begin
	   q <= (~nld)? d: data;
	end
endmodule
