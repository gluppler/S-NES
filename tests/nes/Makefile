# ============================================================================
# NES Test ROMs Build System
# ============================================================================
# Build system for NES test ROMs
# Uses cc65 toolchain (ca65/ld65)
# ============================================================================

# Toolchain
CA65    = ca65
LD65    = ld65
EMU    ?= mesen2    # Default emulator

# Test directories (all 64 tests)
TESTS := 240pee apu_mixer apu_mixer_recordings apu_reset apu_test \
         blargg_apu_2005.07.30 blargg_litewall blargg_nes_cpu_test5 \
         blargg_ppu_tests_2005.09.15b branch_timing_tests cpu_dummy_reads \
         cpu_dummy_writes cpu_exec_space cpu_interrupts_v2 cpu_reset \
         cpu_timing_test6 dmc_dma_during_read4 dmc_tests dpcmletterbox \
         exram fdsirqtests full_palette instr_misc instr_test-v3 \
         instr_test-v5 instr_timing m22chrbankingtest MMC1_A12 \
         mmc3_irq_tests mmc3_test mmc3_test_2 mmc5test mmc5test_v2 \
         nes15-1.0.0 nes_instr_test nmi_sync nrom368 ny2011 oam_read \
         oam_stress other PaddleTest3 pal_apu_tests ppu_open_bus \
         ppu_read_buffer ppu_vbl_nmi read_joy3 scanline scanline-a1 \
         scrolltest soundtest sprdma_and_dmc_dma spritecans-2011 \
         sprite_hit_tests_2005.10.05 sprite_overflow_tests stars_se \
         stomper stress tutor tvpassfail vaus-test vbl_nmi_timing \
         volume_tests window5

# Note: Not all tests have Makefiles. Tests with Makefiles will be built.
# Tests without Makefiles may need manual building or have different build systems.

# Phony targets
.PHONY: all clean help check-cc65 check-emu check-python $(TESTS)

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

# Check and install NES emulator
check-emu:
	@echo "Checking for NES emulator..."; \
	EMU_FOUND=0; \
	if command -v mesen2 >/dev/null 2>&1 || command -v mesen >/dev/null 2>&1; then \
		EMU_FOUND=1; \
		echo "✓ Mesen2/Mesen found"; \
	elif command -v fceux >/dev/null 2>&1; then \
		EMU_FOUND=1; \
		echo "✓ FCEUX found"; \
	elif command -v nestopia >/dev/null 2>&1; then \
		EMU_FOUND=1; \
		echo "✓ Nestopia found"; \
	elif command -v nintendulator >/dev/null 2>&1; then \
		EMU_FOUND=1; \
		echo "✓ Nintendulator found"; \
	fi; \
	if [ $$EMU_FOUND -eq 0 ]; then \
		echo "NES emulator not found."; \
		if command -v yay >/dev/null 2>&1; then \
			if yay -Si mesen2 >/dev/null 2>&1; then \
				echo "Installing mesen2 from AUR..."; \
				yay -S --noconfirm mesen2 || (echo "Installation failed. Try: yay -S mesen2" && exit 1); \
			elif yay -Si fceux >/dev/null 2>&1; then \
				echo "Installing fceux from AUR..."; \
				yay -S --noconfirm fceux || (echo "Installation failed. Try: yay -S fceux" && exit 1); \
			fi; \
		elif command -v paru >/dev/null 2>&1; then \
			if paru -Si mesen2 >/dev/null 2>&1; then \
				echo "Installing mesen2 from AUR..."; \
				paru -S --noconfirm mesen2 || (echo "Installation failed. Try: paru -S mesen2" && exit 1); \
			elif paru -Si fceux >/dev/null 2>&1; then \
				echo "Installing fceux from AUR..."; \
				paru -S --noconfirm fceux || (echo "Installation failed. Try: paru -S fceux" && exit 1); \
			fi; \
		fi; \
	fi

# ============================================================================
# Build Targets
# ============================================================================

