# Getting Started with NES Development on Linux

Complete guide to setting up a NES development environment on Linux. This guide is **Linux-only** and assumes a modern Linux distribution.

## Prerequisites

- Linux distribution (Debian/Ubuntu, Arch Linux, Fedora, or similar)
- Root/sudo access for package installation
- Terminal access
- Internet connection for downloading packages

## Required Tools

### Core Development Tools

1. **cc65** - C compiler and 6502 assembler (ca65/ld65)
2. **Git** - Version control
3. **Make** - Build automation
4. **NES Emulator** - For testing (Mesen2 recommended)
5. **Text Editor** - Your choice (vim, nano, VS Code, etc.)

## Installation by Distribution

### Debian/Ubuntu/Debian-based

```bash
# Update package list
sudo apt-get update

# Install essential build tools
sudo apt-get install -y build-essential git make

# Install cc65
sudo apt-get install -y cc65

# Verify installation
ca65 --version
ld65 --version
```

### Arch Linux/Manjaro

```bash
# Update package database
sudo pacman -Syu

# Install essential build tools
sudo pacman -S --needed base-devel git

# Install cc65
sudo pacman -S cc65

# Verify installation
ca65 --version
ld65 --version
```

### Fedora/RHEL/CentOS

```bash
# Install essential build tools
sudo dnf install -y gcc make git

# Install cc65 from source (see below) or use copr repository
# For copr (if available):
# sudo dnf copr enable user/cc65
# sudo dnf install cc65
```

### Generic Linux (From Source)

If your distribution doesn't have cc65 in repositories:

```bash
# Install build dependencies
sudo apt-get install -y build-essential git  # Debian/Ubuntu
# OR
sudo pacman -S --needed base-devel git      # Arch
# OR
sudo dnf install -y gcc make git            # Fedora

# Clone and build cc65
cd /tmp
git clone https://github.com/cc65/cc65.git
cd cc65
make
sudo make install

# Verify installation
ca65 --version
ld65 --version
```

## NES Emulator Installation

### Mesen2 (Recommended - Best Debugger)

**Debian/Ubuntu:**
```bash
# Download latest AppImage from GitHub releases
cd ~/Downloads
wget https://github.com/SourMesen/Mesen2/releases/latest/download/Mesen2-x64.AppImage
chmod +x Mesen2-x64.AppImage

# Move to local bin directory
mkdir -p ~/.local/bin
mv Mesen2-x64.AppImage ~/.local/bin/mesen2
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Verify
mesen2 --version
```

**Arch Linux:**
```bash
# Install from AUR
yay -S mesen2
# OR
paru -S mesen2
```

**Manual Installation (All Distributions):**
```bash
# Download AppImage
cd ~/Downloads
wget https://github.com/SourMesen/Mesen2/releases/latest/download/Mesen2-x64.AppImage
chmod +x Mesen2-x64.AppImage

# Create desktop entry (optional)
mkdir -p ~/.local/share/applications
cat > ~/.local/share/applications/mesen2.desktop << EOF
[Desktop Entry]
Name=Mesen2
Exec=$HOME/Downloads/Mesen2-x64.AppImage
Icon=application-x-executable
Type=Application
Categories=Development;Emulator;
EOF
```

### FCEUX (Alternative)

**Debian/Ubuntu:**
```bash
sudo apt-get install -y fceux
```

**Arch Linux:**
```bash
sudo pacman -S fceux
```

**Fedora:**
```bash
sudo dnf install fceux
```

**From Source:**
```bash
cd /tmp
git clone https://github.com/TASVideos/fceux.git
cd fceux
mkdir build && cd build
cmake ..
make
sudo make install
```

## Development Environment Setup

### 1. Create Project Directory

```bash
mkdir -p ~/nes-dev
cd ~/nes-dev
```

### 2. Clone or Use Template

```bash
# Option A: Use the template from this repository
cd ~/nes-dev
cp -r /path/to/NES/template my-nes-game
cd my-nes-game

# Option B: Create from scratch (see template structure)
mkdir my-nes-game
cd my-nes-game
```

### 3. Verify Build System

```bash
# Test compilation
make clean
make

# Should produce template.nes (or your target .nes file)
ls -lh *.nes
```

