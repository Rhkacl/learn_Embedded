`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2025 11:34:02 AM
// Design Name: 
// Module Name: coder
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


module decoder_2x4_behavioral(
    input [1:0] code,
    output reg [3:0] signal
    );

    // always @(code) begin
    //     if(code == 2'b00) signal = 4'b0001;
    //     else if(code == 2'b01) signal = 4'b0010;
    //     else if(code == 2'b10) signal = 4'b0100;
    //     else signal = 4'b1000;
    // end

    // if문도 가능 case문도 가능 -> case문이 좀더 괜찮은 방법임 
    always @(code) begin
        case (code)
            2'b00 : signal = 4'b0001;
            2'b01 : signal = 4'b0010;
            2'b10 : signal = 4'b0100;
            2'b11 : signal = 4'b1000;
        endcase
    end

endmodule


module decoder_2x4_dataflow (
    input [1:0] code,
    output [3:0] signal
    );

    assign signal = (code == 2'b00) ? 4'b0001:
                    (code == 2'b01) ? 4'b0010:
                    (code == 2'b10) ? 4'b0100: 4'b1000;
    
endmodule


module decoder_2x4_dataflow_d (
    input [1:0] code,
    output [3:0] signal
    );

    assign signal[0] = (~code[1]) & (~code[0]);
    assign signal[1] = (~code[1]) & ( code[0]);
    assign signal[2] = ( code[1]) & (~code[0]);
    assign signal[3] = ( code[1]) & ( code[0]);
    
endmodule


module tb_decoder_structural (
    input [1:0] code,
    output [3:0] signal
    );

    wire n0, n1;    // NOT 신호

    not u_not0 (n0, code[0]);
    not u_not1 (n1, code[1]);

    and u_and0 (signal[0], n1, n0);
    and u_and1 (signal[1], n1, code[0]);
    and u_and2 (signal[2], code[1], n0);
    and u_and3 (signal[3], code[1], code[0]);
    
endmodule


module decoder_7seg (
    input [3:0] hex_value,
    output reg [6:0] seg_7
    //output reg [3:0] com_an
    );

    //com_an = 4'b0000;   // 0이 켜짐
    always @(hex_value) begin 
        case (hex_value)
                               //dgfedcba
            4'b0000 : seg_7 = 8'b11000000; //0
            4'b0001 : seg_7 = 8'b11111001; //1
            4'b0010 : seg_7 = 8'b10100100; //2
            4'b0011 : seg_7 = 8'b10110000; //3
            4'b0100 : seg_7 = 8'b10011001; //4
            4'b0101 : seg_7 = 8'b10010010; //5
            4'b0110 : seg_7 = 8'b10000010; //6
            4'b0111 : seg_7 = 8'b11111000; //7
            4'b1000 : seg_7 = 8'b10000000; //8
            4'b1001 : seg_7 = 8'b10011000; //9
            4'b1010 : seg_7 = 8'b10001000; //A
            4'b1011 : seg_7 = 8'b10000011; //b
            4'b1100 : seg_7 = 8'b11000110; //C
            4'b1101 : seg_7 = 8'b10100001; //D
            4'b1110 : seg_7 = 8'b10000110; //E
            4'b1111 : seg_7 = 8'b10001110; //F 
        endcase
    end
endmodule


module encoder_4x2_behavioral (
    output reg [1:0] code,  // 2bit output : 입력중에 켜진 위치를 이진수로 출력
    input [3:0] signal      // 4bit input  : 4개의 신호중에 하나가 1이라고 가정  
    );

    // always @(signal) begin  // signal에 변화가 있을때 마다 동작 
    //     // signal -> 0001 일 때 -> 0번째 입력이 켜진 것
    //     if(signal == 4'b0001)
    //         code = 2'b00;       // 출력 code = 0
    //     else if(signal == 4'b0010)
    //         code = 2'b01;
    //     else if(signal == 4'b0100)
    //         code = 2'b10;
    //     else 
    //         code = 2'b11;
    // end

    always @(signal) begin
        case (signal)
            4'b0001 : code = 2'b00;
            4'b0010 : code = 2'b01;
            4'b0100 : code = 2'b10;
            4'b1000 : code = 2'b11;
            default : code = 2'b00;
        endcase
    end
    
endmodule


module encoder_4x2_dataflow (
    output [1:0] code,
    input [3:0] signal
    );

    assign code = (signal == 4'b0001) ? 2'b00:
                  (signal == 4'b0010) ? 2'b01:
                  (signal == 4'b0100) ? 2'b10:
                  (signal == 4'b1000) ? 2'b11: 2'b00;
endmodule


module encoder_4x2_structural (
    output [1:0] code,
    input  [3:0] signal 
    );

    wire a0, a1;

    // code[1] = signal[2] OR signal[3]
    // 입력값이 0100 또는 1000 일 경우 code[1]은 1
    or or1(a1, signal[2], signal[3]);

    // code[0] = signal[1] OR signal[3]
    // 입력값이 0010 또는 1000 일 경우 code[0]은 1
    or or0(a0, signal[1], signal[3]); 

    assign code = {a1, a0}; // code[1]의 상위비트, code[0]의 하위비트 
    
endmodule