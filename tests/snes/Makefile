# ============================================================================
# SNES Test Demos Build System
# ============================================================================
# Build system for SNES test demos by Brad Smith (rainwarrior)
# Uses cc65 toolchain (ca65/ld65)
# ============================================================================

# Toolchain
CA65    = ca65
LD65    = ld65
EMU    ?= bsnes    # Default emulator

# Demo directories
DEMOS := colourmath ctrltest multest extbgtest iplfast noise31 palcycle \
         dizworld elasticity twoship smalltext mset
# All demos now have Makefiles with auto-installation of dependencies
# Special requirements:
#   - ctrltest, mset: Require runtime.lib (C code compilation)
#   - iplfast, noise31: Require wla-dx (SPC700 code compilation)

# Phony targets
.PHONY: all clean help check-cc65 check-emu check-python $(DEMOS)

.DEFAULT_GOAL := all

# ============================================================================
# Dependency Detection and Installation
# ============================================================================

# Check and install cc65 toolchain
check-cc65:
	@echo "Checking for cc65 toolchain..."; \
	if command -v $(CA65) >/dev/null 2>&1 && command -v $(LD65) >/dev/null 2>&1; then \
		echo "✓ cc65 already installed ($(CA65), $(LD65))"; \
	else \
		echo "cc65 toolchain not found in PATH."; \
		PKG_INSTALLED=0; \
		if command -v yay >/dev/null 2>&1; then \
			if yay -Qi cc65 >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "cc65 package is installed but tools not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v paru >/dev/null 2>&1; then \
			if paru -Qi cc65 >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "cc65 package is installed but tools not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v pacman >/dev/null 2>&1; then \
			if pacman -Qi cc65 >/dev/null 2>&1 2>/dev/null || pacman -Si cc65 >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "cc65 package is installed but tools not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		fi; \
		if [ $$PKG_INSTALLED -eq 0 ]; then \
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
			if ! command -v $(CA65) >/dev/null 2>&1 || ! command -v $(LD65) >/dev/null 2>&1; then \
				echo "Error: cc65 installation completed but tools not found. Restart terminal or check PATH."; \
				exit 1; \
			fi; \
			echo "✓ cc65 installed successfully"; \
		fi; \
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

# Check and install wla-dx (for SPC700 demos)
check-wla-dx:
	@echo "Checking for wla-dx..."; \
	if command -v wla-spc700 >/dev/null 2>&1 && command -v wlalink >/dev/null 2>&1; then \
		echo "✓ wla-dx already installed"; \
	else \
		echo "wla-dx not found in PATH."; \
		if command -v yay >/dev/null 2>&1; then \
			yay -S --noconfirm wla-dx || (echo "Installation failed. Try: yay -S wla-dx" && exit 1); \
		elif command -v paru >/dev/null 2>&1; then \
			paru -S --noconfirm wla-dx || (echo "Installation failed. Try: paru -S wla-dx" && exit 1); \
		elif command -v pacman >/dev/null 2>&1; then \
			if pacman -Si wla-dx >/dev/null 2>&1; then \
				sudo pacman -S --noconfirm wla-dx || (echo "Installation failed. Try: sudo pacman -S wla-dx" && exit 1); \
			else \
				echo "wla-dx not in official repos. Install AUR helper (yay/paru) or: yay -S wla-dx"; \
				exit 1; \
			fi; \
		elif command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then \
			sudo apt-get update && sudo apt-get install -y wla-dx || (echo "Installation failed. Try: sudo apt-get install wla-dx" && exit 1); \
		elif command -v dnf >/dev/null 2>&1; then \
			sudo dnf install -y wla-dx || (echo "Installation failed. Try: sudo dnf install wla-dx" && exit 1); \
		elif command -v yum >/dev/null 2>&1; then \
			sudo yum install -y wla-dx || (echo "Installation failed. Try: sudo yum install wla-dx" && exit 1); \
		elif command -v zypper >/dev/null 2>&1; then \
			sudo zypper install -y wla-dx || (echo "Installation failed. Try: sudo zypper install wla-dx" && exit 1); \
		else \
			echo "Error: Could not detect package manager."; \
			echo "Please install wla-dx manually for your distribution."; \
			exit 1; \
		fi; \
		if ! command -v wla-spc700 >/dev/null 2>&1 || ! command -v wlalink >/dev/null 2>&1; then \
			echo "Error: wla-dx installation completed but tools not found. Restart terminal or check PATH."; \
			exit 1; \
		fi; \
		echo "✓ wla-dx installed successfully"; \
	fi