### 4. Test in Emulator

```bash
# With Mesen2
fceux template.nes

# With FCEUX
fceux template.nes

# Or set up Makefile to run automatically
# make run
```

## Project Structure

Your NES project should follow this structure:

```
my-nes-game/
├── main.asm        # Main assembly source
├── nes.cfg         # Linker configuration
├── Makefile        # Build system
├── chars.chr       # CHR ROM (tile graphics)
└── README.md       # Project documentation
```

## Essential Configuration Files

### Makefile Example

```makefile
AS = ca65
LD = ld65
CFG = nes.cfg

SOURCES = main.asm
OBJECTS = $(SOURCES:.asm=.o)
TARGET = game.nes

.PHONY: all clean run

all: $(TARGET)

$(TARGET): $(OBJECTS) $(CFG)
	$(LD) -C $(CFG) -o $(TARGET) $(OBJECTS)

%.o: %.asm
	$(AS) $< -o $@

clean:
	rm -f $(OBJECTS) $(TARGET)

run: $(TARGET)
	mesen2 $(TARGET) || fceux $(TARGET) || echo "Install an NES emulator"
```

### Linker Configuration (nes.cfg)

```cfg
MEMORY {
    HEADER: start = $0000, size = $0010, fill = yes;
    VECTORS: start = $FFFA, size = $0006;
    PRG: start = $8000, size = $8000, fill = yes;
    CHR: start = $0000, size = $2000;
}

SEGMENTS {
    HEADER: load = HEADER, type = ro;
    VECTORS: load = VECTORS, type = ro;
    CODE: load = PRG, type = rw;
    CHARS: load = CHR, type = ro;
}
```

## Verification Steps

### 1. Verify cc65 Installation

```bash
ca65 --version
ld65 --version
cc65 --version
```

Expected output should show version numbers (e.g., "2.19.0").

### 2. Verify Make Installation

```bash
make --version
```

### 3. Verify Git Installation

```bash
git --version
```

### 4. Test Compilation

```bash
cd ~/nes-dev/my-nes-game
make clean
make
file *.nes
```

The `file` command should show: "NES ROM data" or similar.

### 5. Test Emulator

```bash
# Test Mesen2
mesen2 --help

# Test FCEUX
fceux --help
```

## Development Workflow

### Basic Workflow

1. **Edit source code** (`main.asm`)
2. **Build ROM**: `make`
3. **Test in emulator**: `make run` or `mesen2 game.nes`
4. **Debug**: Use emulator debugger (Mesen2 recommended)
5. **Iterate**: Repeat steps 1-4

### Using Mesen2 Debugger

1. **Load ROM**: File → Open ROM
2. **Set breakpoints**: Debug → Breakpoints → Add
3. **Run**: F5 (run), F10 (step over), F11 (step into)
4. **Inspect**: View → CPU, PPU, Memory
5. **View PPU**: View → PPU Viewer

### Using Command Line Tools

```bash
# Build
make

# Clean and rebuild
make clean && make

# Run in emulator
mesen2 game.nes

# Check ROM size
ls -lh *.nes

# Validate iNES header (optional tool)
# hexdump -C game.nes | head -1
```

## Additional Tools (Optional)

### Graphics Tools

**YY-CHR (Tile Editor):**
- Download from: https://w.atwiki.jp/yychr/
- Requires Wine for Linux: `sudo apt-get install wine` (Debian/Ubuntu)

**Aseprite (Sprite Editor):**
- Available on Linux via Steam or compile from source
- Website: https://www.aseprite.org/

### Audio Tools

**FamiTracker:**
- Download from: https://github.com/Dn-Programming-Core-Management/0CC-FamiTracker
- Requires Wine or compile from source

**FamiTone2:**
- Included in many NES projects
- Repository: https://github.com/nesdoug/FamiTone2

### Version Control

```bash
# Initialize git repository
cd ~/nes-dev/my-nes-game
git init
git add .
git commit -m "Initial NES project"

# Create .gitignore
cat > .gitignore << EOF
*.o
*.nes
*.lst
*.map
*.cfg.bak
EOF
```

## Troubleshooting

### cc65 Not Found

