// Módulo Registrador 8 Bits

module reg8 (
    input clk,
    input [7:0] D,
    output reg [7:0] Q
);
    always @(posedge clk) begin
        Q <= D;
    end
endmodule