# Check and install SNES emulator
check-emu:
	@echo "Checking for SNES emulator..."; \
	EMU_FOUND=0; \
	if command -v bsnes >/dev/null 2>&1 || command -v bsnes-hd >/dev/null 2>&1; then \
		EMU_FOUND=1; \
		echo "✓ bsnes found"; \
	elif command -v higan >/dev/null 2>&1; then \
		EMU_FOUND=1; \
		echo "✓ higan found"; \
	fi; \
	if [ $$EMU_FOUND -eq 0 ]; then \
		echo "SNES emulator not found."; \
		if command -v yay >/dev/null 2>&1; then \
			if yay -Si bsnes-hd >/dev/null 2>&1; then \
				echo "Installing bsnes-hd from AUR..."; \
				yay -S --noconfirm bsnes-hd || (echo "Installation failed. Try: yay -S bsnes-hd" && exit 1); \
			elif yay -Si higan >/dev/null 2>&1; then \
				echo "Installing higan from AUR..."; \
				yay -S --noconfirm higan || (echo "Installation failed. Try: yay -S higan" && exit 1); \
			fi; \
		elif command -v paru >/dev/null 2>&1; then \
			if paru -Si bsnes-hd >/dev/null 2>&1; then \
				echo "Installing bsnes-hd from AUR..."; \
				paru -S --noconfirm bsnes-hd || (echo "Installation failed. Try: paru -S bsnes-hd" && exit 1); \
			elif paru -Si higan >/dev/null 2>&1; then \
				echo "Installing higan from AUR..."; \
				paru -S --noconfirm higan || (echo "Installation failed. Try: paru -S higan" && exit 1); \
			fi; \
		fi; \
	fi

# ============================================================================
# Build Targets
# ============================================================================

# Default target: build all demos
all: check-cc65 check-python
	@echo "Building all SNES test demos..."; \
	for demo in $(DEMOS); do \
		if [ -d "$$demo" ] && [ -f "$$demo/Makefile" ]; then \
			echo ""; \
			echo "Building $$demo..."; \
			$(MAKE) -C "$$demo" || exit 1; \
		fi; \
	done; \
	echo ""; \
	echo "✓ All demos built successfully"

# Build individual demo
$(DEMOS): check-cc65 check-python
	@if [ -d "$@" ] && [ -f "$@/Makefile" ]; then \
		echo "Building $@..."; \
		$(MAKE) -C "$@"; \
	else \
		echo "Error: Demo '$@' not found or has no Makefile"; \
		exit 1; \
	fi

# Clean all demos
clean:
	@echo "Cleaning all SNES test demos..."; \
	for demo in $(DEMOS); do \
		if [ -d "$$demo" ] && [ -f "$$demo/Makefile" ]; then \
			$(MAKE) -C "$$demo" clean || true; \
		fi; \
	done; \
	echo "✓ Clean complete"

# ============================================================================
# Help Target
# ============================================================================

help:
	@echo "SNES Test Demos Build System"
	@echo ""
	@echo "Targets:"
	@echo "  make              - Build all test demos (default)"
	@echo "  make <demo_name>  - Build specific demo"
	@echo "  make clean        - Clean all demos"
	@echo "  make check-cc65   - Check for cc65 toolchain"
	@echo "  make check-python - Check for python3"
	@echo "  make check-wla-dx - Check for wla-dx (SPC700 demos)"
	@echo "  make check-emu    - Check for SNES emulator"
	@echo "  make help         - Show this help"
	@echo ""
	@echo "Available Demos:"
	@echo "  Standard Assembly:"
	@echo "    colourmath, smalltext, dizworld, elasticity, extbgtest,"
	@echo "    palcycle, twoship, multest"
	@echo "  C Code (require runtime.lib):"
	@echo "    ctrltest, mset"
	@echo "  SPC700 Audio (require wla-dx):"
	@echo "    iplfast, noise31"
	@echo ""
	@echo "Requirements (auto-installed if missing):"
	@echo "  - cc65 toolchain (ca65, ld65, cc65)"
	@echo "  - python3 (for checksum calculation)"
	@echo "  - wla-dx (for SPC700 demos: iplfast, noise31)"
	@echo "  - bsnes, bsnes-hd, or higan (emulator, optional)"
	@echo ""
	@echo "Credits: Test demos by Brad Smith (rainwarrior)"
	@echo "         https://github.com/rainwarrior/snes-stuff"
