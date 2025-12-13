AS = ca65
LD = ld65
CFG = nes.cfg

SOURCES = main.s
OBJECTS = $(SOURCES:.s=.o)
TARGET = bootstrap.nes

.PHONY: all clean run

all: $(TARGET)

$(TARGET): $(OBJECTS) $(CFG)
	$(LD) -C $(CFG) -o $(TARGET) $(OBJECTS)

%.o: %.s
	$(AS) $< -o $@

clean:
	rm -f $(OBJECTS) $(TARGET)

run: $(TARGET)
	mesen $(TARGET) || fceux $(TARGET) || echo "Please install an NES emulator (Mesen2 or FCEUX)"
