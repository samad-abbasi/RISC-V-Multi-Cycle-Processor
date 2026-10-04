`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2026 03:01:44 PM
// Design Name: 
// Module Name: INST_MEM
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

module INST_MEM(
 input [31:0] PC,
 output [31:0] Instruction_Code
    );
    reg [7:0] Memory [31:0]; //Byte -addressable
    
    initial begin
            // R-type : Instruction 0 : add x10, x11, x12
            Memory[0] = 8'h33;
            Memory[1] = 8'h85;
            Memory[2] = 8'hc5;
            Memory[3] = 8'h00;
    
            //R-type: Instruction 1 : sub x13, x14, x15
            Memory[4] = 8'hb3;
            Memory[5] = 8'h06;
            Memory[6] = 8'hf7;
            Memory[7] = 8'h40;
    
//            // Instruction 2 : add x16, x17, x18
//            Memory[8] = 8'h33;
//            Memory[9] = 8'h88;
//            Memory[10] = 8'h28;
//            Memory[11] = 8'h01;
    
            // Load type: Instruction 2 : lw x19, 12(x20)
            Memory[8] = 8'h83;
            Memory[9] = 8'h29;
            Memory[10] = 8'hca;
            Memory[11] = 8'h00;
    
            // S-type: Instruction 3 (PC=16): sw x19, 16(x20)
            Memory[12] = 8'h23;
            Memory[13] = 8'h28;
            Memory[14] = 8'h3a;
            Memory[15] = 8'h01;
    
            // B-type: Instruction 4 : beq x10, x13, offset +12

            Memory[16] = 8'h63;
            Memory[17] = 8'h06;
            Memory[18] = 8'hd5;
            Memory[19] = 8'h00;
    
//         
//            Memory[24] = 8'h33;
//            Memory[25] = 8'h00;
//            Memory[26] = 8'h00;
//            Memory[27] = 8'h00;
    
            // Instruction 5 : jal x2, offset -12
           
            Memory[20] = 8'h6f;
            Memory[21] = 8'hf1;
            Memory[22] = 8'h5f;
            Memory[23] = 8'hff;
    end
    assign Instruction_Code = {Memory[PC+3],Memory[PC+2],Memory[PC+1],Memory[PC]};
  
endmodule

