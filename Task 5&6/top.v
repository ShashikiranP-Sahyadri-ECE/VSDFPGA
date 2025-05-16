`include "uart_trx.v"

module top (
    input clk,
    input uartrx,
    output [2:0] rgb,
    output relay1     // Only one relay
);
    wire [7:0] rxbyte;
    wire received;

    reg [1:0] state = 2'b00;
    reg [2:0] rgb_reg = 3'b001;
    assign rgb = rgb_reg;

    reg relay1_reg = 0;

    // If relay module is **active-low**, invert the signal
    assign relay1 = ~relay1_reg;

    uart_rx uart_inst (
        .clk(clk),
        .rx(uartrx),
        .rxbyte(rxbyte),
        .received(received)
    );

    always @(posedge clk) begin
        if (received) begin
            case (state)
                2'b00: begin
                    rgb_reg <= 3'b001;      // RED
                    relay1_reg <= 1;        // Relay ON
                    state <= 2'b01;
                end
                2'b01: begin
                    rgb_reg <= 3'b010;      // GREEN
                    relay1_reg <= 0;        // Relay OFF
                    state <= 2'b10;
                end
                2'b10: begin
                    rgb_reg <= 3'b100;      // BLUE
                    relay1_reg <= 0;        // Relay OFF
                    state <= 2'b00;
                end
                default: begin
                    rgb_reg <= 3'b001;
                    relay1_reg <= 0;
                    state <= 2'b00;
                end
            endcase
        end
    end
endmodule
