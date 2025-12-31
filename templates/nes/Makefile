# ============================================================================
# NES Template Build System
# ============================================================================
# Build system for NES template with modular architecture
# Follows NES documentation best practices
# Auto-installs missing dependencies
# ============================================================================

# Toolchain
AS = ca65
LD = ld65
CFG = linker/nrom.cfg

# Emulator selection (default: fceux)
EMULATOR ?= fceux

# Source files
MAIN_SOURCE = src/main.asm
SOURCES = $(shell find src -name "*.asm" -o -name "*.inc" | sort)

# Files included in main.asm should NOT be compiled separately
# These are included with .include, so they become part of main.asm's object file
EXCLUDE_FROM_OBJECTS = \
	src/sprites/sprite_dma.asm \
	src/input/controller.asm \
	src/input/debounce.asm \
	src/ppu/ppu_init.asm \
	src/ppu/ppu_write.asm \
	src/ppu/scrolling.asm \
	src/tilemap/tilemap_loader.asm \
	src/game/entities.asm \
	src/screens/welcome.asm \
	src/screens/game.asm \
	src/ppu/attributes.asm

# Compile only .asm files that are NOT included in main.asm
ALL_ASM = $(shell find src -name "*.asm")
STANDALONE_ASM = $(filter-out $(EXCLUDE_FROM_OBJECTS),$(ALL_ASM))
ALL_OBJECTS = $(patsubst src/%.asm,build/obj/%.o,$(STANDALONE_ASM))
# Ensure reset.o is linked first so its strings are placed early
RESET_OBJ = build/obj/reset.o
OTHER_OBJECTS = $(filter-out $(RESET_OBJ),$(ALL_OBJECTS))
OBJECTS = $(RESET_OBJ) $(OTHER_OBJECTS)

# Target ROM
TARGET = build/rom/game.nes

# Phony targets
.PHONY: all clean distclean run verify help check-cc65 check-emu check-python

# ============================================================================
# Dependency Installation
# ============================================================================

# Install package using detected package manager
define install-package
	@if command -v yay >/dev/null 2>&1; then \
		echo "Installing $(1) via yay..."; \
		yay -S --noconfirm $(1) || (echo "Installation failed. Try: yay -S $(1)" && exit 1); \
	elif command -v paru >/dev/null 2>&1; then \
		echo "Installing $(1) via paru..."; \
		paru -S --noconfirm $(1) || (echo "Installation failed. Try: paru -S $(1)" && exit 1); \
	elif command -v pacman >/dev/null 2>&1; then \
		if pacman -Si $(1) >/dev/null 2>&1; then \
			echo "Installing $(1) via pacman..."; \
			sudo pacman -S --noconfirm $(1) || (echo "Installation failed. Try: sudo pacman -S $(1)" && exit 1); \
		else \
			echo "$(1) not in official repos. Install AUR helper (yay/paru) or: yay -S $(1)"; \
			exit 1; \
		fi; \
	elif command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then \
		echo "Installing $(1) via apt..."; \
		sudo apt-get update && sudo apt-get install -y $(1) || (echo "Installation failed. Try: sudo apt-get install $(1)" && exit 1); \
	elif command -v dnf >/dev/null 2>&1; then \
		echo "Installing $(1) via dnf..."; \
		sudo dnf install -y $(1) || (echo "Installation failed. Try: sudo dnf install $(1)" && exit 1); \
	elif command -v yum >/dev/null 2>&1; then \
		echo "Installing $(1) via yum..."; \
		sudo yum install -y $(1) || (echo "Installation failed. Try: sudo yum install $(1)" && exit 1); \
	elif command -v zypper >/dev/null 2>&1; then \
		echo "Installing $(1) via zypper..."; \
		sudo zypper install -y $(1) || (echo "Installation failed. Try: sudo zypper install $(1)" && exit 1); \
	else \
		echo "Error: Could not detect package manager."; \
		echo "Please install $(1) manually for your distribution."; \
		exit 1; \
	fi
endef

# Check and install cc65 toolchain
check-cc65:
	@echo "Checking for cc65 toolchain..."; \
	if command -v $(AS) >/dev/null 2>&1 && command -v $(LD) >/dev/null 2>&1; then \
		echo "✓ cc65 already installed ($(AS), $(LD))"; \
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
		elif command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then \
			if dpkg -l | grep -q "^ii.*cc65 "; then \
				PKG_INSTALLED=1; \
				echo "cc65 package is installed but tools not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v dnf >/dev/null 2>&1; then \
			if dnf list installed cc65 >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "cc65 package is installed but tools not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v yum >/dev/null 2>&1; then \
			if yum list installed cc65 >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "cc65 package is installed but tools not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v zypper >/dev/null 2>&1; then \
			if zypper search -i cc65 >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "cc65 package is installed but tools not in PATH. Check your PATH."; \
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
			if ! command -v $(AS) >/dev/null 2>&1 || ! command -v $(LD) >/dev/null 2>&1; then \
				echo "Error: cc65 installation completed but tools not found. Restart terminal or check PATH."; \
				exit 1; \
			fi; \
			echo "✓ cc65 installed successfully"; \
		fi; \
	fi

# Check and install emulator
check-emu:
	@echo "Checking for $(EMULATOR)..."; \
	if command -v $(EMULATOR) >/dev/null 2>&1; then \
		echo "✓ $(EMULATOR) already installed"; \
	else \
		echo "$(EMULATOR) not found in PATH."; \
		PKG_NAME=$(EMULATOR); \
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
			if ! command -v $(EMULATOR) >/dev/null 2>&1; then \
				echo "Error: $(EMULATOR) installation completed but command not found. Restart terminal or check PATH."; \
				exit 1; \
			fi; \
			echo "✓ $(EMULATOR) installed successfully"; \
		fi; \
	fi

