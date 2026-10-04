`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/18/2026 03:01:39 PM
// Design Name: 
// Module Name: mux_2x1
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


module mux_2x1(
    input [31:0] a, b,
    input AdrSrc,
    output reg [31:0] y
);

always @(*)
begin
    if (AdrSrc)
        y = b;
    else
        y = a;
end
endmodule


module mux_3x1 (
    input  [1:0]  s,
    input  [31:0] d0,
    input  [31:0] d1,
    input  [31:0] d2,
    output reg [31:0] out
);

always @(*) begin
    case (s)
        2'b00: out = d0;
        2'b01: out = d1;
        2'b10: out = d2;
       default: out = d2;
    endcase
end

endmodule
