// Módulos Aritméticos

`timescale 1ns/1ps

// Soma de 8 bits
module adicao8 (input [7:0] A, input [7:0] B, output [7:0] Y);
    assign Y = A + B;
endmodule

// Subtração de 8 bits
module subtracao8 (input [7:0] A, input [7:0] B, output [7:0] Y);
    assign Y = A - B;
endmodule

// Multiplicação (truncada 8 bits)
module multiplicacao8 (input [7:0] A, input [7:0] B, output [7:0] Y);
    assign Y = A * B;
endmodule

// Divisão inteira (com proteção contra B=0)
module divisao8 (input [7:0] A, input [7:0] B, output [7:0] Y);
    assign Y = (B != 0) ? (A / B) : 8'b00000000;
endmodule
