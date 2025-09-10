`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2025 02:34:43 PM
// Design Name: 
// Module Name: filp_flop
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





// 플립플롭(filp-flop) 
// 클럭신호에 동기화 -> 상태가 변경 -> edge trigger
// 타이밍제어가 정확
// 용도 : 동기식 레지스터, FSM상태 저장, 파이프라인 레지스터, 카운터 등
// D플립플롭, T플립플롭, JK플립플롭
// 안전성 높음

// 래치(Latch) -> 기억소자
// 클럭대신에 제어신호에 의해서 동작 (비동기적 -> level trigger)
// 타이밍제어가 힘듦 (비동기) -> 간단한 제어 
// SR래치, D래치
// 안전성 낮음

// vivado에서 권장은 플립플롭, 래치는 특수한 경우에만 사용

/////////////////////////////////////////////////////////////////

// D Flip-Flop
// 입력된 데이터(D)를 클럭신호(clk)의 엣지(edge)에 맞춰 클럭(Q)에 전달 : 동기식
// 시간   clk   D   Q
// t0     0    1   0
// t1    1(R)  1   1 <- 상승엣지에서 D=1이니까 Q = 1
// t2     0    0   1 <- 엣지가 없음 Q 유지 
// t3    1(R)  0   0 <- 상승엣지에서 D=0이니까 Q = 0
 
module D_filp_flop_Basic(
    input clk,      // 클럭 입력
    input d,        // 데이터 입력
    output reg q    // 출력
    );

    always @(posedge clk) begin     // 상승엣지 일때
        q <= d;     // q에 d를 저장 
    end
endmodule


module D_flip_flop_n (
    input d,
    input clk,
    input reset_p,   // 비동기식 reset 신호(상승엣지에서 작동)
    input enable,   // 1일 때만 데이터 입력 허용
    output reg q
    );

    always @(negedge clk or posedge reset_p) begin  
        // 비동기 신호인 reset_p가 1이 되면 즉시 q를 0으로 
        if(reset_p)
            q <= 0;
        else if (enable)    // enable이 1일때만 d를 q로 저장, enable이 0일때는 q를 이전값으로 유지
            q <= d;        
    end
    
endmodule


module D_filp_flop_p (
    input d,
    input clk,
    input reset_p,
    input enable,
    output reg q
    );

    always @(posedge clk or posedge reset_p) begin
        if (reset_p)
            q <= 0;
        else if (enable)
            q <= d; 
    end
    
endmodule


module T_flip_flop_n (
    input clk,
    input reset_p,
    input t,
    output reg q
    );

    always @(negedge clk or posedge reset_p) begin
        if(reset_p) begin
            q <= 1'b0;  // non-blocking 할당 (blocking q = 0 => q = 1b0)
        end else begin
            if(t == 1'b1) begin
                q <= ~q;
            end else begin
                q <= q;
            end
        end
    end
endmodule


module T_flip_flop_p (
    input clk,
    input reset_p,
    input t,
    output reg q
    );

    always @(posedge clk or posedge reset_p) begin
        if(reset_p) q = 0;
        else begin
            if(t) q = ~q;
            else q = q;
        end
    end
    
endmodule


// 비동기 up counter
// T filp flop 4개 직렬로 연결
// 가장 오른쪽 비트부터 차례로 다음단계 클럭으로 사용
// reset_p -> 1 되면 q 출력을 0으로
module up_counter_asyc (
    input clk,      // 외부클럭
    input reset_p,  // 비동기 리셋
    output [3:0] count
    );

    T_flip_flop_n T0(
        .clk(clk),
        .reset_p(reset_p),
        .t(1'b1),           // always toggle
        .q(count[0])
    );

    T_flip_flop_n T1(
        .clk(count[0]),
        .reset_p(reset_p),
        .t(1'b1),
        .q(count[1])
    );

    T_flip_flop_n T2(
        .clk(count[1]),
        .reset_p(reset_p),
        .t(1'b1),
        .q(count[2])
    );

    T_flip_flop_n T3(
        .clk(count[2]),
        .reset_p(reset_p),
        .t(1'b1),
        .q(count[3])
    );
    
endmodule


// down counter
module down_counter_asyc (
    input clk,
    input reset_p,
    output [3:0] count
    );

    T_flip_flop_p T0(
        .clk(clk),
        .reset_p(reset_p),
        .t(1'b1),
        .q(count[0])
    );

    T_flip_flop_p T1(
        .clk(count[0]),
        .reset_p(reset_p),
        .t(1'b1),
        .q(count[1])
    );
    
    T_flip_flop_p T2(
        .clk(count[1]),
        .reset_p(reset_p),
        .t(1'b1),
        .q(count[2])
    );    

    T_flip_flop_p T3(
        .clk(count[2]),
        .reset_p(reset_p),
        .t(1'b1),
        .q(count[3])
    );    
endmodule

//////////////////////////////////////////

module up_counter_p (
    input clk,
    input reset_p,
    input enable,       // 카운터 동작을 제어
    output reg [3:0] count
    );

    always @(posedge clk or posedge reset_p) begin
        if (reset_p)
            count = 0;
        else if (enable)
            count <= count + 1; // enable이 1 때만 count 증가
    end
    
endmodule


module up_counter_n (
    input clk,
    input reset_p,
    input enable,       // 카운터 동작을 제어
    output reg [3:0] count
    );

    always @(negedge clk or posedge reset_p) begin
        if (reset_p)
            count = 0;
        else if (enable)
            count <= count + 1; // enable이 1 때만 count 증가
    end
    
endmodule


module down_counter_p (
    input clk,
    input reset_p,
    input enable,       // 카운터 동작을 제어
    output reg [3:0] count
    );

    always @(posedge clk or posedge reset_p) begin
        if (reset_p)
            count = 0;
        else if (enable)
            count <= count - 1; // enable이 1 때만 count 감소
    end
    
endmodule


module test_top (
    input clk,
    input btnU, // reset upcounter
    input btnD, // enable
    output [3:0] led
    );

    wire [3:0] up_count;

    up_counter_p U1(
        .clk(clk),
        .reset_p(btnU),
        .enable(btnD),
        .count(led)
    );

    assign led = up_count;
    
endmodule


module edge_detector_n (
    input clk,      // 클럭
    input reset_p,  // reset  
    input cp,       // 입력신호 감지
    output p_edge,  // 라이징 감지 출력
    output n_edge   // 폴링 감지 출력
    );

    reg ff_cur, ff_old;     // 현재 cp 값과 이전 cp값을 저장할 플립플롭

    always @(negedge clk or posedge reset_p) begin
        if (reset_p) begin  // 리셋시 플립플롭 초기화
            ff_cur <= 0;
            ff_old <= 0;
        end
        else begin          // 이전값 저장하고 현재값 갱신
            ff_old <= ff_cur;
            ff_cur <= cp;
        end
    end

    // 라이징 감지 -> 이전 0, 현재 1이면 2'b10
    assign p_edge = ({ff_cur, ff_old} == 2'b10) ? 1 : 0;
    // 폴링 감지 -> 이전 1, 현재 0이면 2'b01
    assign n_edge = ({ff_cur, ff_old} == 2'b01) ? 1 : 0;
    
endmodule


module edge_detector_p (
    input clk,      // 클럭
    input reset_p,  // reset  
    input cp,       // 입력신호 감지
    output p_edge,  // 라이징 감지 출력
    output n_edge   // 폴링 감지 출력
    );

    reg ff_cur, ff_old;     // 현재 cp 값과 이전 cp값을 저장할 플립플롭

    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin  // 리셋시 플립플롭 초기화
            ff_cur <= 1'b0;
            ff_old <= 1'b0;
        end
        else begin          // 이전값 저장하고 현재값 갱신
            ff_old <= ff_cur;
            ff_cur <= cp;
        end
    end

    // 라이징 감지 -> 이전 0, 현재 1이면 2'b10
    assign p_edge = ({ff_cur, ff_old} == 2'b10) ? 1'b1 : 1'b0;
    // 폴링 감지 -> 이전 1, 현재 0이면 2'b01
    assign n_edge = ({ff_cur, ff_old} == 2'b01) ? 1'b1 : 1'b0;
    
endmodule



// system clock -> 100MHz
// 100 분주
module clock_div_100 (
    input clk,          // system clock 100MHz
    input reset_p,
    output clk_div_100, // 1MHz pulse 출력 
    output cp_div_100
    );

    reg [6:0] cnt_sysclk;

    always @(negedge clk or posedge reset_p) begin
        if (reset_p)
            cnt_sysclk <= 1;
        else begin
            if (cnt_sysclk >= 99)
                cnt_sysclk <= 0;
            else
                cnt_sysclk <= cnt_sysclk + 1;
        end
    end

    assign cp_div_100 = (cnt_sysclk < 50) ? 0 : 1;

    edge_detector_n ed(
        .clk(clk),
        .reset_p(reset_p),
        .cp(cp_div_100),
        .n_edge(clk_div_100)
        );
    
endmodule

// 1000분주 
module clock_div_1000 (
    input clk,              // 1MHz -> 1KHz
    input reset_p,
    output clock_div_1000
    );

    reg [9:0] count;    // 10bit 0 ~ 999
    reg pulse;

    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin
            count <= 0;
            pulse <= 0;
        end
        else begin
            if (count == 999) begin
                count <= 0;
                pulse <= 1;
            end
            else begin
                count <= count + 1;
                pulse <= 0;
            end
        end
    end

    assign clock_div_1000 = pulse;

endmodule


module clock_div_1hz_top (
    input clk,
    input reset_p,
    output clk_1hz
    );

    wire clk_1mhz;      // 100MHz -> 1MHz
    wire clk_1khz;      // 1MHz -> 1KHz

    // 1단 분주 : 100분주 (100MHz -> 1MHz)
    clock_div_100 U1(
        .clk(clk),
        .reset_p(reset_p),
        .clk_div_100(clk_1mhz),
        .cp_div_100()           // 사용안함 
    );

    // 2단 분주 : 1000분주 (1MHz -> 1KHz)
    clock_div_1000 U2(
        .clk(clk_1mhz),
        .reset_p(reset_p),
        .clock_div_1000(clk_1khz)
    );

    // 3단 분주 : 1000분주 (1KHz -> 1Hz)
    clock_div_1000 U3(
        .clk(clk_1khz),
        .reset_p(reset_p),
        .clock_div_1000(clk_1hz)
    );

endmodule


module led_top (
    input clk,
    input btnU,
    output reg led
    );

    wire clk_1hz;

    clock_div_1hz_top div_instance(
        .clk(clk),
        .reset_p(reset_p),
        .clk_1hz(clk_1hz)
    );

    always @(posedge clk_1hz or posedge btnU) begin
        if (btnU)
            led <= 0;
        else
            led <= ~led;
    end
    
endmodule


///////////////////////////////////////////////////////
// ring_counter
// 1개의 비트가정해진 순서대로 한비트씩 이동 순환 
///////////////////////////////////////////////////////

// ring_counter BASIC
module ring_counter (
    input clk,
    input reset_p,
    output reg [3:0] q
    );

    always @(posedge clk or posedge reset_p) begin
        if(reset_p) begin
            q <= 4'b0001;   // 초기값 설정             
        end
        else begin
            case (q)
                4'b0001 : q <= 4'b0010;
                4'b0010 : q <= 4'b0100;
                4'b0100 : q <= 4'b1000;
                4'b1000 : q <= 4'b0001; // 문제 생기면 다시 초기값으로 
            endcase 
        end
    end
    
endmodule


module ring_counter_shift (
    input clk,
    input reset_p,
    output reg [3:0] q
    );

    always @(posedge clk or posedge reset_p) begin
        if(reset_p) begin
            q <= 4'b0001;
        end
        else begin
            if(q == 4'b1000)
                q <= 4'b0001;
            else if(q == 4'b0000 || q > 4'b1000)
                q <= 4'b0001;
            else
                q <= {q[2:0], 1'b0}; // 상위 3bit, 하위 1bit 
        end
    end
    
endmodule


module ring_counter_p (
    input clk,
    input reset_p,
    output reg [3:0] q
);

    always @(posedge clk or posedge reset_p) begin
        if(reset_p) q <= 4'b0001;
        else q = {q[2:0], q[3]};
    end
endmodule 


module ring_counter_fnd (
    input clk,
    input reset_p,
    output reg [3:0] q
    );
    
    reg [3:0] clk_div = 0;     // 17bit -> 10만 이상 
    // clock 분주
    always @(posedge clk) begin
        clk_div <= clk_div + 1;
    end

    wire clk_div_16_p;

    edge_detector_n ed(
        .clk(clk),
        .reset_p(reset_p),
        .cp(clk_div[16]),
        .p_edge(clk_div_16_p)
    );

    always @(negedge clk or posedge reset_p) begin
        if(reset_p) begin
            q <= 4'b1110;
        end
        else if(clk_div_16_p) begin
            if(q == 4'b0111)
                q <= 4'b1110;
            else
                q <= {q[2:0], 1'b1};     
        end
    end

endmodule

module ring_counter_led (
    input clk,
    input reset_p,
    output reg [15:0] led
    );

    reg [20:0] clk_div = 0;

    always @(posedge clk) begin
        clk_div = clk_div + 1;
    end

    wire clk_div_20_p;

    edge_detector_p ed(
        .clk(clk),
        .reset_p(reset_p),
        .cp(clk_div[20]),
        .n_edge(clk_div_20_p)
    );

    always @(posedge clk or posedge reset_p) begin
        if(reset_p) 
            led = 16'b0000000000000001;
        else if(clk_div_20_p)
            led = {led[14:0], led[15]};
    end
    
endmodule