// Módulos Lógicos

// Operação AND
module and8 (input [7:0] A, input [7:0] B, output [7:0] Y);
    assign Y = A & B;
endmodule

// Operação OR
module or8 (input [7:0] A, input [7:0] B, output [7:0] Y);
    assign Y = A | B;
endmodule

// Operação XOR
module xor8 (input [7:0] A, input [7:0] B, output [7:0] Y);
    assign Y = A ^ B;
endmodule

// Operação NAND
module nand8 (input [7:0] A, input [7:0] B, output [7:0] Y);
    assign Y = ~(A & B);
endmodule

// Operação NOR
module nor8 (input [7:0] A, input [7:0] B, output [7:0] Y);
    assign Y = ~(A | B);
endmodule
