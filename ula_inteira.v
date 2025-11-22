// Módulos Aritméticos

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

// Módulos Comparadores 

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

// Módulo Decodificador

module decodificador (input [3:0] A, input EN, output reg [15:0] D);
    always @(*) begin
        if (EN) begin
            case (A)
                4'b0000: D = 16'b0000_0000_0000_0001;
                4'b0001: D = 16'b0000_0000_0000_0010;
                4'b0010: D = 16'b0000_0000_0000_0100;
                4'b0011: D = 16'b0000_0000_0000_1000;
                4'b0100: D = 16'b0000_0000_0001_0000;
                4'b0101: D = 16'b0000_0000_0010_0000;
                4'b0110: D = 16'b0000_0000_0100_0000;
                4'b0111: D = 16'b0000_0000_1000_0000;
                4'b1000: D = 16'b0000_0001_0000_0000;
                4'b1001: D = 16'b0000_0010_0000_0000;
                4'b1010: D = 16'b0000_0100_0000_0000;
                4'b1011: D = 16'b0000_1000_0000_0000;
                default: D = 16'b0000_0000_0000_0000;
            endcase
        end else begin
            D = 16'b0000_0000_0000_0000;
        end
    end
endmodule

// Módulos Lógicos

// Operação AND
module and8  (input [7:0] A, input [7:0] B, output [7:0] Y);
    assign Y = A & B;
endmodule

// Operação OR
module or8   (input [7:0] A, input [7:0] B, output [7:0] Y);
    assign Y = A | B;
endmodule

// Operação XOR
module xor8  (input [7:0] A, input [7:0] B, output [7:0] Y);
    assign Y = A ^ B;
endmodule

// Operação NAND
module nand8 (input [7:0] A, input [7:0] B, output [7:0] Y);
    assign Y = ~(A & B);
endmodule

// Operação NOR
module nor8  (input [7:0] A, input [7:0] B, output [7:0] Y);
    assign Y = ~(A | B);
endmodule

// Módulo Registrador 8 Bits

module reg8 (input clk, input [7:0] D, output reg [7:0] Q);
    always @(posedge clk) begin
        Q <= D;
    end
endmodule

// Módulo Unidade Lógica Aritmética (ULA)

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
