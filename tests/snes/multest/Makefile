# ============================================================================
# SNES Multiply/Divide Test Build System
# ============================================================================
# Build system for SNES multiply/divide hardware test
# Uses cc65 toolchain (ca65/ld65)
# Builds two test ROMs: multest_mul16.sfc and multest_div16.sfc
# ============================================================================

# Toolchain
AS = ca65
LD = ld65
CFG = multest.cfg

# Emulator selection (default: bsnes)
EMULATOR ?= bsnes

# Source files
COMMON_SOURCE = multest.s
MUL16_SOURCE = test_mul16.s
DIV16_SOURCE = test_div16.s

# Object files
COMMON_OBJECT = multest.o
MUL16_OBJECT = test_mul16.o
DIV16_OBJECT = test_div16.o

# Target ROMs
MUL16_TARGET = multest_mul16.sfc
DIV16_TARGET = multest_div16.sfc

# Phony targets
.PHONY: all clean run run-mul16 run-div16 help check-cc65 check-emu check-python

# ============================================================================
# Dependency Installation
# ============================================================================

# Check and install cc65 toolchain
check-cc65:
	@echo "Checking for cc65 toolchain..."; \
	if command -v $(AS) >/dev/null 2>&1 && command -v $(LD) >/dev/null 2>&1; then \
		echo "✓ cc65 already installed ($(AS), $(LD))"; \
	else \
		echo "cc65 toolchain not found in PATH."; \
		if command -v yay >/dev/null 2>&1; then \
			yay -S --noconfirm cc65 || (echo "Installation failed. Try: yay -S cc65" && exit 1); \
		elif command -v paru >/dev/null 2>&1; then \
			paru -S --noconfirm cc65 || (echo "Installation failed. Try: paru -S cc65" && exit 1); \
		elif command -v pacman >/dev/null 2>&1; then \
			if pacman -Si cc65 >/dev/null 2>&1; then \
				sudo pacman -S --noconfirm cc65 || (echo "Installation failed. Try: sudo pacman -S cc65" && exit 1); \
			else \
				echo "cc65 not in official repos. Install AUR helper (yay/paru) or: yay -S cc65"; \
				exit 1; \
			fi; \
		elif command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then \
			sudo apt-get update && sudo apt-get install -y cc65 || (echo "Installation failed. Try: sudo apt-get install cc65" && exit 1); \
		elif command -v dnf >/dev/null 2>&1; then \
			sudo dnf install -y cc65 || (echo "Installation failed. Try: sudo dnf install cc65" && exit 1); \
		elif command -v yum >/dev/null 2>&1; then \
			sudo yum install -y cc65 || (echo "Installation failed. Try: sudo yum install cc65" && exit 1); \
		elif command -v zypper >/dev/null 2>&1; then \
			sudo zypper install -y cc65 || (echo "Installation failed. Try: sudo zypper install cc65" && exit 1); \
		else \
			echo "Error: Could not detect package manager."; \
			echo "Please install cc65 manually for your distribution."; \
			exit 1; \
		fi; \
		if ! command -v $(AS) >/dev/null 2>&1 || ! command -v $(LD) >/dev/null 2>&1; then \
			echo "Error: cc65 installation completed but tools not found. Restart terminal or check PATH."; \
			exit 1; \
		fi; \
		echo "✓ cc65 installed successfully"; \
	fi

# Check and install emulator
check-emu:
	@echo "Checking for $(EMULATOR)..."; \
	if command -v $(EMULATOR) >/dev/null 2>&1; then \
		echo "✓ $(EMULATOR) already installed"; \
	else \
		echo "$(EMULATOR) not found in PATH."; \
		EMU_NAME=$(EMULATOR); \
		if [ "$$EMU_NAME" = "higan" ]; then \
			PKG_NAME="higan-git"; \
		else \
			PKG_NAME="$$EMU_NAME"; \
		fi; \
		if command -v yay >/dev/null 2>&1; then \
			yay -S --noconfirm $$PKG_NAME || (echo "Installation failed. Try: yay -S $$PKG_NAME" && exit 1); \
		elif command -v paru >/dev/null 2>&1; then \
			paru -S --noconfirm $$PKG_NAME || (echo "Installation failed. Try: paru -S $$PKG_NAME" && exit 1); \
		elif command -v pacman >/dev/null 2>&1; then \
			if pacman -Si $$PKG_NAME >/dev/null 2>&1; then \
				sudo pacman -S --noconfirm $$PKG_NAME || (echo "Installation failed. Try: sudo pacman -S $$PKG_NAME" && exit 1); \
			else \
				echo "$$PKG_NAME not in official repos. Install AUR helper (yay/paru) or: yay -S $$PKG_NAME"; \
				exit 1; \
			fi; \
		elif command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then \
			sudo apt-get update && sudo apt-get install -y $$PKG_NAME || (echo "Installation failed. Try: sudo apt-get install $$PKG_NAME" && exit 1); \
		elif command -v dnf >/dev/null 2>&1; then \
			sudo dnf install -y $$PKG_NAME || (echo "Installation failed. Try: sudo dnf install $$PKG_NAME" && exit 1); \
		elif command -v yum >/dev/null 2>&1; then \
			sudo yum install -y $$PKG_NAME || (echo "Installation failed. Try: sudo yum install $$PKG_NAME" && exit 1); \
		elif command -v zypper >/dev/null 2>&1; then \
			sudo zypper install -y $$PKG_NAME || (echo "Installation failed. Try: sudo zypper install $$PKG_NAME" && exit 1); \
		else \
			echo "Error: Could not detect package manager."; \
			echo "Please install $$PKG_NAME manually for your distribution."; \
			exit 1; \
		fi; \
		if ! command -v $(EMULATOR) >/dev/null 2>&1; then \
			echo "Error: $(EMULATOR) installation completed but command not found. Restart terminal or check PATH."; \
			exit 1; \
		fi; \
		echo "✓ $(EMULATOR) installed successfully"; \
	fi

