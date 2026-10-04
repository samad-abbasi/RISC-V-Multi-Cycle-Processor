`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/17/2026 02:54:06 PM
// Design Name: 
// Module Name: tb_Imm_Gen
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
module tb_Imm_Gen();
reg  [31:0] instruction;
wire [31:0] immediate_output;
// Instantiate DUT
Imm_Gen uut (
    .instruction(instruction),
    .immediate_output(immediate_output)
);

initial begin
    $monitor("Time=%0t | Instr=%h | Imm=%d (@x%h)",
            $time, instruction, immediate_output, immediate_output);

    // ===================================
    // Test 1: LOAD (I-type)
    // imm = 0x005 (5)
    // ===================================
    instruction = 32'b000000000101_00000_000_00000_0000011;
    #10;

    // ===================================
    // Test 2: LOAD (Negative)
    // imm = -1
    // ===================================
    instruction = 32'b111111111111_00000_000_00000_0000011;
    #10;

    // ==========================    // imm = 0=========
    // Test 3: STORE (S-type)
    // imm = 0
    // ===================================
    instruction = 32'b0000000_10100_00000_000_00000_0100011;
    #10;

   // ===================================
    // Test 4: STORE (Negative)
     // imm = -32
    // ===================================
    instruction = 32'b1111111_00001_00000_000_00000_0100011;
    #10;

    // ===================================
    // Test 5: BRANCH (Positive)
        // imm = +20
    // ===================================
    instruction = 32'b0000000_00000_00000_000_01010_1100011;
    #10;
        // ===================================
    // Test 6: BRANCH (Negative)
    // imm = -4
    // ===================================
    instruction = 32'b1111111_00000_00000_000_11101_1100011;
    #10;

    $finish;
end
endmodule
