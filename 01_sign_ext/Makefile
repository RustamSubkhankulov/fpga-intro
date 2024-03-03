all: help

test: sign-ext.executable
	./sign-ext.executable

sign-ext.executable: testbench.v sign_ext.v sign_ext2.v neg.v
	iverilog $^ -o $@

clean:
	rm -f sign-ext.executable

help:
	@echo "  test  - Run testbench"
	@echo "  clean - Remove most generated files"
	@echo "  help  - Display this text"

.PHONY: clean test help
