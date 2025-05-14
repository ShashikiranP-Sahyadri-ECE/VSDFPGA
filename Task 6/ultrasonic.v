module hc_sr04 #(
  parameter ten_us = 10'd120  
)(
  input             clk,        
  input             measure,     
  output reg [1:0]  state,       
  output            ready,       
  input             echo,        
  output            trig,        
  output reg [23:0] distanceRAW, 
  output reg [15:0] distance_cm  
);
  localparam IDLE      = 2'b00,
             TRIGGER   = 2'b01,
             WAIT      = 2'b11,
             COUNTECHO = 2'b10;

  // 'ready' is high in IDLE
  assign ready = (state == IDLE);

  // 10-bit counter for ~10µs TRIGGER
  reg [9:0] counter;
  wire trigcountDONE = (counter == ten_us);

  // Initialize registers (for simulation & synthesis without reset)
  initial begin
    state       = IDLE;
    distanceRAW = 24'd0;
    distance_cm = 16'd0;
    counter     = 10'd0;
  end
  always @(posedge clk) begin
    case (state)
      IDLE: begin
        // Wait for measure pulse
        if (measure && ready)
          state <= TRIGGER;
      end

      TRIGGER: begin
        // ~10µs pulse, then WAIT
        if (trigcountDONE)
          state <= WAIT;
      end

      WAIT: begin
        // Wait for echo rising edge
        if (echo)
          state <= COUNTECHO;
      end

      COUNTECHO: begin
        // Once echo goes low => measurement done
        if (!echo)
          state <= IDLE;
      end

      default: state <= IDLE;
    endcase
  end
  assign trig = (state == TRIGGER);
  always @(posedge clk) begin
    if (state == IDLE) begin
      counter <= 10'd0;
    end
    else if (state == TRIGGER) begin
      counter <= counter + 1'b1;
    end
  end
  always @(posedge clk) begin
    if (state == WAIT) begin
      // Reset before new measurement
      distanceRAW <= 24'd0;
    end
    else if (state == COUNTECHO) begin
      // Add 1 each clock cycle while echo=1
      distanceRAW <= distanceRAW + 1'b1;
    end
  end
  always @(posedge clk) begin
    distance_cm <= (distanceRAW * 34300) / (2 * 12000000);
  end

endmodule

module refresher250ms(
  input  clk,    input  en,
  output measure
);
  reg [18:0] counter;
  assign measure = (counter == 22'd1);

  initial begin
    counter = 22'd0;
  end

  always @(posedge clk) begin
    if (~en || (counter == 22'd600000))  
      counter <= 22'd0;
    else
      counter <= counter + 1;
  end
endmodule