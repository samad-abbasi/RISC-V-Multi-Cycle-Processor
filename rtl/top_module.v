`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/17/2026 04:53:05 PM
// Design Name: 
// Module Name: top_module
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


module top_module(
 input clk,rst,
 output wire [31:0] pc,
 output wire [31:0] inst,
 output [4:0]rs1, rs2,rd
    );
    
wire [31:0]mux3_out;
wire [31:0]pc_out;
wire PCWrite_wire;



 pc_32bit p1 (.clk(clk), .rst(rst), .en(PCWrite_wire),.prev_value(mux3_out), .count(pc_out));
     // module pc_32bit( clk,rst,en,prev_value,count
 

   
     
   //module mux_2x1(
//    input [31:0] a, b,
//    input AdrSrc,
//    output reg [31:0] y
//); 
   
wire AdrSrc_wire;

wire [31:0]Adr_wire_out;     //mux2x1 m1 o/p   i/p: b comes on 1
mux_2x1 m1 (.a(pc_out),.b(mux3_out),.y(Adr_wire_out),.AdrSrc(AdrSrc_wire)); 


   // module Inst_DM(
//    input clk,
//    input [31:0] A,
//    input [31:0] WD,
//    input WE,
//    output reg [31:0] RD
//);
  
wire MemWrite_wire; 
wire [31:0]ReadData_out;  //RD output  
wire [31:0]WriteData_out;  //4 clk 2nd o/p
 
  Inst_DM DM1 (.clk(clk),.A(Adr_wire_out),.WD(WriteData_out),.WE(MemWrite_wire),.RD(ReadData_out)); 
  




//module Instr(
// input clk,
// input rst,
// input en,
// input [31:0]ReadData,
// output reg [31:0]Instr,
// input [31:0]PC,Instr_out[19:15]
// output reg [31:0] OldPc
 
//    );




wire IRWrite_wire;
wire [31:0]Instr_out;
wire [31:0]OldPC_out;

Instr Reg1 (.clk(clk),.rst(rst),.en(IRWrite_wire),.ReadData(ReadData_out),.Instr(Instr_out),
              .PC(pc_out),.OldPC(OldPC_out));


//module Data(
// input clk,
// input rst,
// input [31:0]ReadData,
// output reg [31:0]Data
//    );
wire [31:0] Data_out;
Data Reg2 (.clk(clk),.rst(rst),.ReadData(ReadData_out),.Data(Data_out));



//module REG_FILE(
// input [4:0] A1,
// input [4:0] A2,
// input [4:0] A3,
// input [31:0] WD3,
// output [31:0] RD1,
// output [31:0] RD2,
// input WE3,
// input clock,
// input reset
//    );
    
    
    
 
    wire RegWrite_wire; //CU to WE@ of REg File
    
    wire[31:0]RD1_wire;   //wire for RegFile data1
    wire[31:0]RD2_wire;    //wire for RegFile data2
   
   
    REG_FILE RF_1(.clock(clk), .reset(rst), 
                .A1(Instr_out[19:15]), .A2(Instr_out[24:20]), .A3(Instr_out[11:7]),
                .WD3(mux3_out),
                .RD1(RD1_wire), .RD2(RD2_wire), .WE3(RegWrite_wire));



    wire [1:0]ImmSrc_wire;
    wire [31:0] ImmExt_out;
    Imm_Gen  IG_1(.instruction(Instr_out), .immediate_output(ImmExt_out), .ImmSrc(ImmSrc_wire));


//module RF_Reg(
// input clk,
// input rst,

// input [31:0]RD1,
// output reg [31:0]A,
// input [31:0]RD2,
// output reg [31:0] WriteData
 
//    );
wire [31:0]Aout_wire;

RF_Reg Reg3 (.clk(clk),.rst(rst),.RD1(RD1_wire), .RD2(RD2_wire), .A(Aout_wire), .WriteData(WriteData_out));

wire [31:0]SrcA_wire;
wire [1:0]ALUSrcA_wire;
wire [1:0]ALUSrcB_wire;
wire[31:0]SrcB_wire;
 mux_3x1 m2 (.d0(pc_out),.d1(OldPC_out),.d2(Aout_wire),.s(ALUSrcA_wire),.out(SrcA_wire));
 mux_3x1 m3 (.d0(WriteData_out),.d1(ImmExt_out),.d2(32'd4),.s(ALUSrcB_wire),.out(SrcB_wire));

 
 
// module ALU(
// input [31:0] in1, in2,
// input [2:0] alu_control,
// output reg [31:0] result,
// output reg zero_flag);
 
 
  wire[2:0]ALUControl_wire;
  wire[31:0]ALUResult_out;   
  wire Zero_wire;  //alu to control unit zero
  ALU ALU_1 (.in1(SrcA_wire), .in2(SrcB_wire),.alu_control(ALUControl_wire), 
            .result(ALUResult_out),.zero_flag(Zero_wire));


//module ALU_Reg(
// input clk,
// input rst,
// input [31:0]ALUResult,
// output reg [31:0]ALUOut
//    );


wire [31:0]ALUOut_out;
ALU_Reg Reg4 (.clk(clk),.rst(rst),.ALUResult(ALUResult_out), .ALUOut(ALUOut_out));
wire [1:0]ResultSrc_wire;
mux_3x1 m4 (.d0(ALUOut_out),.d1(Data_out),.d2(ALUResult_out),.s(ResultSrc_wire),.out(mux3_out));

control_unit CU1(.clk(clk),.rst(rst),.op(Instr_out[6:0]),.funct3(Instr_out[14:12]),.funct7_5(Instr_out[30]),
                 .Zero(Zero_wire),.PCWrite(PCWrite_wire),.RegWrite(RegWrite_wire),
                 .ImmSrc(ImmSrc_wire),.ResultSrc(ResultSrc_wire),
                 .MemWrite(MemWrite_wire),.ALUControl(ALUControl_wire),
                 .ALUSrcA(ALUSrcA_wire),.ALUSrcB(ALUSrcB_wire),.AdrSrc(AdrSrc_wire), .IRWrite(IRWrite_wire)
                  );
//module control_unit(           //Top Level Module
//    input clk,rst,
//    input  [6:0] op,
//    input  [2:0] funct3,
//     input        Zero,
//    input        funct7_5,
   

     
//    output PCWrite,
//    output       RegWrite,
//    output       MemWrite,
//    output       IRWrite,  
//    output [1:0] ResultSrc,
//    output      [1:0] ALUSrcB,
//    output      [1:0] ALUSrcA,
//    output AdrSrc,
    
//    output [2:0] ALUControl,
    
//    output [1:0] ImmSrc

//);


assign pc   = pc_out;
assign inst = Instr_out;


assign rs1 = Instr_out[19:15];
assign rs2 = Instr_out[24:20];
assign rd = Instr_out[11:7];
endmodule






