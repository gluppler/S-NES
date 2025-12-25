# BRR Format

## Overview

BRR (Bit Rate Reduction) is the audio compression format used by SNES. All audio samples must be in BRR format.

## BRR Block Structure

Each BRR block is **9 bytes**:
- **Byte 0**: Header (end flag, loop flag, filter, range)
- **Bytes 1-8**: Compressed sample data (16 samples, 4 bits per sample)

## BRR Header

```
Bit 7: End flag (1 = last block)
Bit 6: Loop flag (1 = loop point)
Bits 5-4: Filter (0-3)
Bits 3-0: Range (0-12, determines shift amount)
```

## BRR Decoding

BRR decoding is performed by S-DSP hardware automatically. The S-DSP:
1. **Reads header**: Gets filter and range
2. **Decodes samples**: 16 samples per block (4 bits per sample)
3. **Applies filter**: If filter > 0 (Gaussian interpolation)
4. **Scales**: Shifts by range value (0-12)
5. **Interpolates**: Uses 4 BRR samples for smooth playback

### Filter Types
- **Filter 0**: No filtering
- **Filter 1**: Gaussian interpolation (most common)
- **Filter 2**: Gaussian interpolation (different coefficients)
- **Filter 3**: Gaussian interpolation (different coefficients)

## BRR File Format

BRR files contain:
- **Multiple BRR blocks**: Each 9 bytes
- **Loop point**: Marked by loop flag in header
- **End marker**: Last block has end flag set

## Converting to BRR

Use tools like:
- **wav2brr**: Converts WAV to BRR
- **brrconv**: BRR conversion tool
- **SPC700 tools**: Various conversion utilities

## Cross-References

- [DSP Registers](dsp-registers.md) - S-DSP register map
- [SPC700 Boot](spc700-boot.md) - Uploading BRR samples
- [Audio Integration](../../programming/audio-integration.md) - Using BRR samples
