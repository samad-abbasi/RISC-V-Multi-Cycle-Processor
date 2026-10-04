`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2026 06:10:58 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
input [31:0] in1, in2,
input [2:0] alu_control,
output reg [31:0] result,
output reg zero_flag);




    always@(*) begin 
    result = 32'b0;  
    zero_flag = 1'b0; 
        case(alu_control)
            3'b000: result = in1 + in2; 
            3'b001: result = in1 - in2; 
            3'b010: result = in1 & in2; 
            3'b011: result = in1 | in2; 
           
            3'b011: begin
                if(in1 == in2) begin
                    zero_flag = 1'b1;
                    result = 32'd0;
                end
                else begin
                    zero_flag = 1'b0;
                    result = 32'd1;
                end
           end
           
           
            default: begin
                result = 32'b0;
                zero_flag =1'b0;
            end
        endcase
    end


endmodule
