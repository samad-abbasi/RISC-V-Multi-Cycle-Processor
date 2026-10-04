`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2026 02:33:30 PM
// Design Name: 
// Module Name: tb_pc_32bit
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


module tb_pc_32bit(

    );
   reg CLK,RST;
   wire [31:0]COUNT;
   pc_32bit uut (.clk(CLK),.rst(RST), .count(COUNT));



always #5 CLK = ~CLK;

initial begin
$monitor("Time = 0%t | CLK =%b | RST = %b | COUNT = %b", $time , CLK, RST, COUNT);
CLK =1'b0;
RST =1'b1;
#10;

RST=1'b0;
#200;

 $finish;
end

endmodule
