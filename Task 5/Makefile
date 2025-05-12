TOP=top
DEVICE=up5k
PACKAGE=sg48

SOURCES=$(TOP).v baud_gen.v uart_rx.v rgb_controller.v
CONSTRAINTS=constraints.pcf

all: $(TOP).bin

$(TOP).json: $(SOURCES)
	yosys -p "synth_ice40 -top $(TOP) -json $(TOP).json" $(SOURCES)

$(TOP).asc: $(TOP).json $(CONSTRAINTS)
	nextpnr-ice40 --$(DEVICE) --package $(PACKAGE) --json $(TOP).json --pcf $(CONSTRAINTS) --asc $(TOP).asc

$(TOP).bin: $(TOP).asc
	icepack $(TOP).asc $(TOP).bin

clean:
	rm -f *.json *.asc *.bin

flash: $(TOP).bin
	iceprog $(TOP).bin
