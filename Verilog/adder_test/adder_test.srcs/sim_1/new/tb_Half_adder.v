`timescale 1ns / 1ps



module tb_half_adder;

    reg a, b;
    wire s, c;

//    Half_adder_behavioral uut(.a(a), .b(b), .s(s), .c(c));

    initial begin
        $display("Time\ta b | s c");
        $monitor("%0t\t%b %b | %b %b", $time, a, b, s, c);

        a = 0; b = 0; #10
        a = 0; b = 1; #10
        a = 1; b = 0; #10
        a = 1; b = 1; #10

        $finish;
    end
endmodule
