// Módulo Unidade Lógica Aritmética (ULA)

module ula (
    input wire clk,
    input wire [7:0] A_in,
    input wire [7:0] B_in,
    input wire [3:0] opcode,        
    output reg [7:0] Y_out
);

    // Registradores de entrada
    wire [7:0] A, B;
    reg8 regA (clk, A_in, A);
    reg8 regB (clk, B_in, B);

    wire [15:0] sel;
    decodificador dec (opcode, 1'b1, sel);

    // Saídas de cada operação
    wire [7:0] outAND, outOR, outXOR, outNAND, outNOR;
    wire [7:0] outADD, outSUB, outMUL, outDIV;
    wire [7:0] outGE, outLE, outEQ;

    // Instanciação dos módulos
    and8  u_and  (.A(A), .B(B), .Y(outAND));
    or8   u_or   (.A(A), .B(B), .Y(outOR));
    xor8  u_xor  (.A(A), .B(B), .Y(outXOR));
    nand8 u_nand (.A(A), .B(B), .Y(outNAND));
    nor8  u_nor  (.A(A), .B(B), .Y(outNOR));

    adicao8        u_add (.A(A), .B(B), .Y(outADD));
    subtracao8     u_sub (.A(A), .B(B), .Y(outSUB));
    multiplicacao8 u_mul (.A(A), .B(B), .Y(outMUL));
    divisao8       u_div (.A(A), .B(B), .Y(outDIV));

    comparadorGE u_ge (.A(A), .B(B), .Y(outGE));
    comparadorLE u_le (.A(A), .B(B), .Y(outLE));
    comparadorEQ u_eq (.A(A), .B(B), .Y(outEQ));

    // Barramento de saída com buffers tri-state
    wire [7:0] bus;

    assign bus = sel[0]  ? outAND  : 8'bz; // 0000
    assign bus = sel[1]  ? outOR   : 8'bz; // 0001
    assign bus = sel[2]  ? outXOR  : 8'bz; // 0010
    assign bus = sel[3]  ? outNAND : 8'bz; // 0011
    assign bus = sel[4]  ? outNOR  : 8'bz; // 0100
    assign bus = sel[5]  ? outADD  : 8'bz; // 0101
    assign bus = sel[6]  ? outSUB  : 8'bz; // 0110
    assign bus = sel[7]  ? outMUL  : 8'bz; // 0111
    assign bus = sel[8]  ? outDIV  : 8'bz; // 1000
    assign bus = sel[9]  ? outGE   : 8'bz; // 1001
    assign bus = sel[10] ? outLE   : 8'bz; // 1010
    assign bus = sel[11] ? outEQ   : 8'bz; // 1011

    // Registrador de saída captura resultado do barramento na borda de subida
    always @(posedge clk) begin
        Y_out <= bus;
    end
endmodule
