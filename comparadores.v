// Módulos Comparadores 

`timescale 1ns/1ps

// A >= B
module comparadorGE (input [7:0] A, input [7:0] B, output [7:0] Y);
    assign Y = (A >= B) ? 8'b00000001 : 8'b00000000;
endmodule

// A <= B
module comparadorLE (input [7:0] A, input [7:0] B, output [7:0] Y);
    assign Y = (A <= B) ? 8'b00000001 : 8'b00000000;
endmodule

// A == B
module comparadorEQ (input [7:0] A, input [7:0] B, output [7:0] Y);
    assign Y = (A == B) ? 8'b00000001 : 8'b00000000;
endmodule
