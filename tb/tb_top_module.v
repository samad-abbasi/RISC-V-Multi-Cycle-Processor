`timescale 1ns / 1ps

module top_module_tb();

    reg clk;
    reg rst;
    wire [31:0] pc;
    wire [31:0] inst;
    wire [4:0]rs1, rs2,rd;
    top_module uut (
        .clk(clk),
        .rst(rst),
        .pc(pc),
        .inst(inst), .rs1(rs1),.rs2(rs2),.rd(rd)
    );


    always #5 clk = ~clk;


    initial begin
        clk = 0;
        rst = 1;
        #25;
        rst = 0;
        #500;
        $finish;
    end

    // print every cycle
    always @(posedge clk) begin
        if (!rst) begin
            $display("PC=%0d  INST=0x%h  STATE=%0d", pc, inst, uut.CU1.instan1.state);
        end
    end

endmodule