export LC_CTYPE=C

.SUFFIXES: .asm .o .gbc

all: medarot.gbc

medarot.o: medarot.asm
	rgbasm -o medarot.o medarot.asm

medarot.gbc: medarot.o
	rgblink -O baserom.gbc -o $@ $<
	rgbfix -v -k 9C -l 0x33 -m 0x03 -p 0 -r 3 -t "MEDAROT KABUTO" $@

clean:
	rm -f medarot.o medarot.gbc
