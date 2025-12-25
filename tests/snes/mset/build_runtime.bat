@REM Generates runtime.lib
@REM
@REM cc65\ should contain latest cc65 build (cc65\bin)
@REM librsc\ should contain latest cc65 libsrc folder
@REM
@REM contents:
@REM   libsrc\runtime
@REM     -condes.asm (don't need constructor/destructor feature)
@REM     -callirq.asm (IRQ management not needed, uses .constructor)
@REM     -callmain.asm (main() argument generation not needed for NES)
@REM     -stkchk.asm (not needed, uses .constructor)
@REM   libsrc\common\copydata.asm (used by crt0.asm for copying DATA segment to RAM)
@REM
md temp\runtime
del temp\runtime\*.o
del runtime.lib
for %%X in (libsrc\runtime\*.asm) do cc65\bin\ca65.exe %%X -g -o temp\runtime\%%~nX.o
cc65\bin\ca65.exe libsrc\common\copydata.asm -g -o temp\runtime\copydata.o
del temp\runtime\condes.o
del temp\runtime\callirq.o
del temp\runtime\callmain.o
del temp\runtime\stkchk.o
for %%X in (temp\runtime\*.o) do cc65\bin\ar65.exe a runtime.lib %%X
pause