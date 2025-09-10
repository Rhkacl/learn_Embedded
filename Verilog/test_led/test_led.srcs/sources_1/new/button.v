`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2025 02:07:03 PM
// Design Name: 
// Module Name: button
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


module button_led(
    input clk,
    input reset,
    input btn_L,
    input btn_R,
    output reg [7:0] led
    );

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            led <= 8'b00000000;
        end
        else begin
            if(btn_L)
                led <= 8'b00000000;
            else if(btn_R)
                led <= 8'b11111111;
        end
    end
endmodule

// button debounce
module debounce (
    input clk,
    input reset,
    input noise_btn,
    output reg clean_btn
);

    reg [16:0] cnt;
    reg btn_sync_0; 
    reg btn_sync_1;
    reg btn_state;

    // 2단 동기화
    always @(posedge clk) begin
        btn_sync_0 <= noise_btn;
        btn_sync_1 <= btn_sync_0;
    end

    // 디바운스 로직
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            cnt <= 0;
            btn_state <= 0;
            clean_btn <= 0;
        end else begin
            if (btn_sync_1 == btn_state) begin
                cnt <= 0;           // 입력이 이전 상태와 같으면: 안정된 상태 -> 카운터 리셋
            end else begin
                cnt <= cnt + 1;     // 이전상태와 다르면 카운트 증가

                if (cnt >= 100000) begin  // 1ms 유지 확인
                    btn_state <= btn_sync_1;
                    clean_btn <= btn_sync_1;
                    cnt <= 0;
                end
            end
        end
    end
endmodule


module btn_led_blink (
    input clk,
    input reset,
    input btn_L,
    input btn_R,
    output reg [7:0] led
    );

    wire btn_L_clean;
    wire btn_R_clean;

    debounce U1(
        .clk(clk),
        .reset(reset),
        .noise_btn(btn_L),         // 원래 버튼
        .clean_btn(btn_L_clean)    // 디바운싱된 출력 
    );

    debounce U2(
        .clk(clk),
        .reset(reset),
        .noise_btn(btn_R),          // 원래 버튼
        .clean_btn(btn_R_clean)     // 세탁된 버튼 출력  
    );

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            led <= 8'b00000000;
        end
        else begin
            if(btn_L_clean) begin
                led <= 8'b00000000;
            end
            else if(btn_R_clean) begin
                led <= 8'b11111111;
            end
        end
    end
    
endmodule


module btn_led_shift_1 (
    input clk,
    input reset,
    input btn_L,
    input btn_R,
    output reg [7:0] led
    );

    wire btn_L_clean;
    wire btn_R_clean;

    reg btn_L_prev;
    reg btn_R_prev;

    debounce U1(
        .clk(clk),
        .reset(reset),
        .noise_btn(btn_L),         // 원래 버튼
        .clean_btn(btn_L_clean)    // 디바운싱된 출력 
    );

    debounce U2(
        .clk(clk),
        .reset(reset),
        .noise_btn(btn_R),          // 원래 버튼
        .clean_btn(btn_R_clean)     // 세탁된 버튼 출력  
    );

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            led <= 8'b00000000;     // 초기상태
            btn_L_prev <= 0;
            btn_L_prev <= 0;
        end 
        else begin
            if(btn_R_clean && !btn_R_prev) begin    // left shift
                if(led == 8'b00000000)
                    led <= 8'b00000001;
                else if(led != 8'b10000000)
                    led <= led << 1; 
            end

            else if(btn_L_clean && !btn_L_prev) begin   // right shift
                if(led == 8'b00000000)
                    led <= 8'b10000000;
                else if(led != 8'b00000001)
                    led <= led >> 1;   
            end
            // 이전 값 저장 
            btn_L_prev <= btn_L_clean;
            btn_R_prev <= btn_R_clean;
        end
    end
    
endmodule


module btn_led_Odd_Even (
    input clk,
    input reset,
    input btn_L,
    input btn_R,
    output reg [7:0] led
    );

    wire btn_L_clean;
    wire btn_R_clean;

    reg btn_L_prev;
    reg btn_R_prev;

    debounce U1(
        .clk(clk),
        .reset(reset),
        .noise_btn(btn_L),         // 원래 버튼
        .clean_btn(btn_L_clean)    // 디바운싱된 출력 
    );

    debounce U2(
        .clk(clk),
        .reset(reset),
        .noise_btn(btn_R),          // 원래 버튼
        .clean_btn(btn_R_clean)     // 세탁된 버튼 출력  
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            led <= 8'b00000000;
            btn_L_prev <= 0;
            btn_R_prev <= 0;
        end else begin
            if (btn_L_clean && !btn_L_prev) begin
                led <= 8'b10101010;     // 짝수 led on
            end
            else if (btn_R_clean && !btn_R_prev) begin
                led <=8'b01010101;      // 홀수 led on     
            end

            btn_L_prev <= btn_L_clean;
            btn_R_prev <= btn_R_clean;
        end
    end
    
    
endmodule


