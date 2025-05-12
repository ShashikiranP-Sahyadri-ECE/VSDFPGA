module top (
    input wire clk,
    input wire rx,
    output wire led_r,
    output wire led_g,
    output wire led_b
);
    wire tick;
    wire [7:0] rx_data;
    wire rx_done;
    reg [7:0] data_buf;

    baud_gen #(.CLOCK_FREQ(12000000), .BAUD(9600)) baud_inst (
        .clk(clk),
        .tick(tick)
    );

    uart_rx uart_rx_inst (
        .clk(clk),
        .rx(rx),
        .tick(tick),
        .data(rx_data),
        .done(rx_done)
    );

    always @(posedge clk) begin
        if (rx_done)
            data_buf <= rx_data;
    end

    rgb_controller led_ctrl (
        .data(data_buf),
        .r(led_r),
        .g(led_g),
        .b(led_b)
    );
endmodule