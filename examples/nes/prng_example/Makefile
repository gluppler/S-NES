# ============================================================================
# PRNG Example Build System
# ============================================================================
# Demonstrates prng_6502 random number generator usage
# Based on prng_6502 by Brad Smith (rainwarrior)
# ============================================================================

# Toolchain
CA65 = ca65
LD65 = ld65
CFG = prng_example.cfg

# Emulator (default: fceux)
EMULATOR ?= fceux

# Source files
SOURCES = src/common.asm src/galois16.asm src/main.asm
OBJECTS = build/common.o build/galois16.o build/main.o

# Target ROM
TARGET = build/prng_example.nes

# Phony targets
.PHONY: all clean run help check-cc65 check-emu

# ============================================================================
# Dependency Installation
# ============================================================================

check-cc65:
	@echo "Checking for cc65 toolchain..."; \
	if command -v $(CA65) >/dev/null 2>&1 && command -v $(LD65) >/dev/null 2>&1; then \
		echo "✓ cc65 already installed ($(CA65), $(LD65))"; \
	else \
		echo "cc65 toolchain not found. Please install cc65."; \
		exit 1; \
	fi

check-emu:
	@echo "Checking for $(EMULATOR)..."; \
	if command -v $(EMULATOR) >/dev/null 2>&1; then \
		echo "✓ $(EMULATOR) already installed"; \
	else \
		echo "$(EMULATOR) not found. Please install an NES emulator."; \
		exit 1; \
	fi

# ============================================================================
# Build Targets
# ============================================================================

# Default target: build ROM
all: check-cc65 $(TARGET)

# Create build directory
build:
	@mkdir -p build

# Build object files
build/common.o: src/common.asm | build check-cc65
	@echo "Assembling $<..."
	$(CA65) -g -I src $< -o $@

build/galois16.o: src/galois16.asm src/common.asm | build check-cc65
	@echo "Assembling $<..."
	$(CA65) -g -I src $< -o $@

build/main.o: src/main.asm src/galois16.asm src/common.asm | build check-cc65
	@echo "Assembling $<..."
	$(CA65) -g -I src $< -o $@

# Create placeholder CHR file if missing
assets/test_nes.chr:
	@echo "Creating placeholder CHR file..."
	@mkdir -p assets
	@dd if=/dev/zero of=$@ bs=8192 count=1 2>/dev/null || \
	 python3 -c "open('$@', 'wb').write(b'\x00' * 8192)"

# Link ROM
$(TARGET): $(OBJECTS) $(CFG) assets/test_nes.chr | build check-cc65
	@echo "Linking $(TARGET)..."
	$(LD65) -C $(CFG) -o $(TARGET) $(OBJECTS) -m build/prng_example.map
	@if [ -f $(TARGET) ]; then \
		SIZE=$$(stat -c%s $(TARGET) 2>/dev/null || echo "unknown"); \
		echo "✓ ROM built: $(TARGET) ($$SIZE bytes)"; \
	else \
		echo "✗ ROM build failed"; \
		exit 1; \
	fi

# ============================================================================
# Clean Targets
# ============================================================================

clean:
	@echo "Cleaning build files..."
	@rm -rf build
	@echo "✓ Clean complete"

# ============================================================================
# Run Targets
# ============================================================================

run: $(TARGET) check-emu
	@echo "Running $(TARGET) in $(EMULATOR)..."
	@if [ -n "$$WAYLAND_DISPLAY" ] || [ -n "$$DISPLAY" ]; then \
		QT_QPA_PLATFORM=xcb $(EMULATOR) $(TARGET) 2>&1 | grep -v "paintEngine\|qt.qpa" || true; \
	else \
		$(EMULATOR) $(TARGET); \
	fi

# ============================================================================
# Help Target
# ============================================================================

help:
	@echo "PRNG Example Build System"
	@echo ""
	@echo "Targets:"
	@echo "  make           - Build ROM (default)"
	@echo "  make run       - Run ROM with default emulator (fceux)"
	@echo "  make clean     - Remove build artifacts"
	@echo "  make help      - Show this help"
