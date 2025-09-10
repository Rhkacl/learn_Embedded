`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2025 11:41:30 AM
// Design Name: 
// Module Name: tb_decoder
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


module tb_decoder;

    reg [1:0] code;
    wire [3:0] signal;

    // 모듈 이름만 바꿔서 test 가능 
    decoder_2x4_behavioral d_b(
        .code(code),
        .signal(signal)
    );

    initial begin
        $display("Time\tcode\tbehavioral");
        $monitor("%0t\t%b\t%4b", $time, code, signal);

        code = 2'b00; #10;
        code = 2'b01; #10;
        code = 2'b10; #10;
        code = 2'b11; #10;

        $finish;
    end
endmodule


module tb_encoder_4x2_behavioral;

    reg [3:0] signal;   // 임의대로 주는 입력 신호
    wire [1:0] code;    // 인코더 출력 

    encoder_4x2_behavioral uut(
        .signal(signal),
        .code(code)
    );

    initial begin
        signal = 4'b0000;   // 초기화 

        #10 signal = 4'b0001;
        #10 signal = 4'b0010;
        #10 signal = 4'b0100;
        #10 signal = 4'b1000;

        #10 signal = 4'b0000;
        #10 signal = 4'b0011;

        #10 $finish;
    end

    initial begin
        $monitor("time = %dns, signal = %b, code = %b", $time, signal, code);
    end
    
endmodule