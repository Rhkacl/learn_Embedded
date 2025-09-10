`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2025 02:18:17 PM
// Design Name: 
// Module Name: Adder
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


// Half Adder Behavioral
// 두개의 1비트를 입력 (a, b)
// 합(s), 자리올림(c) 출력하는 반가산기
module half_adder_behavioral (
    input a,        // 1bit 입력 a
    input b,        // 1bit 입력 b
    output reg s,   // 합(sum)을 저장할 레지스터 타입의 출력
    output reg c    // 자리올림(carry)을 저장할 레지스터 타입의 출력
    );

    // a 또는 b의 변화가 생길때 마다 always블록 실행 
    always @(a, b) begin
        case ({a, b})
            2'b00 : begin   // a = 0, b = 0 -> sum = 0, carry = 0
                s = 0;
                c = 0;
            end
            2'b01 : begin   // a = 0, b = 1 -> sum = 1, carry = 0
                s = 1;
                c = 0;
            end
            2'b10 : begin   // a = 1, b = 0 -> sum = 1, carry = 0
                s = 1;
                c = 0;
            end
            2'b11 : begin   // a = 1, b = 1 -> sum = 1, carry = 1
                s = 1;
                c = 1;
            end            
        endcase
    end
endmodule


module half_adder_structual (
    input a, b,
    output s, c
    );

    and (c, a, b);
    xor (s, a, b);
endmodule


module half_adder_dataflow (
    input a, b,
    output s, c
    );

    // a와 b의 합을 저장할 2bit wire
    // 최대값은 1 + 1 = 2 (2'b10)이므로 2bit 필요 
    wire [1:0]  sum_value;

    // verilog에서 '+'연산자는 벡터를 생성해서 결과를 sum_value에 저장
    // ex) a = 1, b = 1 -> sum_value = 2'b10 
    assign sum_value = a + b;

    // sum_value의 최하위비트(LSB)인 sum_value[0]를 s에 할당
    // 결과값은 XOR 연산결과와 같음 
    assign s = sum_value[0];    // sum

    // sum_value의 상위비트(MSB)인 sum_value[1]를 c에 할당
    // 결과값은 AND 연산결과와 같음 (둘다 1인 경우에만 carry 발생)
    assign c = sum_value[1];    // carry
endmodule


// N bit half_adder
module half_adder_N_bit # (parameter N = 8)(    // N의 기본값 8bit
    input inc,                  // 더할 값
    input [N-1:0] load_data,    // 입력 데이터 (N비트)
    output [N-1:0] sum          // 출력 합계 결과 (N비트)
    );
    
    wire [N-1:0] carry_out;     // 각 자리의 carry 출력을 저장할 배열

    half_adder_dataflow ha0(    // 첫번째 bit(LSB)는 inc와 load_data[0]을 half_adder로 연산
        .a(inc),
        .b(load_data),
        .s(sum[0]),
        .c(carry_out[0])
    );

    genvar i;   // generate문을 위한 변수 선언 
    generate
        for(i = 1;i < N;i = i + 1) begin : hagen    // Labe를 "hagen"으로 블록 지정
            half_adder_dataflow ha(
                .a(carry_out[i - 1]),   // 이전 자리의 carry 입력
                .b(load_data[i]),       // 현재 자리의 입력 bit 
                .s(sum[i]),             // 현재 자리의 합 출력
                .c(carry_out[i])        // 다음 자리로 전달될 carry 출력
            );
            
        end
    endgenerate
endmodule


module full_adder_structural (
    input a, b, cin,    // 입력 bit 3개(이전자리에서 올라온 자리올림 cin)
    output sum, carry   // 출력
    );

    wire sum_0;     // 첫번째 반가산기의 sum
    wire carry_0;   // 첫번째 반가산기의 carry
    wire carry_1;   // 두번째 반가산기의 carry

    // 첫번째 반가산기 : 입력 a, b 더함
    // 결과로 sum_0에 중간합이 저장, carry_0에 자리올림
    half_adder_structual ha0(
        .a(a),
        .b(b),
        .s(sum_0),
        .c(carry_0)
    );

    // 두번째 반가산기 : sum_0하고 cin을 더함
    // 최종합(sum)은 여기서 나옴, carry_1은 중간 자리올림
    half_adder_structual ha1(
        .a(sum_0),
        .b(cin),
        .s(sum),
        .c(carry_1)
    );

    // 최종 자리올림은 두자리올림의 OR연산 (carry_0, carry_1)
    or (carry, carry_0, carry_1);
    
endmodule


// 전가산기 (Behavioral)
module full_adder_behavioral (
    input a, b, cin,
    output reg sum, carry
    );

    always @(a, b, cin) begin
        // 입력 3bit를 하나의 값으로 묶어서 case 처리
        case ({a, b, cin})
            3'b000 : begin sum = 0; carry = 0; end  // 0+0+0 = sum = 0, carry = 0
            3'b001 : begin sum = 1; carry = 0; end  // 0+0+1 = sum = 1, carry = 0
            3'b010 : begin sum = 1; carry = 0; end  // 0+1+0 = sum = 1, carry = 0
            3'b011 : begin sum = 0; carry = 1; end  // 0+1+1 = sum = 0, carry = 1
            3'b100 : begin sum = 1; carry = 0; end  // 1+0+0 = sum = 1, carry = 0
            3'b101 : begin sum = 0; carry = 1; end  // 1+0+1 = sum = 0, carry = 1
            3'b110 : begin sum = 0; carry = 1; end  // 1+1+0 = sum = 0, carry = 1
            3'b111 : begin sum = 1; carry = 1; end  // 1+1+1 = sum = 1, carry = 1

        endcase
    end
endmodule


module full_adder_dataflow (
    input a, b, cin,
    output sum, carry
    );

    wire [1:0] sum_value;   // 2bit wire -> 덧셈결과 (하위bit : sum, 상위bit : carry)

    assign sum_value = a + b + cin;

    assign sum = sum_value[0];
    assign carry = sum_value[1];    
endmodule

module fadder_4bit_structural (
    input [3:0] a, b,   // 4bit input
    input cin,          // first carry input
    output [3:0] sum,   // result 4bit
    output carry        // final carry (MSB)
    );

    wire [2:0] carry_w; // 내부 전가산기 캐리 연결용

    full_adder_structural fa0(
        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .sum(sum[0]),
        .carry(carry_w[0])
    );
    // 두번째 비트 : 이전 자리 캐리(carry_w[0])를 cin으로 사용
    full_adder_structural fa1(
        .a(a[1]),
        .b(b[1]),
        .cin(carry_w[0]),
        .sum(sum[1]),
        .carry(carry_w[1])
    );
    // 세번째
    full_adder_structural fa2(
        .a(a[2]),
        .b(b[2]),
        .cin(carry_w[1]),
        .sum(sum[2]),
        .carry(carry_w[2])
    );
    // 네번째
    full_adder_structural fa3(
        .a(a[3]),
        .b(b[3]),
        .cin(carry_w[2]),
        .sum(sum[3]),
        .carry(carry)
    );

endmodule


module fadder_sub_4bit_structural (
    input [3:0] a, b,   // 4bit input
    input s,            // select signal (0 : add, 1 : sub)
    output [3:0] sum,   // 4bit result
    output carry        // final carry (carrt or borrow)
    );

    wire [2:0] carry_w; // 각 자리에서 발생하는 중간 carry
    wire [3:0] b_w;     // b 입력값과 s 신호를 xor한 결과(b의 보수 처리용)

    // b의 각 bit와 s를 xor 
    // s가 0이면 b_w는 b와 같음(덧셈모드)
    // s가 1이면 b_w는 b의 각 비트가 반전됨(뺄셈모드, 2의 보수 연산 준비)
    xor (b_w[0], b[0], s);
    xor (b_w[1], b[1], s);
    xor (b_w[2], b[2], s);
    xor (b_w[3], b[3], s);

    // 4개의 전 가산기로 4bit 덧셈/뺄셈
    // 첫번째 가산기에는 s를 초기 carry 입력(cin)으로 사용
    // s = 0 이면 덧셈 (cin = 0)
    // s = 1 이면 뺄셈 (cin = 1), 2의 보수로 연산 
    full_adder_structural fa0(.a(a[0]), .b(b_w[0]), .cin(s),          .sum(sum[0]), .carry(carry_w[0]));
    full_adder_structural fa1(.a(a[1]), .b(b_w[1]), .cin(carry_w[0]), .sum(sum[1]), .carry(carry_w[1]));
    full_adder_structural fa2(.a(a[2]), .b(b_w[2]), .cin(carry_w[1]), .sum(sum[2]), .carry(carry_w[2]));
    full_adder_structural fa3(.a(a[3]), .b(b_w[3]), .cin(carry_w[2]), .sum(sum[3]), .carry(carry));
    
endmodule



module fadder_sub_4bit_dataflow (
    input [3:0] a, b,
    input s,
    output [3:0] sum,
    output carry
    );

    wire [4:0] sum_value;   // 5bit wire : 덧셈/뺄셈 결과 (4bit + carry bit)

    assign sum_value = s ? a - b : a + b;   // s = 0이면 a + b, s = 1이면 a - b
    assign sum = sum_value[3:0];

    assign carry = s ? ~sum_value[4] : sum_value[4];
    
endmodule


module fadder_sub_4bit_behavioral (
    input [3:0] a, b,
    input s,
    output reg [3:0] sum,
    output reg carry
    );

    reg [4:0] temp; // 5bit 임시 변수

    always @(*) begin   // 모든게 변하면 
        if (s == 0) 
            temp = a + b;
        else 
            temp = a - b;

        sum = temp[3:0];
        carry = s ? ~temp[4] : temp[4];
    end
    
endmodule