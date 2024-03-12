all: help

test: invertor.executable
	./invertor.executable

invertor.executable: testbench.v repeater.v invertor.v
	iverilog $^ -o $@

clean:
	- rm invertor.executable
	- rm dump.vcd

help:
	@echo "  test  - Run testbench"
	@echo "  clean - Remove most generated files"
	@echo "  help  - Display this text"

.PHONY: clean test help
