`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 06:10:50 PM
// Design Name: 
// Module Name: top
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


module top(
	input clk,
	input sw,
	input [3:0] in_dig,
	output edd_en,
	output [2:0] edd_selc,
	output [7:0] edd_seg
);
	reg [2:0] current;
	reg [6:0] count;
	wire [2:0] nxt_current;
	wire [3:0] r_current;
	edd_converter conv(r_current, edd_seg);
	assign nxt_current = (current == 3'b111)? 0: (current + 1);
	assign edd_en = 1;
	assign edd_selc = current;
	initial current = 3'b111;
	initial count = 0;
	assign r_current = ( count == 3'b111 )? in_dig: {sw, current};
	always @(posedge clk) begin 
		current <= ( count == 7'd127 )? nxt_current: current;
		count <= ( count == 7'd127 )? 0: ( count + 1 );
	end
endmodule

module edd_converter(
	input [3:0] s,
	output [7:0] y
);
	assign y = ( (~s[3])?
		( (~s[2])? 
		( (~s[1])? ( (~s[0])? 8'b0000_0011: 8'b1001_1111 ): ( (~s[0])? 8'b0010_0101: 8'b0000_1101 ) ):
		( (~s[1])? ( (~s[0])? 8'b1001_1001: 8'b0100_1001 ): ( (~s[0])? 8'b0100_0001: 8'b0001_1111 ) ) ): 
		( (~s[2])? 
		( (~s[1])? ( (~s[0])? 8'b0000_0001: 8'b0000_1001 ): ( (~s[0])? 8'b0001_0001: 8'b1100_0001 ) ):
		( (~s[1])? ( (~s[0])? 8'b0110_0011: 8'b1000_0101 ): ( (~s[0])? 8'b0110_0001: 8'b0111_0001 ) ) ) );
endmodule

// module freq_demul( 
// 	input clk,
// 	output [7:0] output_clk
// 	);
// 	reg [2:0] current;
// 	wire [2:0] nxt_current;
// 	assign nxt_current = (current == 3'b111)? 0: (current + 1);
// 	initial current = 3'b111;
// 	always @(posedge clk) begin 
// 		current <= nxt_current;
// 	end
// 	mux mx1(current, clk, output_clk);
// endmodule
// 
// module mux(input [2:0] en, 
// 	input val,
// 	output [7:0] res );
// 	assign res[0] = ( ~en[2] & ~en[1] & ~en[0] ) & val;
// 	assign res[1] = ( ~en[2] & ~en[1] & en[0] ) & val;
// 	assign res[2] = ( ~en[2] & en[1] & ~en[0] ) & val;
// 	assign res[3] = ( ~en[2] & en[1] & en[0] ) & val;
// 	assign res[4] = ( en[2] & ~en[1] & ~en[0] ) & val;
// 	assign res[5] = ( en[2] & ~en[1] & en[0] ) & val;
// 	assign res[6] = ( en[2] & en[1] & ~en[0] ) & val;
// 	assign res[7] = ( en[2] & en[1] & en[0] ) & val;
// endmodule
