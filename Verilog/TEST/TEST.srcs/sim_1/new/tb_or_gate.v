`timescale 1ns / 1ps


module tb_or_gate;
    reg a, b;
    wire q;

    // or_gate_behavioral uut (.a(a), .b(b), .q(q));
     or_gate_dataflow uut (.a(a), .b(b), .q(q));
    // or_gate_structual uut (.a(a), .b(b), .q(q));

    initial begin
        $display("Time\ta b | q");
        $monitor("%1t\t%b %b | %b", $time, a, b, q);

        // input combination test
        a = 0; b = 0; #10;  // #10 -> 10ns
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        $finish;
    end
endmodule