# Check and install Python 3
check-python:
	@echo "Checking for python3..."; \
	if command -v python3 >/dev/null 2>&1; then \
		echo "✓ python3 already installed"; \
	else \
		echo "python3 not found in PATH."; \
		if command -v yay >/dev/null 2>&1; then \
			yay -S --noconfirm python || (echo "Installation failed. Try: yay -S python" && exit 1); \
		elif command -v paru >/dev/null 2>&1; then \
			paru -S --noconfirm python || (echo "Installation failed. Try: paru -S python" && exit 1); \
		elif command -v pacman >/dev/null 2>&1; then \
			if pacman -Si python >/dev/null 2>&1; then \
				sudo pacman -S --noconfirm python || (echo "Installation failed. Try: sudo pacman -S python" && exit 1); \
			else \
				echo "python not in official repos. Install AUR helper (yay/paru) or: yay -S python"; \
				exit 1; \
			fi; \
		elif command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then \
			sudo apt-get update && sudo apt-get install -y python3 || (echo "Installation failed. Try: sudo apt-get install python3" && exit 1); \
		elif command -v dnf >/dev/null 2>&1; then \
			sudo dnf install -y python3 || (echo "Installation failed. Try: sudo dnf install python3" && exit 1); \
		elif command -v yum >/dev/null 2>&1; then \
			sudo yum install -y python3 || (echo "Installation failed. Try: sudo yum install python3" && exit 1); \
		elif command -v zypper >/dev/null 2>&1; then \
			sudo zypper install -y python3 || (echo "Installation failed. Try: sudo zypper install python3" && exit 1); \
		else \
			echo "Error: Could not detect package manager."; \
			echo "Please install python3 manually for your distribution."; \
			exit 1; \
		fi; \
		if ! command -v python3 >/dev/null 2>&1; then \
			echo "Error: python3 installation completed but python3 not found. Restart terminal or check PATH."; \
			exit 1; \
		fi; \
		echo "✓ python3 installed successfully"; \
	fi

# ============================================================================
# Build Targets
# ============================================================================

# Default target: build both test ROMs
.DEFAULT_GOAL := all
all: check-cc65 check-python $(MUL16_TARGET) $(DIV16_TARGET)

# Build common framework object
$(COMMON_OBJECT): $(COMMON_SOURCE) check-cc65
	@echo "Assembling $<..."
	$(AS) --cpu 65816 --feature force_range -g --large-alignment $< -o $@

# Build mul16 test object
$(MUL16_OBJECT): $(MUL16_SOURCE) check-cc65
	@echo "Assembling $<..."
	$(AS) --cpu 65816 --feature force_range -g $< -o $@

# Build div16 test object
$(DIV16_OBJECT): $(DIV16_SOURCE) check-cc65
	@echo "Assembling $<..."
	$(AS) --cpu 65816 --feature force_range -g $< -o $@

# Link mul16 test ROM
$(MUL16_TARGET): $(COMMON_OBJECT) $(MUL16_OBJECT) $(CFG) check-python
	@echo "Linking $(MUL16_TARGET)..."
	$(LD) -C $(CFG) -o $(MUL16_TARGET) $(COMMON_OBJECT) $(MUL16_OBJECT) --large-alignment
	@echo "Calculating checksum..."
	@python3 checksum.py HIROM $(MUL16_TARGET)
	@if [ -f $(MUL16_TARGET) ]; then \
		SIZE=$$(stat -c%s $(MUL16_TARGET) 2>/dev/null || echo "unknown"); \
		echo "✓ ROM built: $(MUL16_TARGET) ($$SIZE bytes)"; \
	else \
		echo "✗ ROM build failed"; \
		exit 1; \
	fi

