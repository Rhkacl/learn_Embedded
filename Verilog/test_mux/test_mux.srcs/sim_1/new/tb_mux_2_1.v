`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2025 03:49:40 PM
// Design Name: 
// Module Name: tb_mux_2_1
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


// Multiplexer / Demultiplexer

module tb_mux_2_1;

    reg [1:0] d;
    reg s;
    wire f;

    mux_2_1_structual uut(
        .d(d),
        .s(s),
        .f(f)
    );

    initial begin
        $monitor ("time=%0t | s=%b  | d=%b  | f=%b", $time, s, d, f);

        d = 2'b10; s = 0; #10;  // s = 0 -> d[0] = 0
                   s = 1; #10;  // s = 1 -> d[1] = 1
        d = 2'b01; s = 0; #10;  // s = 0 -> d[0] = 1
                   s = 1; #10;  // s = 1 -> d[1] = 0

        $finish;
    end
endmodule


module tb_mux_4_1;

    reg [3:0] d;
    reg [1:0] s;
    wire f;

    mux_4_1_structural uut(
        .d(d),
        .s(s),
        .f(f)
    );

    initial begin
        $monitor ("time=%0t | s=%b  | d=%b  | f=%b", $time, s, d, f);

        d = 4'b1010;

        s = 2'b00; #10;
        s = 2'b01; #10;
        s = 2'b10; #10;
        s = 2'b11; #10;

        $finish;
    end
    
endmodule



module tb_mux_8_1;

    reg [7:0] d;
    reg [2:0] s;
    wire f;

    mux_8_1 uut(
        .d(d),
        .s(s),
        .f(f)
    );

    initial begin
        $monitor ("time=%0t | s=%b  | d=%b  | f=%b", $time, s, d, f);

        d = 8'b11001010;

        s = 3'b000; #10;
        s = 3'b001; #10;
        s = 3'b010; #10;
        s = 3'b011; #10;
        s = 3'b100; #10;
        s = 3'b101; #10;
        s = 3'b110; #10;
        s = 3'b111; #10;

        $finish;
    end
    
endmodule


module tb_demux_1_4;
    
    reg d;
    reg [1:0] s;
    wire [3:0] f;

    demux_1_4_d uut(
        .d(d),
        .s(s),
        .f(f)
    );

    initial begin
        $display("time\t d s\t|\tf");
        $monitor("%0t\t %b %b\t|\t%b", $time, d, s, f);

        d = 1;
        s = 2'b00; #10;
        s = 2'b01; #10;
        s = 2'b10; #10;
        s = 2'b11; #10;

        d = 0;
        s = 2'b00; #10;
        s = 2'b01; #10;
        s = 2'b10; #10;
        s = 2'b11; #10;

        $finish;
    end
    
endmodule


module tb_mux_demux_test;

    reg [3:0] d;        // mux input
    reg [1:0] mux_s;    // mux signal
    reg [1:0] demux_s;  // demux signal
    wire [3:0] f;       // output

    mux_demux_test uut(
        .d(d),
        .mux_s(mux_s),
        .demux_s(demux_s),
        .f(f)
    );

    initial begin
        $display("Time\td\tmux_s\tdemux_s\t|\tf");
        $monitor("4%t\t%b\t%b\t%b\t|\t%b", $time, d, mux_s, demux_s, f);

        // d 입력값 설정
        d = 4'b1010;

        mux_s = 2'b00; demux_s = 2'b00; #10;    // d[0] -> f[0]
        mux_s = 2'b01; demux_s = 2'b01; #10;    // d[1] -> f[1]
        mux_s = 2'b10; demux_s = 2'b10; #10;    // d[2] -> f[2]
        mux_s = 2'b11; demux_s = 2'b11; #10;    // d[3] -> f[3]

        // 다른거
        mux_s = 2'b11; demux_s = 2'b00; #10;
        mux_s = 2'b00; demux_s = 2'b11; #10;

        $finish;
    end              
    
endmodule