`timescale 1ns / 1ps

/*
*   button1 (btn_start_stop)
*   button2 (btn_reset)
*   0.1초 단위로 증가 (10Hz) -> 실제 초와 같은 속도로 맞추기 위해 카운터에서 1Hz 사용  
*   MM : SS 형식에서 HH:MM <-> SS:MS(밀리초) 토글 형식으로 변경
*/


module clock_divider_1Hz(
    input clk,
    input reset_p,
    output reg clk_1Hz
    );

    reg [26:0] count;   // 자릿수가 약 6천만 

    always @(posedge clk or posedge reset_p) begin
        if(reset_p) begin
            count <= 0;
            clk_1Hz <= 0;
        end else begin
            if(count == 27'd49999999) begin
                count <= 0;
                clk_1Hz <= ~clk_1Hz;
            end else begin
                count <= count + 1;
            end
        end
    end
endmodule


module clock_divider_10Hz(
    input clk,
    output reset_p,
    output reg clk_10Hz
    );

    reg [23:0] count;   // 100000000 / (10Hz * 2) = 5000000 -> 2^23 정도 

    always @(posedge clk or posedge reset_p) begin
        if(reset_p) begin
            count <= 0;
            clk_10Hz <= 0;
        end else begin
            if(count == 24'd4999999) begin
                count <= 0;
                clk_10Hz <= ~clk_10Hz;      
            end else begin
                count <= count + 1;
            end
        end
    end
endmodule


module clock_divider_100Hz (
    input clk,
    input reset_p,
    output reg clk_100Hz
    );

    reg [19:0] count;

    always @(posedge clk or posedge reset_p) begin
        if(reset_p) begin
            count <= 0;
            clk_100Hz <= 0;
        end else begin
            if(count == 20'd499999) begin
                count <= 0;
                clk_100Hz = ~clk_100Hz;
            end else begin
                count <= count + 1;
            end
        end
    end
    
endmodule


// 밀리초 카운터 
module millisec_counter (
    input clk_100Hz,
    input reset_p,
    input enable,   // running 상태일 때만 동작
    output reg [3:0] ms_ones,
    output reg [3:0] ms_tens,
    output reg ms_overflow  // 밀리초가 99 -> 00 될 때 1클럭만 HIGH 
    );

    always @(posedge clk_100Hz or posedge reset_p) begin
        if(reset_p) begin
            ms_ones <= 0;
            ms_tens <= 0;
            ms_overflow <= 0;
        end else if(enable) begin
            if(ms_ones == 9) begin
                ms_ones <= 0;
                if(ms_tens == 9) begin
                    ms_tens <= 0;
                    ms_overflow <= 1;
                end else begin
                    ms_tens <= ms_tens + 1;
                    ms_overflow <= 0;
                end
            end else begin
                ms_ones <= ms_ones + 1;
                ms_overflow <= 0;
            end
        end else begin
            ms_overflow <= 0;
        end
    end
    
endmodule

 
module stopwatch_counter (
    input clk_sec_tick,          // ms_overflow 입력 
    input reset_p,
    input btn_start_stop,
    input btn_reset,
    output reg [3:0] sec_ones,   // sec 1의 자리
    output reg [3:0] sec_tens,   // sec 10의 자리
    output reg [3:0] min_ones,   // min 1의 자리
    output reg [3:0] min_tens,   // min 10의 자리
    output reg [3:0] hour_ones,  // hour 1의 자리 
    output reg [3:0] hour_tens   // hour 10의 자리 
    ); 

    parameter IDEL    = 2'b00;  // 대기
    parameter RUNNING = 2'b01;  // 동작
    parameter PAUSED  = 2'b10;  // 일시정지

    reg [1:0] current_state, next_state;

    always @(posedge clk_sec_tick or posedge reset_p) begin
        if(reset_p) begin
            current_state <= IDEL;          // 리셋시 IDEL로
        end else begin
            current_state <= next_state;    // 다음 상태로
        end
    end

    always @(*) begin
        case (current_state)
            IDEL : begin
                // 대기에서 start 누르면 running
                next_state = btn_start_stop ? RUNNING : IDEL;
            end 
            RUNNING : begin
                // 동작에서 버튼 누르면 일시정지 
                next_state = btn_start_stop ? PAUSED : RUNNING;
            end
            PAUSED : begin
                // 일시정지에서 reset 누르면 IDEL
                // 아니면 start 누르면 running
                if(btn_reset)
                    next_state = IDEL;
                else if(btn_start_stop)
                    next_state = RUNNING;
                else
                    next_state = PAUSED;
            end
            default : next_state = IDEL; 
        endcase
    end

    always @(posedge clk_sec_tick or posedge reset_p) begin
        if(reset_p || current_state == IDEL) begin
            // reset 누르거나 paused 상태면 모두 0으로
            sec_ones <= 0; sec_tens <= 0;
            min_ones <= 0; min_tens <= 0;
            hour_ones <= 0; hour_tens <= 0;
        end
        else if (current_state == RUNNING) begin
            // 동작일때만 시간 증가
            // -- sec 증가 --
            if (sec_ones == 9) begin
                sec_ones <= 0;
                if (sec_tens == 5) begin
                    sec_tens <= 0;
                    // -- min 증가 --
                    if (min_ones == 9) begin
                        min_ones <= 0;
                        if (min_tens == 5) begin
                            min_tens <= 0;
                            // -- hour 증가 --
                            if(hour_tens == 2 && hour_ones == 3) begin
                                hour_tens <= 0;
                                hour_ones <= 0;
                            end else if(hour_ones == 9) begin
                                hour_ones <= 0;
                                hour_tens <= hour_tens + 1;
                            end else begin
                                hour_ones <= hour_ones + 1;
                            end
                        end else begin
                            min_tens <= min_tens + 1;
                        end
                    end else begin
                        min_ones <= min_ones + 1;
                    end
                end else begin
                    sec_tens <= sec_tens + 1;
                end
            end else begin
                sec_ones <= sec_ones + 1;
            end
        end
    end
endmodule


module display_mode (
    input clk_10Hz,
    input reset_p,
    output reg display_mode
    );

    reg [4:0] count;    // 5bit (0 ~ 19)

    always @(posedge clk_10Hz or posedge reset_p) begin
        if(reset_p) begin
            count <= 0;
            display_mode <= 0;
        end else if(count == 5'd19) begin
            count <= 0;
            display_mode <= ~display_mode;  // 2초마다 toggle
        end else begin
            count <= count + 1; 
        end
    end
    
endmodule


module debounce (
    input clk,
    input btn_in,
    output reg btn_out
    );

    reg [15:0] count;
    reg btn_sync_0, btn_sync_1;
    wire stable = (count == 16'hFFFF);

    // 동기화 
    always @(posedge clk) begin
        btn_sync_0 <= btn_in;
        btn_sync_1 <= btn_sync_0;
    end

    // 카운터 기반으로 디바운스 
    always @(posedge clk) begin
        if(btn_sync_1 == btn_out) begin
            count <= 0;
        end else begin
            count <= count + 1;
            if(stable) begin
               btn_out <= btn_sync_1; 
            end 
        end
    end
    
endmodule


// 나머지 모듈 재사용
// clock_divider_2KHz
// display_scan_controller
// seg_decoder
// anode_selector


// 100MHz 입력받아 2KHz 생성
// 이 클럭을 이용해서 7세그먼트 디스플레이 자리를 스캔
module clock_divider_2KHz (
    input clk,
    input reset_p,
    output reg clk_2KHz
    );

    reg [15:0] count;
    
    always @(posedge clk or posedge reset_p) begin
        if(reset_p) begin
            count <= 0;
            clk_2KHz <= 0;
        end
        else begin
            if(count == 24999) begin
                count <= 0;
                clk_2KHz <= ~clk_2KHz;
            end
            else begin
                count <= count + 1;
            end
        end
    end
    
endmodule


// 2KHz를 이용해서 어떤자리 표시 할지 ?
// 해당자리에 맞는 시간(select_digit)을 선택 
module display_scan_controller (
    input scan_clk,
    input reset_p,
    input [3:0] ms_ones,
    input [3:0] ms_tens,
    input [3:0] sec_ones,
    input [3:0] sec_tens,
    input [3:0] min_ones,
    input [3:0] min_tens,
    input [3:0] hour_ones,
    input [3:0] hour_tens,
    input display_mode,
    output reg [1:0] scan_count,
    output reg [3:0] select_digit
    );

    always @(posedge scan_clk or posedge reset_p) begin
       if(reset_p) begin
            scan_count <= 0;
       end 
       else begin
            scan_count <= scan_count + 1;
       end
    end

    // mode에 따라 자릿수 선택
    always @(*) begin
        if(display_mode == 0) begin
            // HH:MM
            case (scan_count)
                2'd0 : select_digit = min_ones;
                2'd1 : select_digit = min_tens;
                2'd2 : select_digit = hour_ones;
                2'd3 : select_digit = hour_ones; 
                default : select_digit = 4'd15;     // blank 
            endcase
        end else begin
            // SS:MS(밀리초) 
            case (scan_count)
                2'd0 : select_digit = ms_ones;
                2'd1 : select_digit = ms_tens;
                2'd2 : select_digit = sec_ones;
                2'd3 : select_digit = sec_tens; 
                default : select_digit = 4'd15;     // blank  
            endcase
        end
    end


endmodule


// BCD Quick Access
// digit_in을 받아서 7세그먼트 디스플레이에 표시하기 위한 패턴 
module seg_decoder (
    input [3:0] digit_in,
    output reg [7:0] seg_out
    );

    always @(*) begin
        case (digit_in)
            4'd0 : seg_out = 8'b11000000;     // 0 (dp 꺼짐)
            4'd1 : seg_out = 8'b11111001;   // 1
            4'd2 : seg_out = 8'b10100100;   // 2
            4'd3 : seg_out = 8'b10110000;   // 3
            4'd4 : seg_out = 8'b10011001;   // 4
            4'd5 : seg_out = 8'b10010010;   // 5
            4'd6 : seg_out = 8'b10000010;   // 6
            4'd7 : seg_out = 8'b11111000;   // 7
            4'd8 : seg_out = 8'b10000000;   // 8
            4'd9 : seg_out = 8'b10011000;   // 9
            default : seg_out = 8'b11111111;         
        endcase
    end
    
endmodule


// 자릿수 선택
// display_scan_controller에서 넘어온 현재 스캔중인 자리 인덱스(scan_count)를 기반으로 4자리 선택
module anode_selector (
    input [1:0] scan_count,
    output reg [3:0] an_out
    );

    always @(*) begin
        case (scan_count)
            2'd0 : an_out = 4'b1110; // an[0]
            2'd1 : an_out = 4'b1101; // an[1]
            2'd2 : an_out = 4'b1011; // an[2]
            2'd3 : an_out = 4'b0111; // an[3]
            default : an_out = 4'b1111; 
        endcase
    end
    
endmodule


module stopwatch_top (
    input clk,
    input reset_p,
    input btn_start_stop,
    input btn_reset,
    output [7:0] seg,
    output [3:0] an
    );

    // 내부 연결 wire
    wire clk_10Hz;
    wire clk_1Hz, clk_100Hz;
    wire [3:0] ms_ones, ms_tens, sec_ones, sec_tens, min_ones, min_tens, hour_ones, hour_tens;
    wire [1:0] scan_count;
    wire [3:0] select_digit;
    wire display_mode;

    wire start_stop_clean, reset_clean;

    // clock
    clock_divider_1Hz hu1(
        .clk(clk),
        .reset_p(reset_p),
        .clk_1Hz(clk_1Hz)
    );

    clock_divider_10Hz hu10(
        .clk(clk),
        .reset_p(reset_p),
        .clk_10Hz(clk_10Hz)
    );

    clock_divider_100Hz hu100(
        .clk(clk),
        .reset_p(reset_p),
        .clk_100Hz(clk_100Hz)
    );

    wire scan_clk;
    clock_divider_2KHz hu2k(
        .clk(clk),
        .reset_p(reset_p),
        .clk_2KHz(scan_clk)
    );

    // display 상태 표시(2초마다 토글) 
    display_mode mu1(
        .clk_10Hz(clk_10Hz),
        .reset_p(reset_p),
        .display_mode(display_mode)
    ); 

    // debounce
    debounce du1(
        .clk(clk),
        .btn_in(btn_start_stop),
        .btn_out(start_stop_clean)
    );

    debounce du2(
        .clk(clk),
        .btn_in(btn_reset),
        .btn_out(reset_clean)
    );

    // main stopwatch
    stopwatch_counter u2(
        .clk_sec_tick(ms_overflow),
        .reset_p(reset_p),
        .btn_start_stop(start_stop_clean),
        .btn_reset(reset_clean),
        .sec_ones(sec_ones),
        .sec_tens(sec_tens),
        .min_ones(min_ones),
        .min_tens(min_tens),
        .hour_ones(hour_ones),
        .hour_tens(hour_tens)
    );

    // 밀리초 카운터
    millisec_counter u3(
        .clk_100Hz(clk_100Hz),
        .reset_p(reset_p),
        .enable(start_stop_clean),  // running 상태일 때만 동작 
        .ms_ones(ms_ones),
        .ms_tens(ms_tens),
        .ms_overflow(ms_overflow)
    );

    // display 처리 
    display_scan_controller u4(
        .scan_clk(scan_clk),
        .reset_p(reset_p),
        .ms_ones(ms_ones),
        .ms_tens(ms_tens),
        .sec_ones(sec_ones),
        .sec_tens(sec_tens),
        .min_ones(min_ones),
        .min_tens(min_tens),
        .hour_ones(hour_ones),
        .hour_tens(hour_tens),
        .display_mode(display_mode),
        .scan_count(scan_count),
        .select_digit(select_digit)
    );

    seg_decoder u5(
        .digit_in(select_digit),
        .seg_out(seg)
    );

    anode_selector u6(
        .scan_count(scan_count),
        .an_out(an)
    );
    
endmodule