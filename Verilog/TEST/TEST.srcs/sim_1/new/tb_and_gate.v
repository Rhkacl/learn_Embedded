`timescale 1ns / 1ps



module tb_and_gate;

    reg a, b;
    wire q;

    and_gate_behavioral uut (.a(a), .b(b), .q(q));

    initial begin
        $display("Time\ta b | q");
        $monitor("%4t\t%b %b | %b", $time, a, b, q);

        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        $finish;
    end
endmodule
