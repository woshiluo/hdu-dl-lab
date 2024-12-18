`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2024 06:36:58 PM
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
	input clr,
	input start,
	input stopa,
	input stopb,
	input pause,
	output edd_en,
	output [2:0] edd_selc,
	output [7:0] edd_seg,
	output reg [5:0] led
);
	reg [15:0] bcds;
	reg [3:0] state;
	// 0 1 2 3 state 1 2 3 4
	// 4 stop
	// 5 block
	reg [5:0] count;
	reg dis;
	reg dash;
	wire [3:0] mainh;
	wire [3:0] mainl;
	wire [3:0] subh;
	wire [3:0] subl;
	wire second_clk;
	assign subl = bcds[15:12];
	assign subh = bcds[11:8];
	assign mainl = bcds[7:4];
	assign mainh = bcds[3:0];
	wire updating_time;
	wire [3:0] main_maxh;
	wire [3:0] main_maxl;
	wire [3:0] sub_maxh;
	wire [3:0] sub_maxl;
	wire [3:0] nxt_state;
	initial state = 4;
	initial bcds = 0;
	initial count = 0;
	initial dis = 0;
	initial dash = 1;
	assign updating_time = ( state == 0 )? ( ( count == 35 )? 1: 0 ):
                 ( state == 1 )? ( ( count == 5  )? 1: 0 ):
                 ( state == 2 )? ( ( count == 25 )? 1: 0 ):
                 ( state == 3 )? ( ( count == 5  )? 1: 0 ): start;
	assign nxt_state = start? 0: ( updating_time? ( ( state == 3 )? 0: ( state + 1 ) ): state );
	assign main_maxh = ( nxt_state == 0 )? 3:
                       ( nxt_state == 1 )? 0:
                       ( nxt_state == 2 )? 3:
                       ( nxt_state == 3 )? 0: 0;
	assign main_maxl = ( nxt_state == 0 )? 5:
                       ( nxt_state == 1 )? 5:
                       ( nxt_state == 2 )? 0:
                       ( nxt_state == 3 )? 5: 0;
	assign sub_maxh = ( nxt_state == 0 )? 4:
                      ( nxt_state == 1 )? 0:
                      ( nxt_state == 2 )? 2:
                      ( nxt_state == 3 )? 0: 0;
	assign sub_maxl = ( nxt_state == 0 )? 0:
                      ( nxt_state == 1 )? 5:
                      ( nxt_state == 2 )? 5:
                      ( nxt_state == 3 )? 5: 0;

	freq_demux f1( clk, clr, second_clk );
	bcd_driver b1( clk, clr, bcds, dis, dash, edd_en, edd_selc, edd_seg );
	always @(posedge second_clk or posedge clr) begin 
		bcds[3:0] <= clr? 0: ( pause? mainh: updating_time? main_maxh: 
			           ( stopa | stopb )? 0: ( mainl == 0 )? ( mainh - 1 ): mainh );
		bcds[7:4]  <= clr? 0: ( pause? mainl: updating_time? main_maxl: 
			           ( stopa | stopb )? 0: ( mainl == 0 )? 9: ( mainl - 1 ) );
		bcds[11:8]   <= clr? 0: ( pause?  subh: updating_time? sub_maxh: 
			           ( stopa | stopb )? 0: ( subl == 0 )? ( subh - 1 ): subh );
		bcds[15:12]   <= clr? 0: ( pause?  subl: updating_time? sub_maxl: 
			           ( stopa | stopb )? 0: ( subl == 0 )? 9: ( subl - 1 ) );
		dash <= clr? 1: ( state == 4 );
		dis <= clr? 0: ( state == 5 );
		// main r g b
		led[0] <= clr? 0: ( stopa | ( state == 2 ) | ( state == 3 ) | ( state == 4 ) );
		led[1] <= clr? 0: ( state == 1 ) & mainl[0];
		led[2] <= clr? 0: ( stopb | ( state == 0 ) );
		// sub r g b
		led[3] <= clr? 0: stopb | ( state == 0 ) | ( state == 1 ) | ( state == 4 );
		led[4] <= clr? 0: ( state == 3 ) & subl[0];
		led[5] <= clr? 0: stopa | ( state == 2 );
		count <= clr? 0: ( pause? count: ( updating_time? 0: ( count + 1 ) ) );
		state <= clr? 4: ( pause? state: ( ( stopa | stopb )? 5: ( updating_time? nxt_state: state ) ) );
	end
endmodule

module bcd_driver(
	input clk,
	input clr,
	input [15:0] bcds,
	input dis,
	input dash,
	output edd_en,
	output [2:0] edd_selc,
	output [7:0] edd_seg
);
	wire bcd_clk;
	bcd_freq_demux f1( clk, clr, bcd_clk );
	bcd_converter conv(r_current, dis | ( dash? 0: ( edd_selc >= 4 ) ), dash, edd_seg);
	reg [2:0] current;
	wire [3:0] r_current;
	assign edd_en = 1;
	assign edd_selc = current;
	assign r_current = ( current == 0 )? ( bcds[3:0] ): 
					 ( current == 1 )? ( bcds[7:4] ):
					 ( current == 2 )? ( bcds[11:8] ):
					 ( current == 3 )? ( bcds[15:12] ):
					 0;
	always @(posedge bcd_clk or posedge clr) begin
		current <= clr? 0: ( ( current == 3'b111 )? 0: ( current + 1 ) );
	end
endmodule

module bcd_converter(
	input [3:0] s,
	input dis,
	input dash,
	output [7:0] y
);
	// dis -> dash -> s
	assign y = dis? 8'b1111_1111:
		dash? 8'b1111_1101:
		( (~s[3])?
		( (~s[2])? 
		( (~s[1])? ( (~s[0])? 8'b0000_0011: 8'b1001_1111 ): ( (~s[0])? 8'b0010_0101: 8'b0000_1101 ) ):
		( (~s[1])? ( (~s[0])? 8'b1001_1001: 8'b0100_1001 ): ( (~s[0])? 8'b0100_0001: 8'b0001_1111 ) ) ): 
		( (~s[2])? 
		( (~s[1])? ( (~s[0])? 8'b0000_0001: 8'b0000_1001 ): ( (~s[0])? 8'b0001_0001: 8'b1100_0001 ) ):
		( (~s[1])? ( (~s[0])? 8'b0110_0011: 8'b1000_0101 ): ( (~s[0])? 8'b0110_0001: 8'b0111_0001 ) ) ) );
endmodule

module freq_demux( 
	input clk,
	input clr,
	output reg nclk
);
	reg [31:0] count;
	initial count = 0;
	always @(posedge clk or posedge clr) begin 
		count <= clr? 0: ( count == 4_000_000 ? 0: ( count + 1 ) );
		nclk <= clr? 0: ( count == 4_000_000 ? ~nclk: nclk );
	end
endmodule

module bcd_freq_demux( 
	input clk,
	input clr,
	output reg nclk
);
	reg [31:0] count;
	initial count = 0;
	always @(posedge clk or posedge clr) begin 
		count <= clr? 0: ( count == 200 ? 0: ( count + 1 ) );
		nclk <= clr? 0: ( count == 200 ? ~nclk: nclk );
	end
endmodule
