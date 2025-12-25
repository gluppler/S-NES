# SNES Techniques

Applied patterns and reusable approaches for SNES-specific development.

## Overview

Techniques demonstrate hardware-grounded implementation patterns that respect SNES hardware constraints, provide reusable solutions to common problems, and work within SNES limitations.

## Applied Patterns

- [Sprite Engine Patterns](05-applied-patterns/5.1-sprite-engine-patterns.md) - OAM management, sprite allocation, flicker prevention
- [Scrolling Patterns](05-applied-patterns/5.2-scrolling-patterns.md) - Background scrolling, VRAM management, DMA tile loading
- [Collision Systems](05-applied-patterns/5.3-collision-systems.md) - Tile-based and bounding box collision detection
- [Animation Systems](05-applied-patterns/5.4-animation-systems.md) - Frame tables, timers, state-driven animation
- [Audio Integration](05-applied-patterns/5.5-audio-integration.md) - SPC700 communication, music/SFX priority

## Related Documentation

- [SNES Documentation Index](../README.md) - Complete SNES documentation
- [Programming Guides](../programming/) - Initialization, game loop, rendering, input
- [Hardware Documentation](../hardware/) - CPU, PPU, DMA, audio, memory
