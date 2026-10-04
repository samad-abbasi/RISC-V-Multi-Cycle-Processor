`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/18/2026 04:19:55 PM
// Design Name: 
// Module Name: control_unit
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

module control_unit(           //Top Level Module
    input clk,rst,
    input  [6:0] op,
    input  [2:0] funct3,
     input        Zero,
    input        funct7_5,
   

     
    output PCWrite,
    output       RegWrite,
    output       MemWrite,
    output       IRWrite,  
    output [1:0] ResultSrc,
    output      [1:0] ALUSrcB,
    output      [1:0] ALUSrcA,
    output AdrSrc,
    
    output [2:0] ALUControl,
    
    output [1:0] ImmSrc

);

    wire [1:0] ALUOp;
    wire       Branch;
    wire       PCUpdate; 

    assign PCWrite  = PCUpdate || (Branch && Zero);

    fsm instan1 (
    .clk(clk),.rst(rst),.op(op),
     .RegWrite(RegWrite),
          .MemWrite(MemWrite),
          .IRWrite(IRWrite),
          .ResultSrc(ResultSrc),
    .ALUSrcB(ALUSrcB),
    .ALUSrcA(ALUSrcA),
     .AdrSrc(AdrSrc),
       .ALUOp(ALUOp),
      .PCUpdate(PCUpdate),
        .Branch(Branch)
    );

    alu_decoder instan2 (
        .ALUOp(ALUOp),
        .funct3(funct3),
        .op_5(op[5]),
        .funct7_5(funct7_5),
        .ALUControl(ALUControl)
    );
    
    extender_decoder instan3(.op(op),
            .ImmSrc(ImmSrc));

endmodule



///Main Decoder//////////////////
module fsm(
input clk,rst,
input [6:0] op,

output reg RegWrite, MemWrite, IRWrite, PCUpdate, Branch, AdrSrc,

output reg [1:0] ResultSrc,
output reg  [1:0] ALUSrcB,
output  reg     [1:0] ALUSrcA,
 output reg [1:0] ALUOp
);

    parameter Fetch    = 4'd0;
    parameter Decode   = 4'd1;
    parameter MemAdr   = 4'd2;
    parameter MemRead  = 4'd3;
    parameter MemWB    = 4'd4;
    parameter MemWRITE = 4'd5;
    parameter ExecuteR = 4'd6;
    parameter ALUWB    = 4'd7;
    parameter ExecuteI = 4'd8;
    parameter JAL      = 4'd9;
    parameter BEQ      = 4'd10;

    reg [3:0] state, next_state;


    always @(posedge clk) begin
        if (rst) state <= Fetch;
        else     state <= next_state;
    end


    always @(*) begin
        case(state)
            Fetch:  next_state = Decode;
            Decode: begin
                case(op)
                    7'b0000011: next_state = MemAdr;   
                    7'b0100011: next_state = MemAdr;   
                    7'b0110011: next_state = ExecuteR; 
                    7'b0010011: next_state = ExecuteI;
                    7'b1101111: next_state = JAL;   
                    7'b1100011: next_state = BEQ;      
                    default:    next_state = Fetch;
                endcase
            end
            MemAdr: begin
                if (op == 7'b0000011) next_state = MemRead; 
                else                  next_state = MemWRITE; 
            end
            MemRead:  next_state = MemWB;
            MemWB:    next_state = Fetch;
            MemWRITE: next_state = Fetch;
            ExecuteR: next_state = ALUWB;
            ExecuteI: next_state = ALUWB;
            ALUWB:    next_state = Fetch;
            JAL:      next_state = ALUWB;
            BEQ:      next_state = Fetch;
            default:  next_state = Fetch;
        endcase
    end

    // Output Logic (Combinational)
    always @(*) begin
    
        PCUpdate=0; Branch=0; RegWrite=0; MemWrite=0; IRWrite=0; AdrSrc=0;
        ResultSrc=2'b00; ALUSrcA=2'b00; ALUSrcB=2'b00; ALUOp=2'b00;

        case(state)
            Fetch: begin
                AdrSrc    = 1'b0;
                IRWrite   = 1'b1;
                ALUSrcA   = 2'b00; // PC
                ALUSrcB   = 2'b10; 
                ALUOp     = 2'b00; // Add
                ResultSrc = 2'b10; // ALUResult
                PCUpdate  = 1'b1;
            end
            Decode: begin
                ALUSrcA   = 2'b01; // OldPC
                ALUSrcB   = 2'b01; 
                ALUOp     = 2'b00; // Add (Calculates Branch Target)
            end
            MemAdr: begin
                ALUSrcA   = 2'b10; // A (rs1)
                ALUSrcB   = 2'b01; 
                ALUOp     = 2'b00; // Add
            end
            MemRead: begin
                ResultSrc = 2'b00; // ALUOut
                AdrSrc    = 1'b1;  // Result wire
            end
            MemWB: begin
                ResultSrc = 2'b01; // Data from Memory
                RegWrite  = 1'b1;
            end
            MemWRITE: begin
                ResultSrc = 2'b00; // ALUOut
                AdrSrc    = 1'b1;  // Result wire
                MemWrite  = 1'b1;
            end
            ExecuteR: begin
                ALUSrcA   = 2'b10; // A (rs1)
                ALUSrcB   = 2'b00; // B (rs2)
                ALUOp     = 2'b10; // Use funct3/7
            end
            ExecuteI: begin
                ALUSrcA   = 2'b10; // A (rs1)
                ALUSrcB   = 2'b01; 
                ALUOp     = 2'b10; // Use funct3/7
            end
            ALUWB: begin
                ResultSrc = 2'b00; // ALUOut
                RegWrite  = 1'b1;
            end
            JAL: begin
                ALUSrcA   = 2'b01; // OldPC
                ALUSrcB   = 2'b10; 
                ALUOp     = 2'b00; // Add (Calculates OldPC + 4 to save to Reg)
                ResultSrc = 2'b00; // ALUOut (Routes branch target to PC)
                PCUpdate  = 1'b1;
            end
            BEQ: begin
                ALUSrcA   = 2'b10; // A (rs1)
                ALUSrcB   = 2'b00; // B (rs2)
                ALUOp     = 2'b01; // Sub (For comparison)
                ResultSrc = 2'b00; // ALUOut (Routes branch target to PC if Zero=1)
                Branch    = 1'b1;
            end
        endcase
    end
endmodule



////AlU Decoder

module alu_decoder(
    input      [1:0] ALUOp,
    input      [2:0] funct3,
    input            op_5,
    input            funct7_5,
    output reg [2:0] ALUControl
);
    always @(*) begin
        case (ALUOp)
            2'b00: ALUControl = 3'b000; 
            2'b01: ALUControl = 3'b001; 
            2'b10: begin 
                case (funct3)
                    3'b000: begin
                        if (op_5 & funct7_5) 
                            ALUControl = 3'b001; 
                        else                 
                            ALUControl = 3'b000; 
                    end
                    3'b010: ALUControl = 3'b101; 
                    3'b110: ALUControl = 3'b011; 
                    3'b111: ALUControl = 3'b010; 
                    default: ALUControl = 3'b000; 
                endcase
            end
            default: ALUControl = 3'b000;
        endcase
    end
endmodule




//Extender Decoder
module extender_decoder(
    input  [6:0] op,
    output reg [1:0] ImmSrc
);
    always @(*) begin
        case(op)
            7'b0100011: ImmSrc = 2'b01; // sw
            7'b1100011: ImmSrc = 2'b10; // beq
            7'b1101111: ImmSrc = 2'b11; // jal
            default:    ImmSrc = 2'b00; // lw, R-type, I-type
        endcase
    end
endmodule

