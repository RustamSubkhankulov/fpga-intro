all: help

test: dfa.executable
	./dfa.executable

dfa.executable: testbench.v dfa.v
	iverilog $^ -o $@

clean:
	- rm dfa.executable
	- rm dump.vcd

help:
	@echo "  test  - Run testbench"
	@echo "  clean - Remove most generated files"
	@echo "  help  - Display this text"

.PHONY: clean test help
