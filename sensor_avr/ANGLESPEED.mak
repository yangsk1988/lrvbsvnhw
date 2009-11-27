CC = iccavr
CFLAGS =  -e -D__ICC_VERSION="7.14C" -DAT90S8515  -l -g -Wa-W 
ASFLAGS = $(CFLAGS)  -Wa-g
LFLAGS =  -g -e:0x2000 -Wl-W -bfunc_lit:0x1a.0x2000 -dram_end:0x25f -bdata:0x60.0x25f -dhwstk_size:30 -beeprom:1.512 -fihx_coff -S2
FILES = Angel_Speed.o 

ANGLESPEED:	$(FILES)
	$(CC) -o ANGLESPEED $(LFLAGS) @ANGLESPEED.lk  
Angel_Speed.o: D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\uartintr.h D:\iccv7avr\include\io8515v.h D:\iccv7avr\include\macros.h D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\SpeedDection.h
Angel_Speed.o:	D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\Angel_Speed.c
	$(CC) -c $(CFLAGS) D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\Angel_Speed.c
