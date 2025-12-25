@del temp\ctrltest.c.asm
@del temp\ctrltest_auto.c.asm
@del temp\ctrltest_simple.c.asm
@del temp\*.o
@del temp\ctrltest.sfc
@del temp\ctrltest.dbg
@del temp\ctrltest.map

cc65\bin\cc65 -o ctrltest.c.asm -O -T -g ctrltest.c
@IF ERRORLEVEL 1 GOTO error

cc65\bin\ca65 -o ctrltest.c.o -g ctrltest.c.asm
@IF ERRORLEVEL 1 GOTO error

cc65\bin\ca65 -o ctrltest.o -g ctrltest.asm
@IF ERRORLEVEL 1 GOTO error

cc65\bin\ld65 -o ctrltest.sfc -m ctrltest.map --dbgfile ctrltest.dbg -C ctrltest.cfg ctrltest.o ctrltest.c.o runtime.lib
@IF ERRORLEVEL 1 GOTO error

cc65\bin\cc65 -o ctrltest_auto.c.asm -O -T -g ctrltest_auto.c
@IF ERRORLEVEL 1 GOTO error

cc65\bin\ca65 -o ctrltest_auto.c.o -g ctrltest_auto.c.asm
@IF ERRORLEVEL 1 GOTO error

cc65\bin\ca65 -o ctrltest_auto.o -g ctrltest_auto.asm
@IF ERRORLEVEL 1 GOTO error

cc65\bin\ld65 -o ctrltest_auto.sfc -m ctrltest_auto.map --dbgfile ctrltest_auto.dbg -C ctrltest.cfg ctrltest_auto.o ctrltest_auto.c.o runtime.lib
@IF ERRORLEVEL 1 GOTO error

cc65\bin\cc65 -o ctrltest_simple.c.asm -O -T -g ctrltest_simple.c
@IF ERRORLEVEL 1 GOTO error

cc65\bin\ca65 -o ctrltest_simple.c.o -g ctrltest_simple.c.asm
@IF ERRORLEVEL 1 GOTO error

cc65\bin\ld65 -o ctrltest_simple.sfc -m ctrltest_simple.map --dbgfile ctrltest_simple.dbg -C ctrltest.cfg ctrltest_auto.o ctrltest_simple.c.o runtime.lib
@IF ERRORLEVEL 1 GOTO error

python checksum.py LOROM ctrltest.sfc

python checksum.py LOROM ctrltest_auto.sfc

python checksum.py LOROM ctrltest_simple.sfc

@echo.
@echo.
@echo Build successful!
@pause
@GOTO end
:error
@echo.
@echo.
@echo Build error!
@pause
:end