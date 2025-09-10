`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2025 09:22:47 AM
// Design Name: 
// Module Name: led
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


module led_blink_1s(
    input clk,
    input reset,
    output reg [7:0] led
    );

    reg clk_1Hz;
    reg [26:0] count;

    // 1Hz clock 생성 
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            count <= 0;
            clk_1Hz <= 0;
        end
        else begin
            if(count == 49999999) begin
                count <= 0;
                clk_1Hz <= ~clk_1Hz;
            end
            else begin
                count <= count + 1;
            end
        end
    end

    always @(posedge clk_1Hz or posedge reset) begin
        if(reset) begin
            led <= 8'b00000000;
        end
        else begin
            led <= ~led;
        end
    end

endmodule


module led_shift_R (
    input clk,
    input reset,
    output reg [7:0] led
    );

    reg clk_1Hz;
    reg [26:0] count;

    // 1Hz clock 생성 
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            count <= 0;
            clk_1Hz <= 0;
        end
        else begin
            if(count == 49999999) begin
                count <= 0;
                clk_1Hz <= ~clk_1Hz;
            end
            else begin
                count <= count + 1;
            end
        end
    end

    // 오른쪽부터 shift
    always @(posedge clk_1Hz or posedge reset) begin
        if(reset) begin
            led <= 8'b00000001;
        end
        else begin
            led <= (led == 8'b10000000) ? 8'b00000001 : led << 1;
        end
    end
    
endmodule


module led_shift_L (
    input clk,
    input reset,
    output reg [7:0] led
    );

    reg clk_1Hz;
    reg [26:0] count;

    // 1Hz clock 생성 
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            count <= 0;
            clk_1Hz <= 0;
        end
        else begin
            if(count == 49999999) begin
                count <= 0;
                clk_1Hz <= ~clk_1Hz;
            end
            else begin
                count <= count + 1;
            end
        end
    end

    // 왼쪽부터 shift 
    always @(posedge clk_1Hz or posedge reset) begin
        if(reset) begin
            led <= 8'b10000000;
        end
        else begin
            led <= (led == 8'b00000001) ? 8'b10000000 : led >> 1;
        end
    end
    
endmodule


module led_ping_pong (
    input clk,
    input reset,
    output reg [7:0] led
    );

    reg clk_1Hz;
    reg [26:0] count;

    reg [2:0] left_s;
    reg [2:0] right_s;
    reg dir;

    // 1Hz clock 생성 
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            count <= 0;
            clk_1Hz <= 0;
        end
        else begin
            if(count == 49999999) begin
                count <= 0;
                clk_1Hz <= ~clk_1Hz;
            end
            else begin
                count <= count + 1;
            end
        end
    end

    always @(posedge clk_1Hz or posedge reset) begin
        if (reset) begin
            led <= 8'b10000001;
            left_s <= 0;
            right_s <= 7;
            dir <= 0; // 안쪽으로 시작
        end else begin
            // LED 초기화
            led <= 8'b00000000;
            // 두 위치 켜기
            led[left_s] <= 1'b1;
            led[right_s] <= 1'b1;

            // 방향에 따라 위치 업데이트
            if (dir == 0) begin
                // 안쪽으로 이동
                if (left_s < 3)
                    left_s <= left_s + 1;
                else
                    dir <= 1;  // 중앙 도달 → 반대 방향
                if (right_s > 4)
                    right_s <= right_s - 1;
            end else begin
                // 바깥쪽으로 이동
                if (left_s > 0)
                    left_s <= left_s - 1;
                else
                    dir <= 0;  // 양끝 도달 → 다시 안쪽
                if (right_s < 7)
                    right_s <= right_s + 1;
            end
        end
    end
    
endmodule


module led_shift_RL (
    input clk,
    input reset,
    output reg [7:0] led
    );

    reg clk_1Hz;
    reg [26:0] count;
    reg dir;

    // 1Hz clock 생성 
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            count <= 0;
            clk_1Hz <= 0;
        end
        else begin
            if(count == 49999999) begin
                count <= 0;
                clk_1Hz <= ~clk_1Hz;
            end
            else begin
                count <= count + 1;
            end
        end
    end

    always @(posedge clk_1Hz or posedge reset) begin
        if(reset) begin
            led <= 8'b00000001;
            dir <= 0;   // R -> L
        end else begin
            case (dir)
                0 : begin
                    if(led == 8'b10000000) begin
                        dir <= 1;   // 방향 전환 
                        led <= led >> 1;
                    end else begin
                        led <= led << 1;
                    end
                end
                1 : begin
                    if(led == 8'b00000001) begin
                        dir <= 0;
                        led <= led << 1;
                    end else begin
                        led <= led >> 1;
                    end
                end
            endcase
        end
    end    
    
endmodule