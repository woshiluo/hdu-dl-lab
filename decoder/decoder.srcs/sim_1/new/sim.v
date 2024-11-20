`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2024 11:28:44 AM
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
    reg A, B, C;
    wire [7:0] out;
    decoder d1( A, B, C, 1, 0, 0, out );
    initial begin
        for(integer i=0; i<=1; i=i+1) begin
            for(integer j=0; j<=1; j=j+1) begin
                for(integer k=0; k<=1; k=k+1) begin
                    A=k; B=j; C=i; #100;
                end
            end
        end
    end
endmodule
