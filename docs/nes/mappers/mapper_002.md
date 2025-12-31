# Mapper 002

> **Note**: This documentation was integrated from the NES-UPDATE mapper_docs collection and has been verified and normalized for the S-NES-BOY framework.
> For the most up-to-date information, see [NESdev Wiki](https://www.nesdev.org/wiki/Mapper).

## Original Documentation

```

==================================================
= Mapper 002 =
==================================================

aka
--------------------------------------------------
UxROM (and compatible)


Example Games:
--------------------------------------------------
Mega Man
Castlevania
Contra
Duck Tales
Metal Gear


Notes:
--------------------------------------------------
UxROM has bus conflicts, however Mapper 002 is meant to be UxROM and compatible. So some mappers which were
similar in function, but did not have bus conflicts are included.

Additionally, UxROM does not have an 8 bit reg. UNROM is capped at 128k PRG, and UOROM is capped at 256k.

So to be "safe":
 - for homebrewing: assume bus conflicts, do not exceed 256k
 - for emudev: assume no bus conflicts, use all 8 PRG reg bits

There is no CHR swapping. Every Mapper 002 game I've ever seen has CHR-RAM.


Registers (**BUS CONFLICTS** sometimes):
--------------------------------------------------
 $8000-FFFF: [PPPP PPPP]
 PRG Reg



PRG Setup:
--------------------------------------------------

 $8000 $A000 $C000 $E000 
 +---------------+---------------+
 | $8000 | { -1} |
 +---------------+---------------+

```

## Additional Resources

- [NESdev Wiki - Mapper 002](https://www.nesdev.org/wiki/Mapper_002)
- [NESdev Forums](https://forums.nesdev.org/)