```bash
# Check if in PATH
which ca65

# If not found, add to PATH or reinstall
export PATH="/usr/local/bin:$PATH"

# Verify installation location
find /usr -name "ca65" 2>/dev/null
```

### Build Errors

**"ca65: command not found"**
```bash
# Install cc65 (see installation section)
sudo apt-get install cc65  # Debian/Ubuntu
sudo pacman -S cc65        # Arch
```

**"ld65: undefined symbol"**
- Check linker configuration (`nes.cfg`)
- Verify segment names match in source files
- Check memory map addresses

**"Cannot open input file"**
- Verify file paths in Makefile
- Check file permissions: `chmod 644 *.asm`

### Emulator Issues

**Mesen2 won't run:**
```bash
# Make AppImage executable
chmod +x Mesen2-x64.AppImage

# Check dependencies
ldd Mesen2-x64.AppImage  # May show missing libraries

# Install required libraries (example for Debian/Ubuntu)
sudo apt-get install libfuse2
```

**FCEUX won't start:**
```bash
# Check if installed correctly
which fceux

# Run with verbose output
fceux --verbose game.nes
```

### ROM Won't Boot

1. **Check iNES header**: Verify header bytes in `main.asm`
2. **Check reset vector**: Must point to valid code
3. **Verify initialization**: Ensure proper PPU/APU setup
4. **Test in multiple emulators**: Try Mesen2 and FCEUX

## Environment Variables (Optional)

Add to `~/.bashrc` or `~/.zshrc`:

```bash
# NES Development Environment
export NES_DEV_HOME="$HOME/nes-dev"
export PATH="$HOME/.local/bin:$PATH"

# Aliases
alias nes-build='make clean && make'
alias nes-run='mesen2'
alias nes-debug='mesen2 --debug'
```

Reload shell:
```bash
source ~/.bashrc
```

## Quick Start Checklist

- [ ] Linux distribution installed and updated
- [ ] cc65 installed and verified (`ca65 --version`)
- [ ] Make installed (`make --version`)
- [ ] Git installed (`git --version`)
- [ ] NES emulator installed (Mesen2 or FCEUX)
- [ ] Project directory created
- [ ] Template or project files in place
- [ ] Build system tested (`make` succeeds)
- [ ] ROM file generated (`*.nes` exists)
- [ ] Emulator can run ROM
- [ ] Debugger accessible (Mesen2)

## Next Steps

1. **Read Documentation**: Review `docs/README.md` for NES programming concepts
2. **Study Examples**: Examine the `template/` directory
3. **Follow Tutorials**: Check `REFERENCES.md` for learning resources
4. **Join Community**: Visit NesDev forums (see `REFERENCES.md`)

## System Requirements

### Minimum

- **CPU**: x86_64 or compatible
- **RAM**: 2 GB
- **Disk**: 500 MB free space
- **OS**: Linux kernel 3.10+ (most modern distributions)

### Recommended

- **CPU**: Multi-core x86_64
- **RAM**: 4 GB+
- **Disk**: 1 GB+ free space
- **OS**: Recent LTS distribution (Ubuntu 20.04+, Debian 11+, Arch Linux)

## Distribution-Specific Notes

### Debian/Ubuntu

- Uses `apt-get` package manager
- Most packages available in default repositories
- May need to enable `universe` repository (Ubuntu)

### Arch Linux

- Uses `pacman` package manager
- AUR provides additional packages (use `yay` or `paru`)
- Rolling release - always up-to-date

### Fedora/RHEL

- Uses `dnf` package manager
- May need to enable additional repositories
- Some packages may require compilation from source

## Support

For issues specific to:

- **cc65**: https://github.com/cc65/cc65/issues
- **Mesen2**: https://github.com/SourMesen/Mesen2/issues
- **FCEUX**: https://github.com/TASVideos/fceux/issues
- **This Project**: See `CONTRIBUTING.md` and open an issue

## References

- [NES Documentation](docs/README.md) - Complete NES programming guide
- [References](REFERENCES.md) - External resources and links
- [Template](template/README.md) - NES template
- [Contributing](CONTRIBUTING.md) - How to contribute

---

**Note**: This guide is **Linux-only**. For other operating systems, see official tool documentation. All commands assume a bash-compatible shell.
