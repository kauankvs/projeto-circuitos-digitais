// Módulos Aritméticos

// Soma de 8 bits
module adicao8 (input [7:0] A, input [7:0] B, output [7:0] Y);
    assign Y = A + B;
endmodule

// Subtração de 8 bits
module subtracao8 (input [7:0] A, input [7:0] B, output [7:0] Y);
    assign Y = A - B;
endmodule

// Multiplicação de 8 bits (truncado para 8 bits)
module multiplicacao8 (input [7:0] A, input [7:0] B, output [7:0] Y);
    assign Y = A * B;
endmodule

// Divisão inteira de 8 bits (sem tratamento para divisão por zero)
module divisao8 (input [7:0] A, input [7:0] B, output [7:0] Y);
    assign Y = (B != 0) ? (A / B) : 8'b00000000;
endmodule
