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


---
# Task 3: VSDFSQUADRON UART Transmitter Project

## Overview

This project implements a UART transmitter (VSDFSQUADRON_FM_uart_tx) on the VSDFSQUADRON FPGA board as part of Task 3. The goal is to transmit data serially from the FPGA to a host computer via a USB-to-serial interface. The project includes Verilog code for the UART transmitter, a Makefile for building and flashing the FPGA, and instructions for testing the communication using a serial terminal.

## Prerequisites





### Hardware:





- VSDFSQUADRON FPGA board



- USB-to-serial adapter (e.g., FTDI or CP2102)



- Host computer (Linux or Windows)



### Software:





- FPGA development tools (e.g., Lattice Diamond or iCEcube2 for the VSDFSQUADRON board)



- make and a compatible toolchain for building the project



- Serial terminal software (e.g., picocom, PuTTY, Tera Term, or minicom)



- USB-to-serial drivers for your operating system

## Setup Instructions

### 1. Clone the Repository

Clone the repository to your local machine:
```bash
git clone https://github.com/ShashikiranP-Sahyadri-ECE/VSDFPGA.git
cd VSDFPGA/Task\ 3
```
### 2. Hardware Setup





- Connect the VSDFSQUADRON FPGA board to your computer via the USB-to-serial adapter.



Identify the serial port:




```bash
On Linux: Use ls /dev/tty* (typically /dev/ttyUSB0).
```


On Windows: Check Device Manager for the COM port (e.g., COM3).

### 3. Build the Project

The project includes a Makefile to compile the Verilog code and generate the bitstream for the FPGA.





Run the following command to build the project:
```bash
make build
```
This will synthesize, place, and route the design, producing a bitstream file.

### 4. Flash the FPGA

Flash the generated bitstream to the VSDFSQUADRON board:





Use the make target to flash:
```bash
make flash
```
This uses picocom to communicate with the FPGA over the serial port (/dev/ttyUSB0 on Linux or the appropriate COM port on Windows) at a baud rate of 9600.

### 5. Test the UART Communication





- Open a serial terminal to monitor the FPGA's UART output.





- Using PuTTY (Windows):



![t42](https://github.com/user-attachments/assets/125c498d-c291-431d-9541-3cce97dc9cac)


- Open PuTTY and configure it for a Serial connection:


![t41](https://github.com/user-attachments/assets/f197bbd9-c4df-41a6-b4d4-6dbe63d395b2)



- Serial line: COM3 (or your COM port)



Speed: 9600



- Connection type: Serial



- Click "Open" to start the session.



- Using picocom (Linux):
```bash
picocom -b 9600 /dev/ttyUSB0
```
- To exit picocom, press Ctrl+A followed by Ctrl+X.
![t3_1](https://github.com/user-attachments/assets/40fa797e-7be1-48dd-bf27-5f6e460cc2a6)



Once connected, the FPGA should transmit data over UART, which you can observe in the terminal.

## Project Structure





- VSDFSQUADRON_FM_uart_tx.v: The Verilog source file implementing the UART transmitter.



- Makefile: Automates the build and flashing process.



- Other files may include constraints, testbenches, or additional scripts as needed.

## Troubleshooting




No Data in Terminal:





- Verify the baud rate (9600) matches the UART configuration in the Verilog code.



- Ensure the correct serial port is used.



- Check hardware connections and drivers.



Repetitive Zeros in Output:





- This indicates a potential issue with the UART transmitter logic. Simulate the Verilog code to debug.



- Ensure the FPGA is not stuck in a loop sending invalid data.





## Additional Notes



![t3_2](https://github.com/user-attachments/assets/bf8e04a2-e569-499a-816c-08dec2777e01)


The UART transmitter is configured to operate at 9600 baud. If you need a different baud rate, modify the Verilog code and update the serial terminal settings accordingly.
![t3_4](https://github.com/user-attachments/assets/0afea96f-87ec-4788-b0c9-f1f4af0feb9b)

