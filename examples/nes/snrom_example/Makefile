# ============================================================================
# SNROM Example Build System (MMC1)
# ============================================================================

# Toolchain
AS = ca65
LD = ld65
CFG = snrom.cfg

# Source files
SOURCES = $(shell find . -name "*.asm" -o -name "*.s" | grep -v "^\./build" | sort)
OBJECTS = $(patsubst ./%,build/obj/%,$(SOURCES:.asm=.o))
OBJECTS := $(OBJECTS:.s=.o)

# Target ROM
TARGET = build/snrom_example.nes

# Phony targets
.PHONY: all clean help check-cc65

# ============================================================================
# Dependency Installation
# ============================================================================

check-cc65:
	@if ! command -v $(AS) >/dev/null 2>&1; then \
		echo "Error: cc65 not found. Install with: sudo pacman -S cc65"; \
		exit 1; \
	fi

# ============================================================================
# Build Targets
# ============================================================================

all: check-cc65 $(TARGET)

$(TARGET): $(OBJECTS) $(CFG) | build/rom
	@echo "Linking $@..."
	$(LD) -C $(CFG) -o $(TARGET) $(OBJECTS) -m build/snrom_example.map
	@if [ -f $(TARGET) ]; then \
		SIZE=$$(stat -c%s $(TARGET) 2>/dev/null || echo "unknown"); \
		echo "✓ ROM built: $(TARGET) ($$SIZE bytes)"; \
	fi

build/obj/%.o: %.asm | build/obj
	@echo "Assembling $<..."
	$(AS) -I . -o $@ $<

build/obj/%.o: %.s | build/obj
	@echo "Assembling $<..."
	$(AS) -I . -o $@ $<

build/obj build/rom:
	@mkdir -p $@

# ============================================================================
# Clean Targets
# ============================================================================

clean:
	@echo "Cleaning build files..."
	rm -rf build
	@echo "✓ Clean complete"

help:
	@echo "SNROM Example Build System"
	@echo ""
	@echo "Targets:"
	@echo "  make           - Build ROM"
	@echo "  make clean     - Remove build artifacts"
	@echo "  make help      - Show this help"
