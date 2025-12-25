# ============================================================================
# SNES Hello World Build System
# ============================================================================
# Based on snes-hello canonical build process
# Auto-installs missing dependencies
# ============================================================================

# Toolchain
CL65    = cl65
CFG     = snes.cfg
EMU    ?= bsnes    # Default emulator; override with EMU=higan, etc.

# Source / target
SOURCES = main.s
TARGET  = hello.smc

# Phony targets
.PHONY: all clean run help check-cc65 check-emu

# ============================================================================
# Dependency Detection and Installation
# ============================================================================

# Check and install cc65 toolchain
check-cc65:
	@echo "Checking for cc65 toolchain..."; \
	if command -v $(CL65) >/dev/null 2>&1; then \
		echo "✓ cc65 already installed ($(CL65))"; \
	else \
		echo "cc65 toolchain not found in PATH."; \
		PKG_INSTALLED=0; \
		if command -v yay >/dev/null 2>&1; then \
			if yay -Qi cc65 >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "cc65 package is installed but cl65 not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v paru >/dev/null 2>&1; then \
			if paru -Qi cc65 >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "cc65 package is installed but cl65 not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v pacman >/dev/null 2>&1; then \
			if pacman -Qi cc65 >/dev/null 2>&1 2>/dev/null || pacman -Si cc65 >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "cc65 package is installed but cl65 not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then \
			if dpkg -l | grep -q "^ii.*cc65 "; then \
				PKG_INSTALLED=1; \
				echo "cc65 package is installed but cl65 not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v dnf >/dev/null 2>&1; then \
			if dnf list installed cc65 >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "cc65 package is installed but cl65 not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v yum >/dev/null 2>&1; then \
			if yum list installed cc65 >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "cc65 package is installed but cl65 not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v zypper >/dev/null 2>&1; then \
			if zypper search -i cc65 >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "cc65 package is installed but cl65 not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		fi; \
		if [ $$PKG_INSTALLED -eq 0 ]; then \
			echo "cc65 package not installed. Installing..."; \
			if command -v yay >/dev/null 2>&1; then \
				echo "Using yay (AUR helper)..."; \
				yay -S --noconfirm cc65 || (echo "Installation failed. Try: yay -S cc65" && exit 1); \
			elif command -v paru >/dev/null 2>&1; then \
				echo "Using paru (AUR helper)..."; \
				paru -S --noconfirm cc65 || (echo "Installation failed. Try: paru -S cc65" && exit 1); \
			elif command -v pacman >/dev/null 2>&1; then \
				if pacman -Si cc65 >/dev/null 2>&1; then \
					echo "Using pacman (official repos)..."; \
					sudo pacman -S --noconfirm cc65 || (echo "Installation failed. Try: sudo pacman -S cc65" && exit 1); \
				else \
					echo "cc65 not in official repos. Install AUR helper (yay/paru) or: yay -S cc65"; \
					exit 1; \
				fi; \
			elif command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then \
				echo "Using apt..."; \
				sudo apt-get update && sudo apt-get install -y cc65 || (echo "Installation failed. Try: sudo apt-get install cc65" && exit 1); \
			elif command -v dnf >/dev/null 2>&1; then \
				echo "Using dnf..."; \
				sudo dnf install -y cc65 || (echo "Installation failed. Try: sudo dnf install cc65" && exit 1); \
			elif command -v yum >/dev/null 2>&1; then \
				echo "Using yum..."; \
				sudo yum install -y cc65 || (echo "Installation failed. Try: sudo yum install cc65" && exit 1); \
			elif command -v zypper >/dev/null 2>&1; then \
				echo "Using zypper..."; \
				sudo zypper install -y cc65 || (echo "Installation failed. Try: sudo zypper install cc65" && exit 1); \
			else \
				echo "Error: Could not detect package manager."; \
				echo "Please install cc65 manually for your distribution."; \
				exit 1; \
			fi; \
			if ! command -v $(CL65) >/dev/null 2>&1; then \
				echo "Error: cc65 installation completed but cl65 not found. Restart terminal or check PATH."; \
				exit 1; \
			fi; \
			echo "✓ cc65 installed successfully"; \
		fi; \
	fi

