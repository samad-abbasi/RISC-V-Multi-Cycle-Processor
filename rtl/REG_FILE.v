`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2026 04:57:49 PM
// Design Name: 
// Module Name: REG_FILE
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


module REG_FILE(
 input [4:0] A1,
 input [4:0] A2,
 input [4:0] A3,
 input [31:0] WD3,
 output [31:0] RD1,
 output [31:0] RD2,
 input WE3,
 input clock,
 input reset
    );
    
    reg [31:0] reg_memory [31:0];
    integer i; 
 always@(posedge clock or posedge reset) begin
    if(reset) begin
       for (i=0;i<32; i=i+1) begin
          reg_memory[i]<=i;
       end
       end
    else if (WE3 && (A3!=0)) begin
    reg_memory[A3]<=WD3;
     end
     end
  
   assign RD1 = (A1 == 0) ? 32'b0 : reg_memory[A1];
   assign RD2 = (A2 == 0) ? 32'b0 : reg_memory[A2];
            

endmodule
