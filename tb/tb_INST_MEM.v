`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2026 03:21:49 PM
// Design Name: 
// Module Name: tb_INST_MEM
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


module tb_INST_MEM(

    );
    reg [31:0] PC;
    wire [31:0] Instruction_Code;
    
    INST_MEM dut (.PC(PC), .Instruction_Code(Instruction_Code));
    
    initial begin
    //$display("Time\tPC\t\tInstruction_Code");
    $monitor("%0t\t%h\t%h" , $time , PC, Instruction_Code);
    end
    
    initial begin
    PC = 32'd4 ; #20;
    PC = 32'd8 ; #20;
    PC = 32'd12 ; #20;
    PC = 32'd16 ; #20;
    PC = 32'd20 ; #20;
    PC = 32'd24 ; #20;
    PC = 32'd28 ; #20;
   // PC = 32'd32 ; #20;
    
    
    
    
    end
    
    
endmodule
