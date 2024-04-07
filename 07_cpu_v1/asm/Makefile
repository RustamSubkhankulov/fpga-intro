RISCV_PREFIX = riscv64-linux-gnu-

AS      = $(RISCV_PREFIX)as
LD      = $(RISCV_PREFIX)ld
OBJCOPY = $(RISCV_PREFIX)objcopy
OBJDUMP = $(RISCV_PREFIX)objdump

SRC_DIR   = src
BUILD_DIR = build

SRCS=$(wildcard $(SRC_DIR)/*.S)
TXTS=$(SRCS:$(SRC_DIR)/%.S=$(BUILD_DIR)/%.txt)

all: help

rom: $(BUILD_DIR) $(TXTS)

$(BUILD_DIR):
	- mkdir build

%.txt: %.bin
	hexdump -v -e '"%08x\n"' $(^) > $(@)

%.bin: %.out
	$(OBJCOPY) -O binary $(^) $(@)

%.out: %.o
	$(LD) -melf32lriscv $(^) -o $(@) && $(OBJDUMP) -d $(@)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.S
	$(AS) -march=rv32i -mabi=ilp32 -c $(^) -o $(@)

.PHONY: clean
.PRECIOUS: $(BUILD_DIR)/%.o %.out %.bin

clean:
	- rm -r build

help:
	@echo "  rom   - Generate text file with ROM contents"
	@echo "  clean - Remove generated files"
	@echo "  help  - Display this text"
