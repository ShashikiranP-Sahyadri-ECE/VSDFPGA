module baud_gen #(parameter CLOCK_FREQ = 12000000, parameter BAUD = 9600)(
    input wire clk,
    output reg tick
);
    localparam integer COUNT_MAX = CLOCK_FREQ / BAUD;
    integer count = 0;

    always @(posedge clk) begin
        if (count == COUNT_MAX / 2) begin
            tick <= 1;
            count <= 0;
        end else begin
            tick <= 0;
            count <= count + 1;
        end
    end
endmodule