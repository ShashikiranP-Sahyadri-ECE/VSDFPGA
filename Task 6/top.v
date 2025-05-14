`include "uart.v"
`include "ultrasonic.v"

module top (
  // outputs
  output wire uarttx,     
  input  wire uartrx,    
  input  wire hw_clk,
  input  wire echo,       
  output wire trig       
);

  wire int_osc;
  SB_HFOSC #(.CLKHF_DIV("0b10")) u_SB_HFOSC (
    .CLKHFPU(1'b1),
    .CLKHFEN(1'b1),
    .CLKHF(int_osc)
  );

  reg  clk_9600 = 0;
  reg  [31:0] cntr_9600 = 32'b0;
  parameter period_9600 = 625;

  always @(posedge int_osc) begin
    cntr_9600 <= cntr_9600 + 1'b1;
    if (cntr_9600 == period_9600) begin
      clk_9600  <= ~clk_9600;
      cntr_9600 <= 32'b0;
    end
  end

  wire [23:0] distanceRAW;      
  wire [15:0] distance_cm;       
  wire        sensor_ready;
  wire        measure;

  hc_sr04 u_sensor (
    .clk        (int_osc),
    .trig       (trig),
    .echo       (echo),
    .ready      (sensor_ready),
    .distanceRAW(distanceRAW),
    .distance_cm(distance_cm),  
    .measure    (measure)
  );


  refresher250ms trigger_timer (
    .clk (int_osc),
    .en  (1'b1),  
    .measure (measure)
  );


  reg [3:0] state;
  localparam IDLE    = 4'd0,
             DIGIT_4 = 4'd1,
             DIGIT_3 = 4'd2,
             DIGIT_2 = 4'd3,
             DIGIT_1 = 4'd4,
             DIGIT_0 = 4'd5,
             SEND_CR = 4'd6,
             SEND_LF = 4'd7,
             DONE    = 4'd8;

  reg [31:0] distance_reg; 
  reg [7:0]  tx_data;
  reg        send_data;


  always @(posedge clk_9600) begin
   
    send_data <= 1'b0;

    case (state)
      IDLE: begin
        if (sensor_ready) begin
          distance_reg <= distance_cm; 
          state <= DIGIT_4;          
        end
      end


      DIGIT_4: begin
        tx_data  <= ((distance_reg / 10000) % 10) + 8'h30;
        send_data <= 1'b1;
        state    <= DIGIT_3;
      end
      DIGIT_3: begin
        tx_data  <= ((distance_reg / 1000) % 10) + 8'h30;
        send_data <= 1'b1;
        state    <= DIGIT_2;
      end
      DIGIT_2: begin
        tx_data  <= ((distance_reg / 100) % 10) + 8'h30;
        send_data <= 1'b1;
        state    <= DIGIT_1;
      end
      DIGIT_1: begin
        tx_data  <= ((distance_reg / 10) % 10) + 8'h30;
        send_data <= 1'b1;
        state    <= DIGIT_0;
      end
      DIGIT_0: begin
        tx_data  <= (distance_reg % 10) + 8'h30;
        send_data <= 1'b1;
        state    <= SEND_CR;
      end


      SEND_CR: begin
        tx_data   <= 8'h0D; // '\r'
        send_data <= 1'b1;
        state     <= SEND_LF;
      end
      SEND_LF: begin
        tx_data   <= 8'h0A; // '\n'
        send_data <= 1'b1;
        state     <= DONE;
      end
      DONE: begin
        state <= IDLE;
      end

      default: state <= IDLE;
    endcase
  end
  uart_tx_8n1 sensor_uart (
    .clk      (clk_9600),
    .txbyte   (tx_data),
    .senddata (send_data),
    .tx       (uarttx)
  );

endmodule