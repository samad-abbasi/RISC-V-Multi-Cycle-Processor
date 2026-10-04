`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 12:15:06 PM
// Design Name: 
// Module Name: Inst_DM
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


/////////used mem//////////////////

module Inst_DM(
    input clk,
    input [31:0] A,
    input [31:0] WD,
    input WE,
    output reg [31:0] RD
);

    localparam DATA_BASE = 128;

    // Byte-addressable memory
    reg [7:0] Memory [1023:0];

    initial begin

      
       // R-type : Instruction 0 : addi addi x10, x11, 10
       Memory[0]  = 8'h13;
       Memory[1]  = 8'h85;
       Memory[2]  = 8'ha5;
       Memory[3]  = 8'h00;


       //R-type: Instruction 1 : sub x13, x14, x15
        Memory[4]  = 8'hb3;
        Memory[5]  = 8'h06;
        Memory[6]  = 8'hf7;
        Memory[7]  = 8'h40;

        // Load type: Instruction 2 : lw x19, 12(x20)
        Memory[8]  = 8'h83;
        Memory[9]  = 8'h29;
        Memory[10] = 8'hca;
        Memory[11] = 8'h00;

     // S-type: Instruction 3 (PC=16): sw x19, 16(x20)
        Memory[12] = 8'h23;
        Memory[13] = 8'h28;
        Memory[14] = 8'h3a;
        Memory[15] = 8'h01;

        // beq x10, x13, +12
        Memory[16] = 8'h63;
        Memory[17] = 8'h06;
        Memory[18] = 8'hd5;
        Memory[19] = 8'h00;

        // jal x2, -12
        Memory[20] = 8'h6f;
        Memory[21] = 8'hf1;
        Memory[22] = 8'h5f;
        Memory[23] = 8'hff;


      
        // DATA MEMORY (128+)
      
        // Data word at address 140
        // lw x19,12(x20) when x20=128

        Memory[140] = 8'h78;
        Memory[141] = 8'h56;
        Memory[142] = 8'h34;
        Memory[143] = 8'h12;

    end


 
    // WRITE (SW)

    always @(posedge clk)
    begin
        if (WE && (A >= DATA_BASE))
        begin
            Memory[A]     <= WD[7:0];
            Memory[A + 1] <= WD[15:8];
            Memory[A + 2] <= WD[23:16];
            Memory[A + 3] <= WD[31:24];
        end
        
    end



    // READ (Instruction Fetch + LW)

    always @(*)
    begin
        RD = {Memory[A+3],
              Memory[A+2],
              Memory[A+1],
              Memory[A]};
    end

endmodule