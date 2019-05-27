SHELL := /bin/bash

AFLAGS		= -t none
LFLAGS		= -t none -C osi_armitage.cfg
RMFLAGS		= -f
 
CC		= cc65
CA		= ca65
CL		= cl65
RM		= rm

32K		= "27C256 @DIP28"

all: clean 560Z.hex

560Z_Util.o: 560Z_Util.a65
	$(CA) $(AFLAGS) -l 560Z_Util.lst -o 560Z_Util.o 560Z_Util.a65
560Z_Z80IO.o: 560Z_Z80IO.a65
	$(CA) $(AFLAGS) -l 560Z_Z80IO.lst -o 560Z_Z80IO.o 560Z_Z80IO.a65
560Z_I61IO.o: 560Z_I61IO.a65
	$(CA) $(AFLAGS) -l 560Z_I61IO.lst -o 560Z_I61IO.o 560Z_I61IO.a65

560Z.bin: 560Z_Util.o 560Z_Z80IO.o 560Z_I61IO.o
	$(CL) $(LFLAGS) --listing 560Z.lst -o 560Z.bin 560Z_Util.o 560Z_Z80IO.o 560Z_I61IO.o
560Z.hex: 560Z.bin
	srec_cat 560Z.bin -Binary -OF 1024 -Output 560Z.hex -Intel -address-length=2

clean:
	$(RM) $(RMFLAGS) *.o 560Z.bin 560Z.hex

copy: 560Z.bin
	rm /home/tangentdelta/Projects/Python/6502/560Z.bin
	cp 560Z.bin /home/tangentdelta/Projects/Python/6502/560Z.bin
	#python /home/tangentdelta/Projects/Python/6502/main.py
