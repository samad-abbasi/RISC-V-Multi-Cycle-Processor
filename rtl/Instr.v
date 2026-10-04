`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 10:23:42 AM
// Design Name: 
// Module Name: Instr
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


module Instr(
 input clk,
 input rst,
 input en,
 input [31:0]ReadData,
 output reg [31:0]Instr,
 input [31:0]PC,
 output reg [31:0] OldPC
 
    );
    
   always@(posedge clk)
    begin 
   
    if(rst) begin
    Instr<=32'b0;
     OldPC<=32'b0;
   end
   
    else if (en) begin
    Instr <=ReadData;
     OldPC <=PC;
     end
     
    else begin
    Instr<=Instr;    // hold current value
    OldPC <=OldPC;
    end 
    end 
    endmodule
    

