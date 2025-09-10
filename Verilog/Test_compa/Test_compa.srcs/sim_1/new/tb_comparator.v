`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2025 10:20:37 AM
// Design Name: 
// Module Name: tb_comparator
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


module tb_comparator;

    reg a, b;
    wire equal, greator, less;

    // 비교기 모듈 인스턴스(원하는 모듈 땡겨쓰기)
    comparator_dataflow uut(
        .a(a),
        .b(b),
        .equal(equal),
        .greator(greator),
        .less(less)
    );

    initial begin
        $display("Time\t a b | equal greator less");
        $monitor("%0t\t %b %b | %b %b %b", $time, a, b, equal, greator, less);

        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        $finish;
    end
endmodule


module tb_comparator_4bit_full;
    
    reg [3:0] a, b;
    wire equal, greator, less;

    // DUT
    comparator_Nbit #(.N(4)) dut(
        .a(a),
        .b(b),
        .equal(equal),
        .greator(greator),
        .less(less)
    );

    integer i, j;

    initial begin
        $display("Time\t a\t b\t |\tequal\tgreator\tless");
        $monitor("%4t\t %b\t %b\t | \t%b\t%b\t%b", $time, a, b, equal, greator, less);

        // 모든 조합 테스트 (a -> 0 ~ 15, b -> 0 ~ 15)
        for (i = 0;i < 16;i = i + 1) begin
            for(j = 0; j < 16;j = j + 1) begin
                a = i;
                b = j;
                #5;
            end
        end
        $finish;
    end
endmodule
