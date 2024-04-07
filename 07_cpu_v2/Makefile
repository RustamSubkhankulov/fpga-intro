all: help

test: cpu.executable
	./cpu.executable

cpu.executable: testbench.v
	iverilog $^ -o $@

clean:
	- rm cpu.executable
	- rm dump.vcd

help:
	@echo "  test  - Run testbench"
	@echo "  clean - Remove most generated files"
	@echo "  help  - Display this text"

.PHONY: clean test help
