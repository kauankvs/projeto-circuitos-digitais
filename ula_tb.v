`timescale 10ns/1ns
`include "ula.v"

module ula_tb;

    reg clk;
    reg [7:0] A_in, B_in;
    reg [3:0] opcode;
    wire [7:0] Y_out;

    // Instancia a ULA
    ula uut(
        .clk(clk),
        .A_in(A_in),
        .B_in(B_in),
        .opcode(opcode),
        .Y_out(Y_out)
    );

    // Geração de clock
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        $dumpfile("ula.vcd");
        $dumpvars(0, ula_tb);

        // Valores iniciais
        A_in = 0;
        B_in = 0;
        opcode = 0;

        #40;

        // 0000 - AND (2 testes)
        opcode = 4'b0000;
        A_in = 8'd15; B_in = 8'd6;   #40;
        A_in = 8'd255; B_in = 8'd1; #40;

        // 0001 - OR
        opcode = 4'b0001;
        A_in = 8'd15; B_in = 8'd6;   #40;
        A_in = 8'd128; B_in = 8'd64; #40;

        // 0010 - XOR
        opcode = 4'b0010;
        A_in = 8'd15; B_in = 8'd6;   #40;
        A_in = 8'd170; B_in = 8'd85; #40;

        // 0011 - NAND
        opcode = 4'b0011;
        A_in = 8'd15; B_in = 8'd6;   #40;
        A_in = 8'd255; B_in = 8'd255;#40;

        // 0100 - NOR
        opcode = 4'b0100;
        A_in = 8'd15; B_in = 8'd6;   #40;
        A_in = 8'd0;  B_in = 8'd0;   #40;

        // 0101 - ADD
        opcode = 4'b0101;
        A_in = 8'd20; B_in = 8'd10;  #40;
        A_in = 8'd200; B_in = 8'd55; #40;

        // 0110 - SUB
        opcode = 4'b0110;
        A_in = 8'd20; B_in = 8'd10;  #40;
        A_in = 8'd10; B_in = 8'd20;  #40;

        // 0111 - MUL
        opcode = 4'b0111;
        A_in = 8'd8;  B_in = 8'd4;   #40;
        A_in = 8'd12; B_in = 8'd12;  #40; // truncado p/ 8 bits

        // 1000 - DIV
        opcode = 4'b1000;
        A_in = 8'd20; B_in = 8'd4;   #40;
        A_in = 8'd100; B_in = 8'd7;  #40;

        // 1001 - GE
        opcode = 4'b1001;
        A_in = 8'd30; B_in = 8'd10;  #40;
        A_in = 8'd10; B_in = 8'd30;  #40;

        // 1010 - LE
        opcode = 4'b1010;
        A_in = 8'd5;  B_in = 8'd10;  #40;
        A_in = 8'd20; B_in = 8'd20;  #40;

        // 1011 - EQ
        opcode = 4'b1011;
        A_in = 8'd50; B_in = 8'd50;  #40;
        A_in = 8'd99; B_in = 8'd10;  #40;

        #40;
        $finish;
    end

endmodule
