`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2025 11:48:04 AM
// Design Name: 
// Module Name: bcd
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


module bin_to_dec(
    input [11:0] bin,       // 12bit 이진 입력 
    output reg [15:0] bcd     // 4자리의 BCD를 출력(4bit x 4자리 = 16bit)     
    );

    integer i;  // while문

    always @(bin) begin
        bcd = 0;    // initial value

        for (i = 0;i < 12;i = i + 1) begin
            // 알고리즘 각 단위비트 자리별로 5이상이면 +3해줌 
            if (bcd[3:0] >= 5)  bcd[3:0]  =  bcd[3:0] + 3;
            if (bcd[7:4] >= 5)  bcd[7:4]  =  bcd[7:4] + 3;
            if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
            if (bcd[15:12] >= 5) bcd[15:12] = bcd[15:12] + 3;

            // 2) 1bit left shift + add new bit
            bcd = {bcd[14:0], bin[11 - i]};
        end
    end
endmodule
