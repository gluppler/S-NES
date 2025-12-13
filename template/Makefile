# ============================================================================
# NES Template Build System
# ============================================================================
# Build system for NES template
# Follows NES documentation best practices
#
# Requirements:
#   - ca65 (assembler, part of cc65)
#   - ld65 (linker, part of cc65)
#   - Python 3 (for verify target only)
#   - FCEUX (NES emulator)
# ============================================================================

# Toolchain
AS = ca65
LD = ld65
CFG = nes.cfg

# Source files
SOURCES = main.asm
OBJECTS = $(SOURCES:.asm=.o)
TARGET = template.nes

# Phony targets
.PHONY: all clean distclean run verify help

# ============================================================================
# Build Targets
# ============================================================================

# Default target: build ROM
all: $(TARGET)

# Build object files from assembly source
%.o: %.asm
	@echo "Assembling $<..."
	$(AS) $< -o $@

# Link ROM from object files
# Dependencies: object files, linker config, and CHR ROM file
$(TARGET): $(OBJECTS) $(CFG) chars.chr
	@echo "Linking $(TARGET)..."
	$(LD) -C $(CFG) -o $(TARGET) $(OBJECTS)
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

# Clean build artifacts (object files and ROM)
clean:
	@echo "Cleaning build files..."
	rm -f $(OBJECTS) $(TARGET)
	@echo "✓ Clean complete"

# Deep clean (same as clean for this project)
distclean: clean
	@echo "Deep cleaning..."
	@echo "✓ Deep clean complete"

# ============================================================================
# Run Targets
# ============================================================================

# Run ROM in emulator
# Detects display server (X11/Wayland) and sets appropriate Qt platform
run: $(TARGET)
	@echo "Running $(TARGET) in FCEUX..."
	@echo "ROM file: $(TARGET) ($(shell stat -c%s $(TARGET)) bytes, modified $(shell stat -c%y $(TARGET) | cut -d' ' -f1-2))"
	@echo "Note: Check FCEUX PPU Viewer (Tools -> PPU Viewer) to debug display issues"
	@echo "IMPORTANT: If you see old data, close FCEUX completely and reopen it to reload the ROM"
	@if [ -n "$$WAYLAND_DISPLAY" ] && [ -n "$$DISPLAY" ]; then \
		echo "Wayland detected with XWayland - using XCB platform for better compatibility"; \
		QT_QPA_PLATFORM=xcb fceux "$(TARGET)"; \
	elif [ -n "$$WAYLAND_DISPLAY" ]; then \
		echo "Wayland detected - using Wayland platform"; \
		QT_QPA_PLATFORM=wayland fceux "$(TARGET)"; \
	elif [ -n "$$DISPLAY" ]; then \
		echo "X11 detected - using XCB platform"; \
		QT_QPA_PLATFORM=xcb fceux "$(TARGET)"; \
	else \
		echo "Error: No display server detected (X11 or Wayland)"; \
		exit 1; \
	fi

# ============================================================================
# Verify Targets
# ============================================================================

# Verify ROM structure (size and header)
verify: $(TARGET)
	@echo "Verifying ROM structure..."
	@python3 -c "import sys; rom = open('$(TARGET)', 'rb').read(); \
		print(f'ROM size: {len(rom)} bytes'); \
		print(f'  Header: 16 bytes'); \
		print(f'  PRG ROM: 32768 bytes'); \
		print(f'  CHR ROM: 8192 bytes'); \
		print(f'  Expected: 40976 bytes'); \
		print('✓ Size correct' if len(rom) == 40976 else '✗ Size incorrect'); \
		header = rom[0:4]; \
		print(f'Header magic: {header}'); \
		print('✓ Header correct' if header == b'NES\x1a' else '✗ Header incorrect')"

# ============================================================================
# Help Target
# ============================================================================

# Display help information
help:
	@echo "NES Template Build System"
	@echo ""
	@echo "Targets:"
	@echo "  make          - Build ROM (default)"
	@echo "  make clean    - Remove build artifacts"
	@echo "  make distclean - Deep clean"
	@echo "  make run      - Run ROM in FCEUX"
	@echo "  make verify   - Verify ROM structure"
	@echo "  make help     - Show this help"
	@echo ""
	@echo "Requirements:"
	@echo "  - ca65 (assembler)"
	@echo "  - ld65 (linker)"
	@echo "  - FCEUX (emulator)"
