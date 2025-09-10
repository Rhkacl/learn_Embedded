`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2025 09:23:45 AM
// Design Name: 
// Module Name: comparator
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


module comparator_dataflow(
    input a, b,     // 입력 a, b(각 1bit)
    output equal,   // a == b -> 1
    output greator, // a > b -> 1
    output less     // a < b -> 1
    );

    assign equal = (a == b) ? 1'b1 : 1'b0;   // a와 b가 같으면 equal = 1
    assign greator = (a > b) ? 1'b1 : 1'b0;  // a가 b보다 크면 greator = 1
    assign less = (a < b) ? 1'b1 : 1'b0;     // a가 b보다 작으면 less = 1
endmodule


module comparator_structural (
    input a, b,
    output equal, greator, less
    );
    
    // equal = (~a & ~b) | (a & b)
    // greator = a & ~b
    // less = ~a & b
    
    wire nota, notb;
    wire a_and_b, nota_and_notb;
    wire a_and_notb, nota_and_b;

    not (nota, a);  // nota = ~a
    not (notb, b);  // notb = ~b

    and (nota_and_notb, nota, notb);        // ~a & ~b
    and (a_and_b, a, b);                    // a & b
    or  (equal, nota_and_notb, a_and_b);    // equal = (~a & ~b) | (a & b)

    and (greator, a, notb);                 // a & ~b
    and (less, nota, b);                    // ~a & b    
endmodule


module comparator_behavioral (
    input a, b,
    output reg equal, greator, less
    );

    always @(a, b) begin
        equal = 0;
        greator = 0;
        less = 0;

        if (a == b)
            equal = 1;
        else if (a > b)
            greator = 1;
        else
            less = 1;
    end
endmodule


// N bit Comparator
// use dataflow module 
module comparator_Nbit #(parameter N = 8)(
    input [N-1:0] a, b,
    output equal,
    output greator,
    output less
    );

    assign equal = (a == b) ? 1'b1 : 1'b0;
    assign greator = (a > b) ? 1'b1 : 1'b0;
    assign less = (a < b) ? 1'b1 : 1'b0;
endmodule


module comparator_test_4bit (
    input [3:0] a, b,
    output equal, greator, less
    );

    comparator_Nbit #(.N(4)) test(
        .a(a),
        .b(b),
        .equal(equal),
        .greator(greator),
        .less(less)
    );

endmodule


module comparator_Nbit_behavioral #(parameter N = 8) (
    input [N-1:0] a, b,
    output reg equal, greator, less
    );

    always @(*) begin
        equal = 0;
        greator = 0;
        less = 0;

        if (a == b) begin
            equal = 1;
        end
        else if (a > b) begin
            greator = 1;
        end
        else if (a < b) begin
            less = 1;
        end
    end        
endmodule