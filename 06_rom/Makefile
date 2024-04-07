all: help

test: romfetch.executable
	./romfetch.executable

romfetch.executable: $(wildcard *.v)
	iverilog $^ -o $@

clean:
	- rm romfetch.executable
	- rm dump.vcd

help:
	@echo "  test  - Run testbench"
	@echo "  clean - Remove most generated files"
	@echo "  help  - Display this text"

.PHONY: clean test help
