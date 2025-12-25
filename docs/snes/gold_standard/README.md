# SNES Gold Standard Examples

This directory contains **hardware-accurate reference implementations** demonstrating correct SNES programming patterns. These examples serve as authoritative references for hardware-accurate SNES development.

## Important Note

**"Gold Standard" in this context means hardware-accurate reference implementations**, not Nintendo's Seal of Quality (which was a licensing/quality assurance program for commercial games). These examples are technical references demonstrating correct hardware usage, not commercial quality certifications.

## Purpose

Examples placed here must be:
- **Verified to work on real hardware**: Tested on actual SNES hardware or verified emulators (bsnes, higan)
- **Demonstrating correct hardware behavior**: Show proper use of SNES hardware features with hardware-accurate timing
- **Clearly documented with hardware rationale**: Explain why the implementation is correct, referencing authoritative sources
- **Serving as reference implementations**: Can be used as templates for similar functionality
- **Traceable to authoritative sources**: Based on Super Wiki, official documentation, or verified hardware behavior

## Current Status

This directory is currently empty. Gold-standard examples will be added only when verified, authoritative reference implementations become available.

Examples will only be added if they:
1. Are from official Nintendo documentation or widely recognized authoritative sources
2. Have been verified to work correctly on real SNES hardware by multiple independent sources
3. Are traceable to official documentation or verified hardware behavior
4. Include complete documentation with authoritative source citations

## Adding New Examples

When adding new gold-standard examples:

1. **Verify on hardware**: Test the example works on real SNES hardware (not just emulators)
2. **Document behavior**: Explain the hardware behavior being demonstrated
3. **Explain correctness**: Describe why the implementation is correct, referencing Super Wiki or official documentation
4. **Reference sources**: Link to authoritative documentation (Super Wiki, official SNES documentation)
5. **Include instructions**: Provide build instructions and requirements
6. **Hardware verification**: Include evidence of real hardware testing or reference to verified implementations

**Important**: Only examples from official Nintendo documentation, verified test ROMs, or widely recognized authoritative sources that have been independently verified on real hardware will be included. Third-party GitHub repositories or unverified examples will not be added.

## Related Documentation

- [SNES Documentation Index](../README.md) - Main SNES documentation
- [Getting Started](../getting-started/) - Learning guides
- [Hardware Documentation](../hardware/) - Hardware details
- [Programming Guides](../programming/) - Development guides
- [Examples](../../../examples/snes/) - SNES code examples
