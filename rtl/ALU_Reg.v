`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 11:24:48 AM
// Design Name: 
// Module Name: ALU_Reg
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


module ALU_Reg(
 input clk,
 input rst,
 input [31:0]ALUResult,
 output reg [31:0]ALUOut
    );
    always@(posedge clk)
    begin 
   
    if(rst)
    ALUOut<=32'b0;
   
    else 
    ALUOut <=ALUResult;
    end
endmodule


