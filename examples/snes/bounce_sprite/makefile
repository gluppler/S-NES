# Makefile for bounce_sprite - Modular Structure
# Based on Structure_Sprites/11_snes_cradle pattern

# Toolchain
CA65 = ca65
LD65 = ld65

# Directories
SRCDIR = src
COMMONDIR = $(SRCDIR)/common
PPUDIR = $(SRCDIR)/PPU
GAMEDIR = $(SRCDIR)/Game
ASSETSDIR = assets

# Source files
COMMON_SRCS = $(COMMONDIR)/InitSNES.s $(COMMONDIR)/Vector.s
PPU_SRCS = $(PPUDIR)/PPU.s
GAME_SRCS = $(GAMEDIR)/Init.s $(GAMEDIR)/Physics.s
ASSETS_SRCS = $(ASSETSDIR)/Assets.s
MAIN_SRC = $(SRCDIR)/Main.s

ALL_SRCS = $(COMMON_SRCS) $(PPU_SRCS) $(GAME_SRCS) $(ASSETS_SRCS) $(MAIN_SRC)

# Object files
OBJS = $(ALL_SRCS:.s=.o)

# Target
TARGET = BouncingSprite.smc
CFG = MemoryMap.cfg

# Include paths for ca65
INCLUDES = -I $(SRCDIR) -I $(COMMONDIR) -I $(PPUDIR) -I $(GAMEDIR) -I $(ASSETSDIR)

# Assembler flags
CA65FLAGS = --cpu 65816 -s $(INCLUDES)

# Default target
all: $(TARGET)

# Link object files into ROM
$(TARGET): $(OBJS) $(CFG)
	$(LD65) -C $(CFG) $(OBJS) -o $(TARGET)

# Compile assembly files
%.o: %.s
	$(CA65) $(CA65FLAGS) -o $@ $<

# Run the ROM in an emulator
EMU ?= bsnes
run: $(TARGET)
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

# Clean build artifacts
clean:
	rm -f $(OBJS) $(TARGET)

.PHONY: all clean run