# Default target: build all tests with Makefiles
all: check-cc65 check-python
	@echo "Building all NES test ROMs with Makefiles..."; \
	BUILT=0; \
	FAILED=0; \
	SKIPPED=0; \
	SKIPPED_NES_ONLY=0; \
	for test in $(TESTS); do \
		if [ -d "$$test" ]; then \
			# Check if test only has .nes files (no source files) \
			HAS_NES=$$(find "$$test" -maxdepth 1 -type f \( -iname "*.nes" -o -iname "*.NES" \) 2>/dev/null | wc -l | tr -d ' '); \
			HAS_SOURCE=$$(find "$$test" -maxdepth 1 -type f \( -name "*.asm" -o -name "*.a" -o -name "*.s" -o -name "*.ASM" -o -name "*.A" -o -name "*.S" \) 2>/dev/null | wc -l | tr -d ' '); \
			if [ -d "$$test/source" ]; then \
				HAS_SOURCE_DIR=$$(find "$$test/source" -type f \( -name "*.asm" -o -name "*.a" -o -name "*.s" \) ! -path "*/common/*" 2>/dev/null | wc -l | tr -d ' '); \
			else \
				HAS_SOURCE_DIR=0; \
			fi; \
			if [ "$$HAS_NES" -gt 0 ] && [ "$$HAS_SOURCE" -eq 0 ] && [ "$$HAS_SOURCE_DIR" -eq 0 ]; then \
				SKIPPED_NES_ONLY=$$((SKIPPED_NES_ONLY + 1)); \
				continue; \
			fi; \
			if [ -f "$$test/Makefile" ] || [ -f "$$test/makefile" ]; then \
				echo ""; \
				echo "Building $$test..."; \
				if $(MAKE) -C "$$test" >/dev/null 2>&1; then \
					BUILT=$$((BUILT + 1)); \
					echo "✓ $$test built successfully"; \
				else \
					FAILED=$$((FAILED + 1)); \
					echo "✗ $$test build failed"; \
				fi; \
			else \
				SKIPPED=$$((SKIPPED + 1)); \
			fi; \
		fi; \
	done; \
	echo ""; \
	echo "Build summary: $$BUILT built, $$FAILED failed, $$SKIPPED skipped (no Makefile), $$SKIPPED_NES_ONLY skipped (pre-built ROMs only)"; \
	if [ $$FAILED -gt 0 ]; then \
		echo ""; \
		echo "Common issues with failed tests:"; \
		echo "  - Hardcoded paths (check CC65, AS65, LD65 variables in Makefile)"; \
		echo "  - Wrong file extensions (.asm vs .s)"; \
		echo "  - Missing tools (dasm, pcx2chr, etc.)"; \
		echo "  - Windows-specific commands (copy vs cat)"; \
		echo "  - Missing source files or dependencies"; \
		echo ""; \
		echo "To debug a specific test, run: make <test_name>"; \
	fi

# Build individual test
$(TESTS): check-cc65 check-python
	@if [ -d "$@" ]; then \
		# Check if test only has .nes files (no source) \
		HAS_NES=$$(find "$@" -maxdepth 1 -type f \( -iname "*.nes" -o -iname "*.NES" \) 2>/dev/null | wc -l | tr -d ' '); \
		HAS_SOURCE=$$(find "$@" -maxdepth 1 -type f \( -name "*.asm" -o -name "*.a" -o -name "*.s" -o -name "*.ASM" -o -name "*.A" -o -name "*.S" \) 2>/dev/null | wc -l | tr -d ' '); \
		if [ -d "$@/source" ]; then \
			HAS_SOURCE_DIR=$$(find "$@/source" -type f \( -name "*.asm" -o -name "*.a" -o -name "*.s" \) ! -path "*/common/*" 2>/dev/null | wc -l | tr -d ' '); \
		else \
			HAS_SOURCE_DIR=0; \
		fi; \
		if [ "$$HAS_NES" -gt 0 ] && [ "$$HAS_SOURCE" -eq 0 ] && [ "$$HAS_SOURCE_DIR" -eq 0 ]; then \
			echo "Skipping '$@': Only contains pre-built .nes files (no source files)."; \
			exit 0; \
		fi; \
		if [ -f "$@/Makefile" ] || [ -f "$@/makefile" ]; then \
			echo "Building $@..."; \
			$(MAKE) -C "$@" || (echo ""; echo "Build failed. Common issues:"; \
				echo "  - Hardcoded paths in Makefile (check CC65, AS65, LD65 variables)"; \
				echo "  - Missing source files or wrong file extensions"; \
				echo "  - Missing tools (dasm, pcx2chr, etc.)"; \
				echo "  - Windows-specific commands (copy, etc.)"; \
				echo "Check $@/Makefile or $@/makefile for details."; exit 1); \
		else \
			echo "Error: Test '$@' has no Makefile or makefile."; \
			echo "Check the test directory for manual build instructions."; \
			exit 1; \
		fi; \
	else \
		echo "Error: Test '$@' not found"; \
		exit 1; \
	fi

