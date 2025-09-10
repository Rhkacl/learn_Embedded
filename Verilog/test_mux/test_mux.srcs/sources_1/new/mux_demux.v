`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2025 03:44:12 PM
// Design Name: 
// Module Name: mux_demux
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


// Multiplexer (MUX)
// 다수의 입력중에서 선택신호(select signal)에 따라서 하나의 출력 선택
// 2:1, 4:1, 8:1

// dataflow
module mux_2_1(
    input [1:0] d,  // 입력 신호 2개 (d[0], d[1])
    input s,
    output f
    );

    assign f = s ? d[1] : d[0]; // s = 0이면 d[0], s = 1이면 d[1] 출력 
endmodule


// behavioral
module mux_2_1_behavioral (
    input [1:0] d,
    input s,
    output reg f
    );

    always @(d or s) begin
        if (s == 1'b1) begin
            f = d[1];
        end else begin
        f = d[0];
        end
    end
    
endmodule


// structural
module mux_2_1_structural (
    input [1:0] d,
    input s,
    output f
    );

    wire s_n;           // s의 NOT을 저장할 내부 와이어
    wire and_out_0;     // 첫번째 AND 게이트 출력
    wire and_out_1;     // 두번째 AND 게이트 출력

    not (s_n, s);       // NOT 게이트 s를 반전 시켜서 저장

    and (and_out_0, d[0], s_n);
    and (and_out_1, d[1], s);

    or  (f, and_out_0, and_out_1);
    
endmodule


// dataflow
module mux_4_1 (
    input [3:0] d,
    input [1:0] s,  // select signal 2bit(00, 01, 10, 11)
    output f
    );
    
    assign f = d[s];    // s가 가리키는 d배열 원소 출력
endmodule


// behavioral
module mux_4_1_behavioral (
    input [3:0] d,
    input [1:0] s,
    output reg f
    );

    always @(d or s) begin
        case (s)
            2'b00 : f = d[0];
            2'b01 : f = d[1];
            2'b10 : f = d[2];
            2'b11 : f = d[3];
            default: f = 1'bx;   // 정의되지 않은 값 처리(옵션 : 있어도 되고 없어도 됨)
        endcase
    end
    
endmodule


// dataflow
module mux_8_1 (
    input [7:0] d,
    input [2:0] s,
    output f
    );

    assign f = d[s];
    
endmodule


// structural
// module mux_4_1_structural (
//     input [3:0] d,
//     input [1:0] s,
//     output f
//     );

//     wire mux_out_0;     // 첫번째 mux 출력(2_1)
//     wire mux_out_1;     // 두번째 mux 출력(2_1)

//     mux_2_1_structual m0(
//         .d({d[0], d[1]}),
//         .s(s[0]),
//         .f(mux_out_0)
//     );

//     mux_2_1_structual m1(
//         .d({d[2], d[3]}),
//         .s(s[1]),
//         .f(mux_out_1)
//     );

//     mux_2_1_structual m2(
//         .d0(mux_out_0),
//         .d1(mux_out_1),
//         .s(s[1]),
//         .f(f)
//     );
    
// endmodule


// test
module mux_4_1_structural (
    input [3:0] d,
    input [1:0] s,
    output f
    );

    wire mux_out_0;     // 1st 1 of 2 MUX Output
    wire mux_out_1;     // 2nd 1 of 2 MUX Output

    mux_2_1_structural m0 (.d({d[0], d[1]}), .s(s[0]), .f(mux_out_0));
    mux_2_1_structural m1 (.d({d[3], d[2]}), .s(s[0]), .f(mux_out_1));
    mux_2_1_structural m2 (.d({mux_out_0, mux_out_1}), .s(s[1]), .f(f));
endmodule


///////////////////////////////////////////////////////////////////////////

// module demux_1_to_2 (
//     input in,
//     input s,
//     output [1:0] out
//     );

//     always @(*) begin
//         case (s)
//             1'b0 : out = {1'b0, in};    // out[1] = 0,  out[0] = in
//             1'b1 : out = {in, 1'b0};    // out[1] = in, out[0] = 0
//             default :
//         endcase
//     end
    
// endmodule


module demux_1_4_d (
    input d,
    input [1:0] s,
    output [3:0] f
    );
    // 선택 신호 s에 따라서 d를 4개중에 한위치 전달하고 나머지 0 
    assign f = (s == 2'b00) ? {3'b000, d}:      // s = 00 -> f = 000d (f[0] = d)
               (s == 2'b01) ? {2'b00, d, 1'b0}: // s = 01 -> f = 00d0 (f[1] = d)
               (s == 2'b10) ? {1'b0, d, 2'b00}: // s = 10 -> f = 0d00 (f[2] = d)
                              {d, 3'b000};      // s = 11 -> f = d000 (f[3] = d)
    
endmodule


module mux_demux_test (
    input [3:0] d,          // mux 입력 4개 
    input [1:0] mux_s,      // mux 신호
    input [1:0] demux_s,    // demux 신호
    output [3:0] f          // demux 출력
    );

    wire mux_f; // mux 출력과 demux 입력 연결

    mux_4_1 mux4(
        .d(d),
        .s(mux_s),
        .f(mux_f)
    );

    demux_1_4_d demux4(
        .d(mux_f),
        .s(demux_s),
        .f(f)
    );
    
endmodule