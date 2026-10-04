`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2026 05:43:43 PM
// Design Name: 
// Module Name: tb_REG_FILE
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


module tb_REG_FILE(

    );
 reg [4:0] read_reg_num1;
 reg [4:0] read_reg_num2;
 reg [4:0] write_reg;
 reg [31:0] write_data;
 wire [31:0] read_data1;
 wire [31:0] read_data2;
 reg regwrite;    //control write en
 reg clock;
 reg reset;
 
 REG_FILE dut (.clock(clock),.reset(reset),.read_reg_num1(read_reg_num1),.read_reg_num2(read_reg_num2),
               .write_reg(write_reg),.write_data(write_data),.read_data1(read_data1),.read_data2(read_data2));
               
             
always #5 clock = ~clock;


initial begin 
clock = 0;
reset = 1;
regwrite = 0;
read_reg_num1 = 0;
read_reg_num2 = 0;
write_reg = 0;
write_data = 0;


#10 ; reset = 0;
 
 
 //write value 10 to reg x5
#10 regwrite = 1;
write_reg = 5;
write_data = 10;

#10 regwrite = 0;

//read x5 
read_reg_num1 = 5;

#10 regwrite = 0;

write_reg = 5;
#10 regwrite = 0;



#10 regwrite = 1;
write_reg = 6;
write_data = 32'hfefabebe;
#10 regwrite = 0;

//read x5 
read_reg_num1 = 5;

#10 regwrite = 1;
write_reg = 0;
write_data = 99;
#10 regwrite = 0;





end 

endmodule

