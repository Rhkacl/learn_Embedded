`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2025 10:24:09 AM
// Design Name: 
// Module Name: tb_T_filp_flop
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


module tb_T_filp_flop_n;

    // testbench 변수 
    reg clk, reset_p, t;
    wire q;

    T_flip_flop_n uut(
        .clk(clk),
        .reset_p(reset_p),
        .t(t),
        .q(q)
    );

    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin
        reset_p = 1;
        t = 0;
        #10 reset_p = 0;

        t = 1; #10;
        #10;
        #10;
        t = 0; #20;

        t = 1; #10;
        #10;
        
        reset_p = 1; #10;
        reset_p = 0; 

        t = 1; #20;

        $finish;
    end
    
endmodule


module tb_up_counter_asyc;
    
    reg clk;
    reg reset_p;
    wire [3:0] count;

    up_counter_asyc uut(
        .clk(clk),
        .reset_p(reset_p),
        .count(count)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset_p = 1;
        #10;
        reset_p = 0;    // 0으로 reset 하고 count 시작 

        #300;   // 300ns 동안 

        $finish;
    end
    
endmodule


module tb_down_counter_asyc;
    
    reg clk;
    reg reset_p;
    wire [3:0] count;

    down_counter_asyc uut(
        .clk(clk),
        .reset_p(reset_p),
        .count(count)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset_p = 1;

        #20;
        reset_p = 0;

        #300;

        $finish;
    end
    
endmodule


module tb_up_counter_p;
    
    reg clk;
    reg reset_p;
    reg enable;

    wire [3:0] up_count;

    //up_counter_n uut(
    up_counter_p uut(
        .clk(clk),
        .reset_p(reset_p),
        .enable(enable),
        .count(up_count)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset_p = 1;
        enable = 0;
        
        #10 reset_p = 0;
        #10 enable = 1;    // count start

        #200;

        enable = 0;
        #20;

        reset_p = 1;
        #10 reset_p = 0;
        #20;

        $finish;
    end
    
endmodule


module tb_down_counter_p;
    
    reg clk;
    reg reset_p;
    reg enable;

    wire [3:0] down_count;

    down_counter_p uut(
        .clk(clk),
        .reset_p(reset_p),
        .enable(enable),
        .count(down_count)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset_p = 1;
        enable = 0;
        
        #10 reset_p = 0;
        #10 enable = 1;    // count start

        #200;

        enable = 0;
        #20;

        reset_p = 1;
        #10 reset_p = 0;
        #20;

        $finish;
    end
    
endmodule


module tb_edge_detector_n;

    reg clk;
    reg reset_p;
    reg cp;

    wire p_edge;
    wire n_edge;

    edge_detector_n dut(
        .clk(clk),
        .reset_p(reset_p),
        .cp(cp),
        .p_edge(p_edge),
        .n_edge(n_edge)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset_p = 1;
        cp = 0;

        #12;
        reset_p = 0;
        
        #10 cp = 1; // 라이징 기대
        #10 cp = 0; // 폴링 기대 
        #10 cp = 1;
        #10 cp = 0;
        #10 cp = 1;
        #10 cp = 1; // 변화없음
        #10 cp = 0;

        #20;
        $stop;
    end
    
endmodule


module tb_edge_detector;

    reg clk;
    reg reset_p;
    reg cp;

    wire p_edge_pos, n_edge_pos;
    wire p_edge_neg, n_edge_neg;

    always #5 clk = ~clk;   // 10ns

    edge_detector_p uut_p(
        .clk(clk),
        .reset_p(reset_p),
        .cp(cp),
        .p_edge(p_edge_pos),
        .n_edge(n_edge_pos)
    );

    edge_detector_n uut_n(
        .clk(clk),
        .reset_p(reset_p),
        .cp(cp),
        .p_edge(p_edge_neg),
        .n_edge(n_edge_neg)
    );

    initial begin
        clk = 0;
        reset_p = 1;
        cp = 0;

        #12;
        reset_p = 0;

        #10; cp = 1;
        #20; cp = 0;
        #15; cp = 1;
        #25; cp = 0; 
        #25;

        $finish;        
    end
    
endmodule


module tb_ring_counter;

    reg clk;
    reg reset_p;
    wire [3:0] q;

    ring_counter_fnd uut(
        .clk(clk),
        .reset_p(reset_p),
        .q(q)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset_p = 1;

        #10 reset_p = 0;
        
        #5000; 

        $finish;
    end
    
endmodule


module tb_ring_counter_led;
    
    reg clk;
    reg reset_p;
    wire [16:0] led;

    ring_counter_led uut(
        .clk(clk),
        .reset_p(reset_p),
        .led(led)
    );

    initial begin
        clk = 0;
    end

    always #5 clk = ~clk;

    initial begin
        reset_p = 1;
        #20;
        reset_p = 0;

    #200000;

    $finish;
    end
    
endmodule
