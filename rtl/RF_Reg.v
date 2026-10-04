`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 11:19:25 AM
// Design Name: 
// Module Name: RF_Reg
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

module RF_Reg(
 input clk,
 input rst,

 input [31:0]RD1,
 output reg [31:0]A,
 input [31:0]RD2,
 output reg [31:0] WriteData
 
    );
    
   always@(posedge clk)
    begin 
   
    
    if(rst) begin
     A<=32'b0;
     WriteData<=32'b0;
   end
   
    else begin
    A <=RD1;
     WriteData <=RD2;
     end
    end
    endmodule

