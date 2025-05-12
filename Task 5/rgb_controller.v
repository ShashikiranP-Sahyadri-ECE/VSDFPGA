module rgb_controller (
    input wire [7:0] data,
    output reg r,
    output reg g,
    output reg b
);
    always @(*) begin
        case (data)
            8'h41: {r, g, b} = 3'b100;
            8'h42: {r, g, b} = 3'b010;
            8'h43: {r, g, b} = 3'b001;
            8'h44: {r, g, b} = 3'b110;
            8'h45: {r, g, b} = 3'b011;
            8'h46: {r, g, b} = 3'b101;
            default: {r, g, b} = 3'b000;
        endcase
    end
endmodule