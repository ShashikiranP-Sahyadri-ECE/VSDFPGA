# Task 1: VSDSquadron FPGA Mini Board - RGB LED Verilog Project

This project demonstrates RGB LED control on the VSDSquadron FPGA Mini Board using Verilog HDL. It was completed as part of a guided task session under the mentorship of Kunal Ghosh.

## Table of Contents
- [Objective](#objective)
- [Verilog Code Overview](#verilog-code-overview)
- [Internal Logic Description](#internal-logic-description)
- [Pin Mapping (PCF File)](#pin-mapping-pcf-file)
- [Board Integration](#board-integration)
- [How to Build and Flash](#how-to-build-and-flash)
- [Observations](#observations)
- [Challenges & Solutions](#challenges--solutions)
- [Acknowledgements](#acknowledgements)

---

## Objective
To understand and document the provided Verilog code, create a PCF file for pin assignments, and integrate the design with the VSDSquadron FPGA Mini Board using its datasheet and toolchain.

---

## Verilog Code Overview
**File:** `top.v`  
**Functionality:**  
- Blinks RGB LEDs using internal oscillator-driven counter logic.
- Outputs a test signal via `testwire`.

### Ports:
| Signal      | Direction | Description                    |
|-------------|-----------|--------------------------------|
| led_red     | Output    | Controls red LED               |
| led_blue    | Output    | Controls blue LED              |
| led_green   | Output    | Controls green LED             |
| hw_clk      | Input     | Clock input from onboard oscillator |
| testwire    | Output    | Test signal (tied to counter)  |

---

## Internal Logic Description
- **SB_HFOSC**: Internal high-frequency oscillator used for generating a clock signal.
- **Counter Logic**: A binary counter increments with each clock cycle.
- **LED Blinking**: Selected bits from the counter toggle the RGB LED outputs.
- **SB_RGBA_DRV**: RGB LED driver with current settings to safely drive each LED.

---

## Pin Mapping (PCF File)
**File:** `VSDSquadronFM.pcf`

| Signal      | Pin No. | Function           |
|-------------|---------|--------------------|
| led_red     | 39      | Red LED Output     |
| led_blue    | 40      | Blue LED Output    |
| led_green   | 41      | Green LED Output   |
| hw_clk      | 20      | Clock input        |
| testwire    | 17      | Test output signal |

These assignments were verified with the official VSDSquadron FPGA Mini Board datasheet.

---

## Board Integration
- Connected board via USB-C with FTDI for flashing.
- Toolchain installed (Yosys, NextPNR, IceStorm).
- Verified clock source and LED pinouts using datasheet.

---

## How to Build and Flash

```bash
make clean       # Clean previous builds
make build       # Synthesize and generate bitstream
sudo make flash  # Flash the board (requires sudo for FTDI access)
