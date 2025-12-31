# ============================================================================
# nes-basic-controls Build System
# ============================================================================
# Converted to use cc65 (ca65/ld65) toolchain
# ============================================================================

# Toolchain
CA65 = ca65
LD65 = ld65
CFG = nes.cfg

# Source / target
SOURCE = basiccontroller_ca65.asm
OBJECT = build/basiccontroller.o
TARGET = build/basiccontroller.nes

# Emulator (default: fceux)
EMULATOR ?= fceux

# Phony targets
.PHONY: all clean run help check-cc65 check-emu

# ============================================================================
# Dependency Detection
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

# Build object file
$(OBJECT): $(SOURCE) | build check-cc65
	@echo "Assembling $<..."
	$(CA65) -g -I . -I ../hello_world/headers -o $@ $<

# Link ROM
$(TARGET): $(OBJECT) $(CFG) | build check-cc65
	@echo "Linking $(TARGET)..."
	$(LD65) -C $(CFG) -o $(TARGET) $(OBJECT)
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
	@echo "nes-basic-controls Build System (cc65)"
	@echo ""
	@echo "Targets:"
	@echo "  make           - Build ROM (default)"
	@echo "  make run       - Run ROM with default emulator (fceux)"
	@echo "  make clean     - Remove build artifacts"
	@echo "  make help      - Show this help"
