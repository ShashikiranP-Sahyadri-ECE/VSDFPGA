module uart_rx (
    input wire clk,
    input wire rx,
    input wire tick,
    output reg [7:0] data,
    output reg done
);
    reg [3:0] state = 0;
    reg [7:0] shift = 0;
    reg [3:0] bit_count = 0;

    always @(posedge clk) begin
        done <= 0;
        if (tick) begin
            case (state)
                0: if (~rx) state <= 1;
                1: begin
                    shift[0] <= rx;
                    state <= 2; bit_count <= 1;
                end
                2,3,4,5,6,7,8: begin
                    shift[bit_count] <= rx;
                    bit_count <= bit_count + 1;
                    state <= state + 1;
                end
                9: begin
                    data <= shift;
                    done <= 1;
                    state <= 0;
                end
                default: state <= 0;
            endcase
        end
    end
endmodule