# Clean all tests
clean:
	@echo "Cleaning all NES test ROMs..."; \
	CLEANED=0; \
	for test in $(TESTS); do \
		if [ -d "$$test" ]; then \
			if [ -f "$$test/Makefile" ] || [ -f "$$test/makefile" ]; then \
				if $(MAKE) -C "$$test" clean >/dev/null 2>&1; then \
					CLEANED=$$((CLEANED + 1)); \
				fi; \
			fi; \
		fi; \
	done; \
	echo "✓ Cleaned $$CLEANED tests"

# ============================================================================
# Help Target
# ============================================================================

help:
	@echo "NES Test ROMs Build System"
	@echo ""
	@echo "Targets:"
	@echo "  make              - Build all test ROMs with Makefiles (default)"
	@echo "  make <test_name>  - Build specific test"
	@echo "  make clean        - Clean all tests"
	@echo "  make check-cc65   - Check for cc65 toolchain"
	@echo "  make check-python - Check for python3"
	@echo "  make check-emu    - Check for NES emulator"
	@echo "  make help         - Show this help"
	@echo ""
	@echo "Test Categories:"
	@echo "  CPU Tests:"
	@echo "    blargg_nes_cpu_test5, cpu_timing_test6, cpu_interrupts_v2,"
	@echo "    cpu_reset, cpu_dummy_reads, cpu_dummy_writes, cpu_exec_space,"
	@echo "    instr_test-v5, instr_timing, branch_timing_tests, instr_misc,"
	@echo "    nes_instr_test"
	@echo "  PPU Tests:"
	@echo "    blargg_ppu_tests_2005.09.15b, ppu_vbl_nmi, ppu_read_buffer,"
	@echo "    ppu_open_bus, sprite_hit_tests_2005.10.05, sprite_overflow_tests,"
	@echo "    oam_read, oam_stress"
	@echo "  APU Tests:"
	@echo "    apu_test, apu_reset, apu_mixer, blargg_apu_2005.07.30,"
	@echo "    pal_apu_tests, volume_tests"
	@echo "  Mapper Tests:"
	@echo "    mmc3_test, mmc3_irq_tests, mmc3_test_2, mmc5test_v2, MMC1_A12"
	@echo "  Timing Tests:"
	@echo "    nmi_sync, vbl_nmi_timing, scanline, scanline-a1"
	@echo "  Specialized Tests:"
	@echo "    dmc_dma_during_read4, dpcmletterbox, full_palette, read_joy3"
	@echo ""
	@echo "Requirements (auto-installed if missing):"
	@echo "  - cc65 toolchain (ca65, ld65)"
	@echo "  - python3 (for some tests with Python scripts)"
	@echo "  - NES emulator: mesen2, fceux, nestopia, or nintendulator (optional)"
	@echo ""
	@echo "Note: Not all tests have Makefiles. Tests without Makefiles may"
	@echo "      require manual building. See individual test directories for"
	@echo "      build instructions."
	@echo ""
	@echo "Common build issues:"
	@echo "  - Hardcoded paths: Some Makefiles have Windows/Linux-specific paths"
	@echo "  - Missing tools: Some tests require dasm, pcx2chr, or other tools"
	@echo "  - File extensions: Some tests use .asm instead of .s"
	@echo "  - Windows commands: Some Makefiles use 'copy' instead of 'cat'"
