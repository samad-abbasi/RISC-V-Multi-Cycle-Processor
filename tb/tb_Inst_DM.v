`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 12:23:14 PM
// Design Name: 
// Module Name: tb_Inst_DM
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


`timescale 1ns / 1ps

module tb_Inst_DM();

reg clk;
reg [31:0] A;
reg [31:0] WD;
reg WE;
wire [31:0] RD;

Inst_DM uut (
    .clk(clk),
    .A(A),
    .WD(WD),
    .WE(WE),
    .RD(RD)
);

always #5 clk = ~clk; 
initial begin
    clk = 0; #10;
 end

initial begin

  
    A  = 0;
    WD = 0;
    WE = 0;
   
    #10;

   
    A = 0;
    #10;
    $display("PC=%0d Instruction=%h", A, RD);


    A = 4;
    #10;
    $display("PC=%0d Instruction=%h", A, RD);

 
    A = 8;
    #10;
    $display("PC=%0d Instruction=%h", A, RD);

   
    A = 12;
    #10;
    $display("PC=%0d Instruction=%h", A, RD);

 
    A = 16;
    #10;
    $display("PC=%0d Instruction=%h", A, RD);


    A = 20;
    #10;
    $display("PC=%0d Instruction=%h", A, RD);

  
    // Read Data at address 140
    // Expected: 12345678
   
    A = 140;
    #10;
    $display("Address=%0d Data=%h", A, RD);

 
    // Store DEADBEEF at address 144
  
    A  = 144;
    WD = 32'hDEADBEEF;
    WE = 1;

    #10;      
    WE = 0;

    // Read back
    #10;
    $display("Address=%0d Data=%h (After Store)", A, RD);

    
    // Verify instructions not corrupted
  
    A = 0;
    #10;
    $display("Instruction0 after store = %h", RD);

    #20;
    $finish;

end

endmodule
