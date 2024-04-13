RISCV_PREFIX = riscv64-linux-gnu-

AS      = $(RISCV_PREFIX)as
LD      = $(RISCV_PREFIX)ld
GCC     = $(RISCV_PREFIX)gcc
OBJCOPY = $(RISCV_PREFIX)objcopy
OBJDUMP = $(RISCV_PREFIX)objdump

SRC_DIR   = src
BUILD_DIR = build

SRCS=$(wildcard $(SRC_DIR)/*)
OBJS=$(SRCS:$(SRC_DIR)/%=$(BUILD_DIR)/%.o)

all: help

rom: $(BUILD_DIR) $(DEST)
	$(call check_defined, DEST, destination file)

$(BUILD_DIR):
	- mkdir build

$(DEST): $(BUILD_DIR)/$(addsuffix .bin, $(basename $(notdir $(DEST))))
	hexdump -v -e '"%08x\n"' $(^) > $(@)

%.bin: %.out
	$(OBJCOPY) -O binary $(^) $(@)

%.out: $(OBJS)
	$(LD) -Ttext=0x1000 -melf32lriscv $(^) -o $(@) && $(OBJDUMP) -d $(@)

$(BUILD_DIR)/%.S.o: $(SRC_DIR)/%.S
	$(AS) -march=rv32i -mabi=ilp32 -c $(^) -o $(@)

$(BUILD_DIR)/%.c.o: $(SRC_DIR)/%.c
	$(GCC) -nostdlib -fomit-frame-pointer -O0 -march=rv32i -mabi=ilp32 -c $(^) -o $(@)

.PHONY: clean
.PRECIOUS: $(BUILD_DIR)/%.o %.out %.bin

clean:
	- rm -r build

help:
	@echo "  rom   - Generate text file with ROM contents"
	@echo "  clean - Remove generated files"
	@echo "  help  - Display this text"

check_defined = \
    $(strip $(foreach 1,$1, \
        $(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
    $(if $(value $1),, \
      $(error Undefined $1$(if $2, ($2))))