# Check and install Python 3
check-python:
	@echo "Checking for python3..."; \
	if command -v python3 >/dev/null 2>&1; then \
		echo "✓ python3 already installed"; \
	else \
		echo "python3 not found in PATH."; \
		PKG_INSTALLED=0; \
		if command -v yay >/dev/null 2>&1; then \
			if yay -Qi python >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "python package is installed but python3 not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v paru >/dev/null 2>&1; then \
			if paru -Qi python >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "python package is installed but python3 not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v pacman >/dev/null 2>&1; then \
			if pacman -Qi python >/dev/null 2>&1 2>/dev/null || pacman -Si python >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "python package is installed but python3 not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then \
			if dpkg -l | grep -q "^ii.*python3 "; then \
				PKG_INSTALLED=1; \
				echo "python3 package is installed but python3 not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v dnf >/dev/null 2>&1; then \
			if dnf list installed python3 >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "python3 package is installed but python3 not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v yum >/dev/null 2>&1; then \
			if yum list installed python3 >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "python3 package is installed but python3 not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		elif command -v zypper >/dev/null 2>&1; then \
			if zypper search -i python3 >/dev/null 2>&1; then \
				PKG_INSTALLED=1; \
				echo "python3 package is installed but python3 not in PATH. Check your PATH."; \
				exit 1; \
			fi; \
		fi; \
		if [ $$PKG_INSTALLED -eq 0 ]; then \
			echo "python3 package not installed. Installing..."; \
			if command -v yay >/dev/null 2>&1; then \
				echo "Using yay (AUR helper)..."; \
				yay -S --noconfirm python || (echo "Installation failed. Try: yay -S python" && exit 1); \
			elif command -v paru >/dev/null 2>&1; then \
				echo "Using paru (AUR helper)..."; \
				paru -S --noconfirm python || (echo "Installation failed. Try: paru -S python" && exit 1); \
			elif command -v pacman >/dev/null 2>&1; then \
				if pacman -Si python >/dev/null 2>&1; then \
					echo "Using pacman (official repos)..."; \
					sudo pacman -S --noconfirm python || (echo "Installation failed. Try: sudo pacman -S python" && exit 1); \
				else \
					echo "python not in official repos. Install AUR helper (yay/paru) or: yay -S python"; \
					exit 1; \
				fi; \
			elif command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then \
				echo "Using apt..."; \
				sudo apt-get update && sudo apt-get install -y python3 || (echo "Installation failed. Try: sudo apt-get install python3" && exit 1); \
			elif command -v dnf >/dev/null 2>&1; then \
				echo "Using dnf..."; \
				sudo dnf install -y python3 || (echo "Installation failed. Try: sudo dnf install python3" && exit 1); \
			elif command -v yum >/dev/null 2>&1; then \
				echo "Using yum..."; \
				sudo yum install -y python3 || (echo "Installation failed. Try: sudo yum install python3" && exit 1); \
			elif command -v zypper >/dev/null 2>&1; then \
				echo "Using zypper..."; \
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
		fi; \
	fi

# ============================================================================
# Build Targets
# ============================================================================

# Default target: build ROM
all: check-cc65 $(TARGET)

# Create build directories
build/obj build/rom build/map:
	@mkdir -p $@

# Build object files from assembly source
build/obj/%.o: src/%.asm | build/obj check-cc65
	@echo "Assembling $<..."
	@mkdir -p $(dir $@)
	$(AS) -I src -I . $< -o $@

# Link ROM from object files
$(TARGET): $(OBJECTS) $(CFG) | build/rom build/map
	@echo "Linking $(TARGET)..."
	$(LD) -C $(CFG) -o $(TARGET) $(OBJECTS) -m build/map/game.map
	@echo "Patching string address references..."
	@python3 patch_strings.py $(TARGET) || (echo "⚠️  String address patching failed" && exit 0)
	@if [ -f $(TARGET) ]; then \
		SIZE=$$(stat -c%s $(TARGET) 2>/dev/null || echo "unknown"); \
		echo "✓ ROM built: $(TARGET) ($$SIZE bytes)"; \
		echo "Patching interrupt vectors..."; \
		python3 patch_vectors.py build/map/game.map $(TARGET) || (echo "⚠️  Vector patching failed (vectors may be $0000)" && exit 0); \
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
	@rm -rf build/obj build/rom build/map
	@echo "✓ Clean complete"

# Deep clean
distclean: clean
	@echo "Deep cleaning..."
	@echo "✓ Deep clean complete"

# ============================================================================
# Run Targets
# ============================================================================

# Run ROM in selected emulator (fceux)
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
# Verify Targets
# ============================================================================

# Verify ROM structure
verify: check-python $(TARGET)
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

help:
	@echo "NES Template Build System"
	@echo ""
	@echo "Targets:"
	@echo "  make                    - Build ROM (default)"
	@echo "  make clean              - Remove build artifacts"
	@echo "  make distclean          - Deep clean"
	@echo "  make run                - Run ROM with default emulator (fceux)"
	@echo "  make verify              - Verify ROM structure"
	@echo "  make help               - Show this help"
	@echo ""
	@echo "Requirements (auto-installed if missing):"
	@echo "  - cc65 (ca65, ld65)"
	@echo "  - fceux (NES emulator)"
	@echo "  - python3 (for verify target)"
