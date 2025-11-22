// Módulo Unidade Lógica Aritmética (ULA)

`timescale 1ns/1ps

`include "logico.v"
`include "aritmeticos.v"
`include "comparadores.v"
`include "decodificador.v"
`include "registrador8.v"

module ula (
    input  wire       clk,
    input  wire [7:0] A_in,
    input  wire [7:0] B_in,
    input  wire [3:0] opcode,
    output wire [7:0] Y_out      
);

    // Registradores de Entrada
    wire [7:0] A, B;
    reg8 regA (clk, A_in, A);
    reg8 regB (clk, B_in, B);

    // Decodificador
    wire [15:0] sel;
    decodificador dec (opcode, 1'b1, sel);

    // Saídas das Operações
    wire [7:0] outAND, outOR, outXOR, outNAND, outNOR;
    wire [7:0] outADD, outSUB, outMUL, outDIV;
    wire [7:0] outGE, outLE, outEQ;

    // Intâncias dos Módulos
    and8  u_and  (A, B, outAND);
    or8   u_or   (A, B, outOR);
    xor8  u_xor  (A, B, outXOR);
    nand8 u_nand (A, B, outNAND);
    nor8  u_nor  (A, B, outNOR);

    adicao8        u_add (A, B, outADD);
    subtracao8     u_sub (A, B, outSUB);
    multiplicacao8 u_mul (A, B, outMUL);
    divisao8       u_div (A, B, outDIV);

    comparadorGE u_ge (A, B, outGE);
    comparadorLE u_le (A, B, outLE);
    comparadorEQ u_eq (A, B, outEQ);

    // Mux Interno
    reg [7:0] mux_out;

    always @(*) begin
        case (1'b1)
            sel[0]:  mux_out = outAND;
            sel[1]:  mux_out = outOR;
            sel[2]:  mux_out = outXOR;
            sel[3]:  mux_out = outNAND;
            sel[4]:  mux_out = outNOR;
            sel[5]:  mux_out = outADD;
            sel[6]:  mux_out = outSUB;
            sel[7]:  mux_out = outMUL;
            sel[8]:  mux_out = outDIV;
            sel[9]:  mux_out = outGE;
            sel[10]: mux_out = outLE;
            sel[11]: mux_out = outEQ;
            default: mux_out = 8'b00000000;
        endcase
    end

    // Registrador de Saída
    reg [7:0] Y_reg;

    always @(posedge clk) begin
        Y_reg <= mux_out;
    end

    // Buffer Tri-State Externo
    assign Y_out = 1'b1 ? Y_reg : 8'bz;

endmodule
