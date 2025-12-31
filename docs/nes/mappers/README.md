# NES Mapper Documentation

This directory contains comprehensive documentation for NES cartridge mappers.

## Overview

Mappers are hardware chips on NES cartridges that handle memory mapping, allowing games to use more ROM/RAM than the NES's native address space supports.

## Documentation Files

Each mapper has its own documentation file numbered by mapper number (e.g., `000.txt` for Mapper 0/NROM).

### Key Mappers

- **Mapper 000 (NROM)**: No mapper, simplest cartridge type
- **Mapper 001 (MMC1)**: Most common mapper, used in many popular games
- **Mapper 002 (UxROM)**: Used in Mega Man, Castlevania, Contra
- **Mapper 003 (CNROM)**: Used in Arkanoid, Solomon's Key
- **Mapper 004 (MMC3)**: Very common, used in Super Mario Bros. 2/3
- **Mapper 005 (MMC5)**: Advanced mapper with many features

### Reading Mapper Docs

See `__ READ THIS FIRST __.txt` for explanation of notation and conventions used in mapper documentation.

## Source

This documentation was integrated from external mapper documentation sources and has been verified, normalized, and integrated into the S-NES-BOY framework. All mapper documentation is now maintained in this directory.

---
**Last Updated:** 2025-12-31
