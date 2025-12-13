# ============================================================================
# NES Welcome Typography Build System
# ============================================================================
# Build system for Welcome Typography NES program
# Follows NES documentation best practices
#
# Requirements:
#   - ca65 (assembler, part of cc65)
#   - ld65 (linker, part of cc65)
#   - FCEUX or compatible NES emulator
# ============================================================================

# Toolchain
AS = ca65
LD = ld65
CFG = nes.cfg

# Source files
SOURCES = main.asm
OBJECTS = $(SOURCES:.asm=.o)
TARGET = welcome.nes

# Phony targets
.PHONY: all clean distclean run verify help

# ============================================================================
# Build Targets
# ============================================================================

# Default target: build ROM
all: $(TARGET)

# Build object files from assembly source
%.o: %.asm chars_data.asm
	@echo "Assembling $<..."
	$(AS) $< -o $@

# Link ROM from object files
$(TARGET): $(OBJECTS) $(CFG) chars_data.asm
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

# Clean build artifacts
clean:
	@echo "Cleaning build files..."
	rm -f $(OBJECTS) $(TARGET)
	@echo "✓ Clean complete"

# Deep clean
distclean: clean
	@echo "Deep cleaning..."
	@echo "✓ Deep clean complete"

# ============================================================================
# Run Targets
# ============================================================================

# Run ROM in emulator
run: $(TARGET)
	@echo "Running $(TARGET) in FCEUX..."
	@echo "ROM file: $(TARGET) ($(shell stat -c%s $(TARGET)) bytes)"
	@if [ -n "$$WAYLAND_DISPLAY" ] && [ -n "$$DISPLAY" ]; then \
		echo "Wayland detected with XWayland - using XCB platform"; \
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

# Verify ROM structure
verify: $(TARGET)
	@echo "Verifying ROM structure..."
	@python3 -c "import sys; rom = open('$(TARGET)', 'rb').read(); \
		print(f'ROM size: {len(rom)} bytes'); \
		print(f'  Header: 16 bytes'); \
		print(f'  PRG ROM: 16384 bytes'); \
		print(f'  CHR ROM: 8192 bytes'); \
		print(f'  Expected: 24592 bytes'); \
		print('✓ Size correct' if len(rom) == 24592 else '✗ Size incorrect'); \
		header = rom[0:4]; \
		print(f'Header magic: {header}'); \
		print('✓ Header correct' if header == b'NES\x1a' else '✗ Header incorrect')"

# ============================================================================
# Help Target
# ============================================================================

# Display help information
help:
	@echo "NES Welcome Typography Build System"
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
