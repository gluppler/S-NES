# ============================================================================
# SNES elasticity Demo Build System
# ============================================================================
# Build system for SNES elasticity demonstration
# Uses cc65 toolchain (ca65/ld65)
# ============================================================================

# Toolchain
AS = ca65
LD = ld65
CFG = elasticity.cfg

# Emulator selection (default: bsnes)
EMULATOR ?= bsnes

# Source files
SOURCES = elasticity.s
OBJECTS = elasticity.o

# Target ROM
TARGET = elasticity.sfc

# Phony targets
.PHONY: all clean run help check-cc65 check-emu check-python

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

# Default target: build ROM
.DEFAULT_GOAL := all
all: check-cc65 check-python $(TARGET)

# Build object files from assembly source
# Uses 65816 CPU mode and force_range feature for 16-bit immediates
$(OBJECTS): $(SOURCES) check-cc65
	@echo "Assembling $<..."
	$(AS) --cpu 65816 --feature force_range -g --large-alignment $< -o $@

# Link ROM from object files
$(TARGET): $(OBJECTS) $(CFG) check-python
	@echo "Linking $(TARGET)..."
	$(LD) -C $(CFG) -o $(TARGET) $(OBJECTS) --large-alignment
	@echo "Calculating checksum..."
	@python3 checksum.py HIROM $(TARGET)
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
	@rm -f $(OBJECTS) $(TARGET) elasticity.map elasticity.dbg
	@echo "✓ Clean complete"

# ============================================================================
# Run Targets
# ============================================================================

# Run ROM in selected emulator (bsnes or higan)
# Auto-installs emulator if not found
run: $(TARGET) check-emu
	@echo "Running $(TARGET) in $(EMULATOR)..."
	@if [ -n "$$WAYLAND_DISPLAY" ] && [ -n "$$DISPLAY" ]; then \
		echo "Wayland+XWayland - using XCB platform"; \
		QT_QPA_PLATFORM=xcb QT_LOGGING_RULES="qt.qpa.*=false" $(EMULATOR) $(TARGET) 2>&1 | grep -v "paintEngine\|qt.qpa" || true; \
	elif [ -n "$$WAYLAND_DISPLAY" ]; then \
		echo "Wayland - using XCB platform (more compatible)"; \
		QT_QPA_PLATFORM=xcb QT_LOGGING_RULES="qt.qpa.*=false" $(EMULATOR) $(TARGET) 2>&1 | grep -v "paintEngine\|qt.qpa" || true; \
	elif [ -n "$$DISPLAY" ]; then \
		echo "X11 - using XCB platform"; \
		QT_QPA_PLATFORM=xcb QT_LOGGING_RULES="qt.qpa.*=false" $(EMULATOR) $(TARGET) 2>&1 | grep -v "paintEngine\|qt.qpa" || true; \
	else \
		echo "No display server - running without QT_QPA_PLATFORM"; \
		$(EMULATOR) $(TARGET); \
	fi

# ============================================================================
# Help Target
# ============================================================================

help:
	@echo "SNES elasticity Demo Build System"
	@echo ""
	@echo "Targets:"
	@echo "  make                    - Build ROM (default)"
	@echo "  make clean              - Remove build artifacts"
	@echo "  make run                - Run ROM with default emulator (bsnes)"
	@echo "  make run EMULATOR=higan - Run ROM with higan"
	@echo "  make help               - Show this help"
	@echo ""
	@echo "Requirements (auto-installed if missing):"
	@echo "  - cc65 (ca65 with --cpu 65816, ld65)"
	@echo "  - python3 (for checksum calculation)"
	@echo "  - bsnes (SNES emulator, default) or higan"
