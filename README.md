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
![t1](https://github.com/user-attachments/assets/38d1e914-00f2-42b1-86ca-d92090b895dd)
---

## How to Build and Flash

```bash
make clean       # Clean previous builds
make build       # Synthesize and generate bitstream
sudo make flash  # Flash the board (requires sudo for FTDI access)
```
---
## Observations
![t11](https://github.com/user-attachments/assets/4cfc9e13-e768-4b76-9567-bbfe2c73e470)


---
# Task 2: UART Loopback Mechanism for VSDSquadron FPGA Mini

## Project Overview

This project implements a **UART loopback mechanism** on the **VSDSquadron FPGA Mini** to test UART functionality. The loopback mechanism ensures that the transmitted data is immediately received back, making it easier to verify the correct operation of the UART communication.

## Objectives

- Implement a UART loopback where transmitted data is immediately received back.
- Test UART functionality by sending and receiving data through a serial terminal.
- Document the design and testing process.

## How to Build and Flash

```bash
make clean       # Clean previous builds
make build       # Synthesize and generate bitstream
sudo make flash  # Flash the board (requires sudo for FTDI access)
```
---
# Diagram
![ChatGPT Image Apr 27, 2025, 03_29_27 PM](https://github.com/user-attachments/assets/13f9b58d-1934-47e7-882b-36ad5e5bee07)


---

## Observations
![20250427_171054](https://github.com/user-attachments/assets/21c149db-57a4-4f75-a606-c9ac9bb39dad)

---

![t2_1](https://github.com/user-attachments/assets/a2cdc028-6927-48be-9950-4a1286db6c57)


---

![t2_2](https://github.com/user-attachments/assets/c08077d9-b7fb-4cff-a7e7-29ae2440bf89)




