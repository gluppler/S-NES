# SNES Toolchain Setup

## Required Tools

SNES development requires specific assemblers and tools:

### Primary Assemblers

1. **ca65** (cc65 toolchain)
   - 65816 assembler
   - Part of cc65 package
   - Most common for SNES development

2. **wla-dx**
   - Multi-system assembler
   - Excellent SNES support
   - Supports SPC700 assembly

3. **asar**
   - SNES-focused assembler
   - Used for ROM hacking
   - Good for SNES development

4. **bass**
   - Multi-system assembler
   - Modern syntax
   - Good SNES support

## Installation

### ca65 (cc65)

**Linux (Arch)**:
```bash
yay -S cc65  # or paru -S cc65
```

**Linux (Debian/Ubuntu)**:
```bash
sudo apt-get install cc65
```

**macOS**:
```bash
brew install cc65
```

**Windows**:
Download from https://cc65.github.io/

### wla-dx

**Linux (Arch)**:
```bash
yay -S wla-dx  # or paru -S wla-dx
```

**Linux (Debian/Ubuntu)**:
```bash
sudo apt-get install wla-dx
```

**macOS**:
```bash
brew install wla-dx
```

**Windows**:
Download from https://github.com/vhelin/wla-dx/releases

### asar

**Linux/macOS**:
```bash
# Download from https://github.com/RPGHacker/asar/releases
# Extract and add to PATH
```

**Windows**:
Download from https://github.com/RPGHacker/asar/releases

### bass

**Linux/macOS**:
```bash
# Download from https://github.com/ARM9/bass/releases
# Extract and add to PATH
```

**Windows**:
Download from https://github.com/ARM9/bass/releases

## Linker Configuration

### ca65 (ld65)

SNES linker config for LoROM:

```cfg
MEMORY {
    ROM0: start = $808000, size = $8000, fill = yes;
    ROM1: start = $818000, size = $8000, fill = yes;
    ...
}

SEGMENTS {
    CODE: load = ROM0, type = ro;
    SNESHEADER: load = ROM0, start = $80FFB0;
    VECTOR: load = ROM0, start = $80FFE4;
}
```

### wla-dx

```asm
.MEMORYMAP
SLOTSIZE $8000
DEFAULTSLOT 0
SLOT 0 $8000
.ENDME

.ROMBANKSIZE $8000
.ROMBANKS 1
```

## Build System

### Makefile Example (ca65)

```makefile
CA65 = ca65
LD65 = ld65

TARGET = game.sfc
SOURCES = main.asm
OBJECTS = $(SOURCES:.asm=.o)
CONFIG = snes.cfg

all: $(TARGET)

$(TARGET): $(OBJECTS) $(CONFIG)
	$(LD65) -C $(CONFIG) $(OBJECTS) -o $(TARGET)

%.o: %.asm
	$(CA65) --cpu 65816 -o $@ $<

clean:
	rm -f $(OBJECTS) $(TARGET)
```

## Assembler Comparison

| Feature | ca65 | wla-dx | asar | bass |
|---------|------|--------|------|------|
| 65816 Support | ✅ | ✅ | ✅ | ✅ |
| SPC700 Support | ❌ | ✅ | ✅ | ✅ |
| LoROM/HiROM | ✅ | ✅ | ✅ | ✅ |
| Syntax | Traditional | Modern | Traditional | Modern |
| ROM Hacking | ❌ | ❌ | ✅ | ❌ |
| Documentation | Good | Good | Good | Good |

## Recommended Toolchain

For new SNES projects:
- **ca65 + ld65**: Most common, well-documented
- **wla-dx**: If you need SPC700 support in same project

## Next Steps

- [First SNES Program](03-first-program.md) - Write your first program
- [Understanding 65816](04-understanding-65816.md) - Learn the CPU
