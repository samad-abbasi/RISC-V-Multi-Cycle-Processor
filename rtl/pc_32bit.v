`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2026 02:30:16 PM
// Design Name: 
// Module Name: pc_32bit
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


module pc_32bit( clk,rst,en,prev_value,count

   );
    input clk;
    input rst,en;
    input [31:0]prev_value;
    output reg [31:0]count;
   
    always@(posedge clk)
    begin 
   
    if(rst)
    count<=32'b0;
   
    else if (en)
    count <=prev_value;
    else 
    count<=count;   
   
    end 
    endmodule
    
    
    
    

