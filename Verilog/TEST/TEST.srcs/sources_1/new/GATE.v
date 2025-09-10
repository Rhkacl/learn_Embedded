`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2025 10:28:24 AM
// Design Name: 
// Module Name: GATE
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


module and_gate(
    input a, b,
    output reg q
    );

    always @(a, b) begin
        case ({a, b})  
            2'b00 : q = 0;
            2'b01 : q = 0;
            2'b10 : q = 0;
            2'b11 : q = 1; 
        endcase
    end
endmodule


// always 블록과 case문, if문을 이용한 회로동작
module and_gate_behavioral (
    input a, b,
    output reg q
    );

    always @(a or b) begin  // a, b 둘중 하나라도 값이 변경되면 블록 실행 
        if(a == 1'b1 && b == 1'b1)  // a, b가 1이면 
            q = 1'b1;   // q에 1저장
        else
            q = 1'b0;   // q에 0저장
    end
endmodule


// 실제 게이트(AND)를 이용한 회로 구조 기술
// 하드웨어의 구성요소를 직접 인스턴스화 함 
module and_gate_structual (
    input a, b,
    output q    // reg가 아닌 wire 타입임
    );

    and U1(q, a, b);    // AND 게이트 인스턴스 생성    
endmodule


// assign문 출력과 입력간의 논리를 기술
// 데이터의 흐름 중심 
module and_gate_dataflow (
    input a, b,
    output q
    );

    assign q = a & b;
endmodule


// 동작적 : 동작을 코드로 표현 -> 복잡한 로직 처리에 유리
// 구조적 : 게이트를 연결해서 회로 구조를 표현 -> 실제 회로 구조를 이해하는데 적합
// 데이터플로우 : 출력 = 입력 서술 -> 간단한 조합논리 회로에 적합 



// OR Gate
module or_gate (
    input a, b,
    output reg q
    );

    always @(a, b) begin
        case ({a, b})
            2'b00 : q = 0;
            2'b01 : q = 1; 
            2'b10 : q = 1;
            2'b11 : q = 1;
        endcase 
    end
endmodule


module or_gate_behavioral (
    input a, b,
    output reg q
    );

    always @(a or b) begin
        if(a == 1'b1 || b == 1'b1)
            q = 1'b1;
        else
            q = 1'b0;
    end
endmodule


module or_gate_structual (
    input a, b,
    output q
    );

    or U1(q, a, b);
endmodule


module or_gate_dataflow (
    input a, b,
    output q
    );

    assign q = a | b;
endmodule


module nand_gate (
    input a, b,
    output reg q
    );

    always @(a, b) begin
        case ({a, b})
            2'b00 : q = 1;
            2'b01 : q = 1;
            2'b10 : q = 1;
            2'b11 : q = 0;
        endcase
    end
endmodule


module nand_gate_behavioral (
    input a, b,
    output reg q
    );

    always @(a or b) begin  // (a, b)와 (a or b)는 같다
        if(a == 1'b1 && b == 1'b1)
            q = 1'b0;
        else   
            q = 1'b1;
    end
endmodule


module nand_gate_structual (
    input a, b,
    output q
    );

    nand U1(q, a, b);   // verilog 기본내장 nand gate 사용 
endmodule


module nand_gate_dataflow (
    input a, b,
    output q
    );

    assign q = ~(a & b);
endmodule


module nor_gate (
    input a, b,
    output reg q
    );

    always @(a, b) begin
        case ({a, b})
            2'b00 : q = 1;
            2'b01 : q = 0;
            2'b10 : q = 0;
            2'b11 : q = 0;
        endcase
    end
endmodule


module nor_gate_behavioral (
    input a, b,
    output reg q
    );

    always @(a or b) begin
        if(a == 1'b0 && b == 1'b0)
            q = 1'b1;
        else
            q = 1'b0;
    end
endmodule


module nor_gate_structual (
    input a, b,
    output q
    );

    nor U1(q, a, b);
endmodule


module nor_gate_dataflow (
    input a, b,
    output q
    );

    assign q = ~(a | b);
endmodule


module xor_gate (
    input a, b,
    output reg q
    );

    always @(a, b) begin
        case ({a, b})
            2'b00 : q = 0;
            2'b01 : q = 1;
            2'b10 : q = 1;
            2'b11 : q = 0;
        endcase
    end
endmodule


module xor_gate_behavioral (
    input a, b,
    output reg q
    );

    always @(a or b) begin
        if(a != b)
            q = 1'b1;
        else
            q = 1'b0;
    end
endmodule


module xor_gate_structual (
    input a, b,
    output q
    );
    
    xor U1(q, a, b);
endmodule


module xor_gate_dataflow (
    input a, b,
    output q
    );

    assign q = a ^ b;
    
endmodule


module xnor_gate (
    input a, b,
    output reg q
    );

    always @(a, b) begin
        case ({a, b})
            2'b00 : q = 1;
            2'b01 : q = 0;
            2'b10 : q = 0;
            2'b11 : q = 1;
        endcase
    end
endmodule


module xnor_gate_behavioral (
    input a, b,
    output reg q
    );

    always @(a or b) begin
        if(a != b)
            q = 1'b0;
        else
            q = 1'b1;
    end
endmodule


module xnor_gate_structual (
    input a, b,
    output q
    );

    xnor U1(q, a, b);
endmodule


module xnor_gate_dataflow (
    input a, b,
    output q
    );

    assign q = ~(a ^ b);
endmodule


module gates (
    input a, b,
    output q0, q1, q2, q3, q4, q5, q6
    );

    assign q0 = ~a;         // NOT
    assign q1 = a & b;      // AND
    assign q2 = a | b;      // OR
    assign q3 = ~(a & b);   // NAND
    assign q4 = ~(a | b);   // NOR
    assign q5 = a ^ b;      // XOR
    assign q6 = ~(a ^ b);   // NXOR
    
endmodule