# Link div16 test ROM
$(DIV16_TARGET): $(COMMON_OBJECT) $(DIV16_OBJECT) $(CFG) check-python
	@echo "Linking $(DIV16_TARGET)..."
	$(LD) -C $(CFG) -o $(DIV16_TARGET) $(COMMON_OBJECT) $(DIV16_OBJECT) --large-alignment
	@echo "Calculating checksum..."
	@python3 checksum.py HIROM $(DIV16_TARGET)
	@if [ -f $(DIV16_TARGET) ]; then \
		SIZE=$$(stat -c%s $(DIV16_TARGET) 2>/dev/null || echo "unknown"); \
		echo "✓ ROM built: $(DIV16_TARGET) ($$SIZE bytes)"; \
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
	@rm -f $(COMMON_OBJECT) $(MUL16_OBJECT) $(DIV16_OBJECT) \
	       $(MUL16_TARGET) $(DIV16_TARGET) \
	       multest_mul16.map multest_mul16.dbg \
	       multest_div16.map multest_div16.dbg
	@echo "✓ Clean complete"

# ============================================================================
# Run Targets
# ============================================================================

# Run mul16 test ROM
run-mul16: $(MUL16_TARGET) check-emu
	@echo "Running $(MUL16_TARGET) in $(EMULATOR)..."
	@if [ -n "$$WAYLAND_DISPLAY" ] && [ -n "$$DISPLAY" ]; then \
		echo "Wayland+XWayland - using XCB platform"; \
		QT_QPA_PLATFORM=xcb QT_LOGGING_RULES="qt.qpa.*=false" $(EMULATOR) $(MUL16_TARGET) 2>&1 | grep -v "paintEngine\|qt.qpa" || true; \
	elif [ -n "$$WAYLAND_DISPLAY" ]; then \
		echo "Wayland - using XCB platform (more compatible)"; \
		QT_QPA_PLATFORM=xcb QT_LOGGING_RULES="qt.qpa.*=false" $(EMULATOR) $(MUL16_TARGET) 2>&1 | grep -v "paintEngine\|qt.qpa" || true; \
	elif [ -n "$$DISPLAY" ]; then \
		echo "X11 - using XCB platform"; \
		QT_QPA_PLATFORM=xcb QT_LOGGING_RULES="qt.qpa.*=false" $(EMULATOR) $(MUL16_TARGET) 2>&1 | grep -v "paintEngine\|qt.qpa" || true; \
	else \
		echo "No display server - running without QT_QPA_PLATFORM"; \
		$(EMULATOR) $(MUL16_TARGET); \
	fi

# Run div16 test ROM
run-div16: $(DIV16_TARGET) check-emu
	@echo "Running $(DIV16_TARGET) in $(EMULATOR)..."
	@if [ -n "$$WAYLAND_DISPLAY" ] && [ -n "$$DISPLAY" ]; then \
		echo "Wayland+XWayland - using XCB platform"; \
		QT_QPA_PLATFORM=xcb QT_LOGGING_RULES="qt.qpa.*=false" $(EMULATOR) $(DIV16_TARGET) 2>&1 | grep -v "paintEngine\|qt.qpa" || true; \
	elif [ -n "$$WAYLAND_DISPLAY" ]; then \
		echo "Wayland - using XCB platform (more compatible)"; \
		QT_QPA_PLATFORM=xcb QT_LOGGING_RULES="qt.qpa.*=false" $(EMULATOR) $(DIV16_TARGET) 2>&1 | grep -v "paintEngine\|qt.qpa" || true; \
	elif [ -n "$$DISPLAY" ]; then \
		echo "X11 - using XCB platform"; \
		QT_QPA_PLATFORM=xcb QT_LOGGING_RULES="qt.qpa.*=false" $(EMULATOR) $(DIV16_TARGET) 2>&1 | grep -v "paintEngine\|qt.qpa" || true; \
	else \
		echo "No display server - running without QT_QPA_PLATFORM"; \
		$(EMULATOR) $(DIV16_TARGET); \
	fi

# Default run target (runs mul16)
run: run-mul16

# ============================================================================
# Help Target
# ============================================================================

help:
	@echo "SNES Multiply/Divide Test Build System"
	@echo ""
	@echo "Targets:"
	@echo "  make                    - Build both test ROMs (default)"
	@echo "  make clean              - Remove build artifacts"
	@echo "  make run                - Run mul16 test ROM (default)"
	@echo "  make run-mul16          - Run multiply test ROM"
	@echo "  make run-div16          - Run divide test ROM"
	@echo "  make run EMULATOR=higan - Run with higan"
	@echo "  make help               - Show this help"
	@echo ""
	@echo "Requirements (auto-installed if missing):"
	@echo "  - cc65 (ca65 with --cpu 65816, ld65)"
	@echo "  - python3 (for checksum calculation)"
	@echo "  - bsnes (SNES emulator, default) or higan"
	@echo ""
	@echo "Test: Tests SNES hardware multiply/divide instructions"
