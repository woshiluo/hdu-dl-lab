`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2024 11:57:47 AM
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


module sim(

    );
    reg [1:0] A;
    wire [3:0] out;
    mux d1( 0, A, 10, 9, 8, 7, out );
    initial begin
        for(integer i=0; i<4; i=i+1) begin
            A=i; #100;
        end
    end
endmodule