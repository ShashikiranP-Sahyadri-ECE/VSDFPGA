module led_counter (
    input wire clk,        // Connected to hw_clk (pin 20)
    input wire reset,
    output reg [2:0] led   // led[0]=Green, led[1]=Red, led[2]=Blue
);
    reg [23:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset)
            counter <= 0;
        else
            counter <= counter + 1;
    end

    always @(posedge clk) begin
        led[0] <= counter[23]; // Green
        led[1] <= counter[22]; // Red
        led[2] <= counter[21]; // Blue
    end
endmodule