# Check and install emulator
check-emu:
	@echo "Checking for $(EMU)..."; \
	if command -v $(EMU) >/dev/null 2>&1; then \
		echo "✓ $(EMU) already installed"; \
	else \
		echo "$(EMU) not found in PATH."; \
		EMU_NAME=$(EMU); \
		if [ "$$EMU_NAME" = "higan" ]; then \
			PKG_NAME="higan-git"; \
		else \
			PKG_NAME="$$EMU_NAME"; \
		fi; \
		PKG_INSTALLED=0; \
		if command -v yay >/dev/null 2>&1; then \
			if yay -Qi $$PKG_NAME >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "$$PKG_NAME package is installed but command not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v paru >/dev/null 2>&1; then \
			if paru -Qi $$PKG_NAME >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "$$PKG_NAME package is installed but command not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v pacman >/dev/null 2>&1; then \
			if pacman -Qi $$PKG_NAME >/dev/null 2>&1 2>/dev/null || pacman -Si $$PKG_NAME >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "$$PKG_NAME package is installed but command not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then \
			if dpkg -l | grep -q "^ii.*$$PKG_NAME "; then \
				PKG_INSTALLED=1; \
				echo "$$PKG_NAME package is installed but command not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v dnf >/dev/null 2>&1; then \
			if dnf list installed $$PKG_NAME >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "$$PKG_NAME package is installed but command not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v yum >/dev/null 2>&1; then \
			if yum list installed $$PKG_NAME >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "$$PKG_NAME package is installed but command not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v zypper >/dev/null 2>&1; then \
			if zypper search -i $$PKG_NAME >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "$$PKG_NAME package is installed but command not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		fi; \
		if [ $$PKG_INSTALLED -eq 0 ]; then \
			echo "$$PKG_NAME package not installed. Installing..."; \
			if command -v yay >/dev/null 2>&1; then \
				echo "Using yay (AUR helper)..."; \
				yay -S --noconfirm $$PKG_NAME || (echo "Installation failed. Try: yay -S $$PKG_NAME" && exit 1); \
			elif command -v paru >/dev/null 2>&1; then \
				echo "Using paru (AUR helper)..."; \
				paru -S --noconfirm $$PKG_NAME || (echo "Installation failed. Try: paru -S $$PKG_NAME" && exit 1); \
			elif command -v pacman >/dev/null 2>&1; then \
				if pacman -Si $$PKG_NAME >/dev/null 2>&1; then \
					echo "Using pacman (official repos)..."; \
					sudo pacman -S --noconfirm $$PKG_NAME || (echo "Installation failed. Try: sudo pacman -S $$PKG_NAME" && exit 1); \
				else \
					echo "$$PKG_NAME not in official repos. Install AUR helper (yay/paru) or: yay -S $$PKG_NAME"; \
					exit 1; \
				fi; \
			elif command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then \
				echo "Using apt..."; \
				sudo apt-get update && sudo apt-get install -y $$PKG_NAME || (echo "Installation failed. Try: sudo apt-get install $$PKG_NAME" && exit 1); \
			elif command -v dnf >/dev/null 2>&1; then \
				echo "Using dnf..."; \
				sudo dnf install -y $$PKG_NAME || (echo "Installation failed. Try: sudo dnf install $$PKG_NAME" && exit 1); \
			elif command -v yum >/dev/null 2>&1; then \
				echo "Using yum..."; \
				sudo yum install -y $$PKG_NAME || (echo "Installation failed. Try: sudo yum install $$PKG_NAME" && exit 1); \
			elif command -v zypper >/dev/null 2>&1; then \
				echo "Using zypper..."; \
				sudo zypper install -y $$PKG_NAME || (echo "Installation failed. Try: sudo zypper install $$PKG_NAME" && exit 1); \
			else \
				echo "Error: Could not detect package manager."; \
				echo "Please install $$PKG_NAME manually for your distribution."; \
				exit 1; \
			fi; \
			if ! command -v $(EMU) >/dev/null 2>&1; then \
				echo "Error: $(EMU) installation completed but command not found. Restart terminal or check PATH."; \
				exit 1; \
			fi; \
			echo "✓ $(EMU) installed successfully"; \
		fi; \
	fi

# ============================================================================
# Build Targets
# ============================================================================

# Default target: build ROM (.smc for SNES)
all: check-cc65 $(TARGET)

# Build ROM from assembly source
# Mirrors snes-hello build process:
#   cl65 -C smc.cfg -o hello.smc -l hello.list -m hello.mmap main.s
$(TARGET): $(SOURCES) $(CFG) check-cc65
	@echo "Building $(TARGET)..."
	$(CL65) -C $(CFG) -o $(TARGET) -l hello.list -m hello.mmap $(SOURCES)
	@if [ -f $(TARGET) ]; then \
		SIZE=$$(stat -c%s $(TARGET) 2>/dev/null || echo "unknown"); \
		echo "✓ ROM built: $(TARGET) ($$SIZE bytes)"; \
	else \
		echo "✗ ROM build failed"; \
		exit 1; \
	fi

# Run the .smc in an emulator
run: $(TARGET) check-emu
	@echo "Running $(TARGET) with $(EMU)..."
	@if [ -n "$$WAYLAND_DISPLAY" ] && [ -n "$$DISPLAY" ]; then \
		echo "Wayland+XWayland - using XCB platform"; \
		QT_QPA_PLATFORM=xcb QT_LOGGING_RULES="qt.qpa.*=false" $(EMU) $(TARGET) 2>&1 | grep -v "paintEngine\|qt.qpa" || true; \
	elif [ -n "$$WAYLAND_DISPLAY" ]; then \
		echo "Wayland - using XCB platform (more compatible)"; \
		QT_QPA_PLATFORM=xcb QT_LOGGING_RULES="qt.qpa.*=false" $(EMU) $(TARGET) 2>&1 | grep -v "paintEngine\|qt.qpa" || true; \
	elif [ -n "$$DISPLAY" ]; then \
		echo "X11 - using XCB platform"; \
		QT_QPA_PLATFORM=xcb QT_LOGGING_RULES="qt.qpa.*=false" $(EMU) $(TARGET) 2>&1 | grep -v "paintEngine\|qt.qpa" || true; \
	else \
		echo "No display server - running without QT_QPA_PLATFORM"; \
		$(EMU) $(TARGET); \
	fi

# ============================================================================
# Clean Targets
# ============================================================================

# Clean build artifacts
clean:
	@echo "Cleaning build files..."
	rm -f $(TARGET) hello.list hello.mmap *.o
	@echo "✓ Clean complete"

# ============================================================================
# Help Target
# ============================================================================

help:
	@echo "SNES Hello World Build System"
	@echo ""
	@echo "Targets:"
	@echo "  make           - Build ROM (default, produces $(TARGET))"
	@echo "  make run       - Build and run $(TARGET) with default emulator (bsnes)"
	@echo "  make run EMU=<name> - Run with specified emulator (e.g. higan)"
	@echo "  make clean     - Remove build artifacts"
	@echo "  make help      - Show this help"
	@echo ""
	@echo "Requirements (auto-installed if missing):"
	@echo "  - cc65 (cl65 toolchain)"
	@echo "  - bsnes (SNES emulator, default) or higan"
