`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2025 09:32:40 AM
// Design Name: 
// Module Name: tb_led_blink
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


module tb_led_blink;

    reg clk;
    reg reset;
    wire [7:0] led;

    led_blink_1s dut(
        .clk(clk),
        .reset(reset),
        .led(led)
    );

    initial begin
        clk = 0;
        forever begin
            #5;
            clk = ~clk;
        end
    end

    initial begin
        reset = 1;
        #20;
        reset = 0;
    end

    initial begin
        #(100_000_000 * 10);
        $finish;
    end

endmodule
