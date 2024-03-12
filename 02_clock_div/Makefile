all: help

test: clock-div.executable
	./clock-div.executable

clock-div.executable: testbench.v clk_div.v
	iverilog $^ -o $@

clean:
	- rm clock-div.executable
	- rm dump.vcd

help:
	@echo "  test  - Run testbench"
	@echo "  clean - Remove most generated files"
	@echo "  help  - Display this text"

.PHONY: clean test help
