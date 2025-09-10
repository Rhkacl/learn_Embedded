`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2025 03:14:48 PM
// Design Name: 
// Module Name: tb_D_filp_flop
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


module tb_D_filp_flop;

    reg clk;
    reg d;
    wire q;

    D_filp_flop_Basic uut(
        .clk(clk),
        .d(d),
        .q(q)
    );

    // 클럭 생성 10ns(주기) 
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin
        d = 0;
        $display("Time\t clk d q");
        $monitor("%4t\t %d %b %b",$time, clk, d, q);
        // 15ns 이후에 d = 1 (clk 상승엣지에서 q에 반영)
        #15 d = 1;
        // 20ns 이후 d = 0;
        #20 d = 0;
        // 20ns 이후 d = 1;
        #20 d = 1;
        // 30ns simulation end
        #30 $finish;
    end
endmodule


module tb_D_filp_flop_n;
    
    reg d;
    reg clk;
    reg reset_p;
    reg enable;
    wire q;

    D_flip_flop_n dut(
        .d(d),
        .clk(clk),
        .reset_p(reset_p),
        .enable(enable),
        .q(q)
    );

    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin
        d = 0;
        reset_p = 1;
        enable = 0;
        // 리셋 해제 전에 잠시 대기
        #12;
        reset_p = 0;
        #10;
        enable = 1;
        
        d = 1;
        #10;
        d = 0;
        #10;
        d = 1;
        #10;

        enable = 0;
        d = 0;
        #20;

        enable = 1;
        d = 1;
        #10;

        reset_p = 1;
        #10;
        reset_p = 0;
        
        $stop;
    end
endmodule