	.module Angel_Speed.c
	.area text(rom, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\Angel_Speed.c
	.area vector(rom, abs)
	.org 18
	rjmp _UART_RX_interrupt
	.area text(rom, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\Angel_Speed.c
	.area vector(rom, abs)
	.org 20
	rjmp _UART_TX_interrupt
	.area text(rom, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\Angel_Speed.c
	.area data(ram, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\Angel_Speed.c
_UartData::
	.blkb 1
	.area idata
	.byte 0
	.area data(ram, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\Angel_Speed.c
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\uartintr.h
	.dbsym e UartData _UartData c
	.area text(rom, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\uartintr.h
	.dbfunc e InitUART _InitUART fV
;              x -> R10
;       baudrate -> R16
	.even
_InitUART::
	st -y,R10
	.dbline -1
	.dbline 38
; /* Code adapted from Atmel AVR Application Note AVR306
;  * Interrupt mode driver for UART.
;  */
; #include <io8515v.h>
; #include <macros.h>
; 
; /* IMPORTANT: these vector numbers are for 8515! If you use other devices
;  * you must change them to the different set of numbers.
;  *
;  * UART_RX_interrupt set to UART, Rx Complete
;  * UART_TX_interrupt set to UART Data Register Empty
;  */
; 
; #pragma interrupt_handler UART_RX_interrupt:10 UART_TX_interrupt:11
; 
; /* UART Buffer Defines */
; #define UART_RX_BUFFER_SIZE 128 /* 1,2,4,8,16,32,64,128 or 256 bytes */
; #define UART_RX_BUFFER_MASK ( UART_RX_BUFFER_SIZE - 1 )
; #define UART_TX_BUFFER_SIZE 128 /* 1,2,4,8,16,32,64,128 or 256 bytes */
; #define UART_TX_BUFFER_MASK ( UART_TX_BUFFER_SIZE - 1 )
; 
; #if ( UART_RX_BUFFER_SIZE & UART_RX_BUFFER_MASK )
; #error RX buffer size is not a power of 2
; #endif
; 
; /* Static Variables */
; static unsigned char UART_RxBuf[UART_RX_BUFFER_SIZE];
; static volatile unsigned char UART_RxHead;
; static volatile unsigned char UART_RxTail;
; static unsigned char UART_TxBuf[UART_TX_BUFFER_SIZE];
; static volatile unsigned char UART_TxHead;
; static volatile unsigned char UART_TxTail;
; 
; unsigned char UartData =0;
; 
; /* initialize UART */
; void InitUART( unsigned char baudrate )
; 	{
	.dbline 40
; 	unsigned char x;
; 	UBRR = baudrate; /* set the baud rate */
	out 0x9,R16
	.dbline 43
; 	/* enable UART receiver and transmitter, and
; 	receive interrupt */
; 	UCR = ( (1<<RXCIE) | (1<<RXEN) | (1<<TXEN) );
	ldi R24,152
	out 0xa,R24
	.dbline 44
; 	x = 0; /* flush receive buffer */
	clr R10
	.dbline 45
; 	UART_RxTail = x;
	sts _UART_RxTail,R10
	.dbline 46
; 	UART_RxHead = x;
	sts _UART_RxHead,R10
	.dbline 47
; 	UART_TxTail = x;
	sts _UART_TxTail,R10
	.dbline 48
; 	UART_TxHead = x;
	sts _UART_TxHead,R10
	.dbline -2
L1:
	.dbline 0 ; func end
	ld R10,y+
	ret
	.dbsym r x 10 c
	.dbsym r baudrate 16 c
	.dbend
	.dbfunc e UART_RX_interrupt _UART_RX_interrupt fV
;           data -> R16
;        tmphead -> R18
	.even
_UART_RX_interrupt::
	st -y,R2
	st -y,R16
	st -y,R18
	st -y,R19
	st -y,R24
	st -y,R25
	st -y,R30
	st -y,R31
	in R2,0x3f
	st -y,R2
	.dbline -1
	.dbline 53
; 	}
; 
; /* interrupt handlers */
; void UART_RX_interrupt( void )
; {
	.dbline 56
; 	unsigned char data;
; 	unsigned char tmphead;
; 	data = UDR; /* read the received data */
	in R16,0xc
	.dbline 58
; 	/* calculate buffer index */
; 	tmphead = ( UART_RxHead + 1 ) & UART_RX_BUFFER_MASK;
	lds R18,_UART_RxHead
	subi R18,255    ; addi 1
	andi R18,127
	.dbline 59
; 	UART_RxHead = tmphead; /* store new index */
	sts _UART_RxHead,R18
	.dbline 60
; 	if ( tmphead == UART_RxTail )
	lds R2,_UART_RxTail
	cp R18,R2
	brne L3
X0:
	.dbline 61
; 		{
	.dbline 63
; 		/* ERROR! Receive buffer overflow */
; 		}
L3:
	.dbline 64
; 	UART_RxBuf[tmphead] = data; /* store received data in buffer */
	ldi R24,<_UART_RxBuf
	ldi R25,>_UART_RxBuf
	mov R30,R18
	clr R31
	add R30,R24
	adc R31,R25
	std z+0,R16
	.dbline -2
L2:
	.dbline 0 ; func end
	ld R2,y+
	out 0x3f,R2
	ld R31,y+
	ld R30,y+
	ld R25,y+
	ld R24,y+
	ld R19,y+
	ld R18,y+
	ld R16,y+
	ld R2,y+
	reti
	.dbsym r data 16 c
	.dbsym r tmphead 18 c
	.dbend
	.dbfunc e UART_TX_interrupt _UART_TX_interrupt fV
;        tmptail -> R16
	.even
_UART_TX_interrupt::
	st -y,R2
	st -y,R3
	st -y,R16
	st -y,R17
	st -y,R24
	st -y,R25
	st -y,R30
	st -y,R31
	in R2,0x3f
	st -y,R2
	.dbline -1
	.dbline 68
; }
; 
; void UART_TX_interrupt( void )
; {
	.dbline 72
; 	unsigned char tmptail;
; 
; 	/* check if all data is transmitted */
; 	if ( UART_TxHead != UART_TxTail )
	lds R2,_UART_TxTail
	lds R3,_UART_TxHead
	cp R3,R2
	breq L6
X1:
	.dbline 73
; 		{
	.dbline 75
; 		/* calculate buffer index */
; 		tmptail = ( UART_TxTail + 1 ) & UART_TX_BUFFER_MASK;
	lds R16,_UART_TxTail
	subi R16,255    ; addi 1
	andi R16,127
	.dbline 76
; 		UART_TxTail = tmptail; /* store new index */
	sts _UART_TxTail,R16
	.dbline 77
; 		UDR = UART_TxBuf[tmptail]; /* start transmition */
	ldi R24,<_UART_TxBuf
	ldi R25,>_UART_TxBuf
	mov R30,R16
	clr R31
	add R30,R24
	adc R31,R25
	ldd R2,z+0
	out 0xc,R2
	.dbline 78
; 		}
	rjmp L7
L6:
	.dbline 80
; 	else
; 		{
	.dbline 81
; 		UCR &= ~(1<<UDRIE); /* disable UDRE interrupt */
	cbi 0xa,5
	.dbline 82
; 		}
L7:
	.dbline -2
L5:
	.dbline 0 ; func end
	ld R2,y+
	out 0x3f,R2
	ld R31,y+
	ld R30,y+
	ld R25,y+
	ld R24,y+
	ld R17,y+
	ld R16,y+
	ld R3,y+
	ld R2,y+
	reti
	.dbsym r tmptail 16 c
	.dbend
	.dbfunc e ReceiveByte _ReceiveByte fc
;        tmptail -> R16
	.even
_ReceiveByte::
	.dbline -1
	.dbline 87
; 	}
; 
; /* Read and write functions */
; unsigned char ReceiveByte( void )
; 	{
	.dbline 90
; 	unsigned char tmptail;
; 
; 	if(UART_RxHead == UART_RxTail)//do not wait if no data,return -1;
	lds R2,_UART_RxTail
	lds R3,_UART_RxHead
	cp R3,R2
	brne L9
X2:
	.dbline 91
; 	return 0xFF;
	ldi R16,255
	rjmp L8
L9:
	.dbline 94
; 	//while ( UART_RxHead == UART_RxTail ) /* wait for incomming data */
; 		//;
; 	tmptail = ( UART_RxTail + 1 ) & UART_RX_BUFFER_MASK;/* calculate buffer index */
	lds R16,_UART_RxTail
	subi R16,255    ; addi 1
	andi R16,127
	.dbline 95
; 	UART_RxTail = tmptail; /* store new index */
	sts _UART_RxTail,R16
	.dbline 96
; 	return UART_RxBuf[tmptail]; /* return data */
	ldi R24,<_UART_RxBuf
	ldi R25,>_UART_RxBuf
	mov R30,R16
	clr R31
	add R30,R24
	adc R31,R25
	ldd R16,z+0
	.dbline -2
L8:
	.dbline 0 ; func end
	ret
	.dbsym r tmptail 16 c
	.dbend
	.dbfunc e TransmitByte _TransmitByte fV
;        tmphead -> R20
;           data -> R16
	.even
_TransmitByte::
	st -y,R20
	st -y,R21
	.dbline -1
	.dbline 100
; 	}
; 
; void TransmitByte( unsigned char data )
; 	{
	.dbline 103
; 	unsigned char tmphead;
; 	/* calculate buffer index */
; 	tmphead = ( UART_TxHead + 1 ) & UART_TX_BUFFER_MASK; 
	lds R20,_UART_TxHead
	subi R20,255    ; addi 1
	andi R20,127
L12:
	.dbline 107
; 		/* wait for free space in buffer */
; 
; 	while ( tmphead == UART_TxTail )
; 		;
L13:
	.dbline 106
	lds R2,_UART_TxTail
	cp R20,R2
	breq L12
X3:
	.dbline 108
; 	UART_TxBuf[tmphead] = data; /* store data in buffer */
	ldi R24,<_UART_TxBuf
	ldi R25,>_UART_TxBuf
	mov R30,R20
	clr R31
	add R30,R24
	adc R31,R25
	std z+0,R16
	.dbline 109
; 	UART_TxHead = tmphead; /* store new index */
	sts _UART_TxHead,R20
	.dbline 110
; 	UCR |= (1<<UDRIE); /* enable UDRE interrupt */
	sbi 0xa,5
	.dbline -2
L11:
	.dbline 0 ; func end
	ld R21,y+
	ld R20,y+
	ret
	.dbsym r tmphead 20 c
	.dbsym r data 16 c
	.dbend
	.dbfunc e DataInReceiveBuffer _DataInReceiveBuffer fc
	.even
_DataInReceiveBuffer::
	.dbline -1
	.dbline 114
; 	}
; 
; unsigned char DataInReceiveBuffer( void )
; 	{
	.dbline 115
; 	return ( UART_RxHead != UART_RxTail ); 
	lds R2,_UART_RxTail
	lds R3,_UART_RxHead
	cp R3,R2
	breq L16
X4:
	ldi R16,1
	ldi R17,0
	rjmp L17
L16:
	clr R16
	clr R17
L17:
	.dbline -2
L15:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e SendString _SendString fV
;              i -> R20,R21
;            str -> R10,R11
	.even
_SendString::
	rcall push_xgset300C
	mov R10,R16
	mov R11,R17
	.dbline -1
	.dbline 120
; 		/* return 0 (FALSE) if the receive buffer is empty */
; 	}
; 
; void SendString(char *str)
; {
	.dbline 122
; int i;
; for(i=2;i>=0;i--)
	ldi R20,2
	ldi R21,0
L19:
	.dbline 123
; TransmitByte(str[i]);
	mov R30,R20
	mov R31,R21
	add R30,R10
	adc R31,R11
	ldd R16,z+0
	rcall _TransmitByte
L20:
	.dbline 122
	subi R20,1
	sbci R21,0
	.dbline 122
	cpi R20,0
	ldi R30,0
	cpc R21,R30
	brge L19
X5:
	.dbline -2
L18:
	.dbline 0 ; func end
	rjmp pop_xgset300C
	.dbsym r i 20 I
	.dbsym r str 10 pc
	.dbend
	.area vector(rom, abs)
	.org 2
	rjmp _ISR_int0_handler
	.area text(rom, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\uartintr.h
	.area vector(rom, abs)
	.org 12
	rjmp _TIMER1_OVF
	.area text(rom, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\uartintr.h
	.area vector(rom, abs)
	.org 4
	rjmp _ISR_int1_handler
	.area text(rom, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\uartintr.h
	.area data(ram, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\uartintr.h
_s_count::
	.blkb 2
	.area idata
	.word 0
	.area data(ram, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\uartintr.h
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\SpeedDection.h
	.dbsym e s_count _s_count I
_AngleCountTime::
	.blkb 2
	.area idata
	.word 0
	.area data(ram, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\SpeedDection.h
	.dbsym e AngleCountTime _AngleCountTime I
_SpeedCountTime::
	.blkb 2
	.area idata
	.word 0
	.area data(ram, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\SpeedDection.h
	.dbsym e SpeedCountTime _SpeedCountTime I
	.area text(rom, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\SpeedDection.h
	.dbfunc e ISR_int0_handler _ISR_int0_handler fV
	.even
_ISR_int0_handler::
	st -y,R2
	st -y,R3
	st -y,R4
	st -y,R5
	in R2,0x3f
	st -y,R2
	.dbline -1
	.dbline 28
; #include <io8515v.h>
; #include <macros.h>
; 
; #pragma interrupt_handler ISR_int0_handler:2 TIMER1_OVF:7 ISR_int1_handler:3
; 
; #define CLK_DIV_BY_1		0x01 
; #define CLK_DIV_BY_8		0x02  
; #define CLK_DIV_BY_64		0x03  
; #define CLK_DIV_BY_256		0x04
; #define CLK_DIV_BY_1024		0x05
; #define TMR1_OVF_INT_ENA	0x80
; #define INT0_ENA_INT1_ENA	0xC0
; #define INT0_TRIG_FALLING_EDGE_INT1_TRIG_FALLING_EDGE	0x0A
; 
; //int PreviousNum =0;
; //int CurrentNum =0;
; //int count =0;
; //int Frequency =0;
; //static int SubNum =0;
; //static int temptime =0;
; //static unsigned char StartFlag =0;
; //unsigned char Data[4] ={'#',0,0,'#'};
; int s_count=0;
; int AngleCountTime = 0;
; int SpeedCountTime = 0;
; 
; void ISR_int0_handler()
; {
	.dbline 29
; 	s_count -= (AngleCountTime*256+TCNT0);
	in R2,0x32
	lds R4,_AngleCountTime
	lds R5,_AngleCountTime+1
	mov R3,R4
	lds R4,_s_count
	lds R5,_s_count+1
	sub R4,R2
	sbc R5,R3
	sts _s_count+1,R5
	sts _s_count,R4
	.dbline 30
; 	AngleCountTime=0;
	clr R2
	clr R3
	sts _AngleCountTime+1,R3
	sts _AngleCountTime,R2
	.dbline 31
; 	TCNT0=0;
	out 0x32,R2
	.dbline -2
L23:
	.dbline 0 ; func end
	ld R2,y+
	out 0x3f,R2
	ld R5,y+
	ld R4,y+
	ld R3,y+
	ld R2,y+
	reti
	.dbend
	.dbfunc e ISR_int1_handler _ISR_int1_handler fV
	.even
_ISR_int1_handler::
	st -y,R2
	st -y,R3
	st -y,R4
	st -y,R5
	in R2,0x3f
	st -y,R2
	.dbline -1
	.dbline 39
; 
; 	//CurrentNum = TCNT1H*256+TCNT1L;	
; 	//StartFlag =1;
; 	//count++;	
; }
; 
; void ISR_int1_handler()
; {
	.dbline 40
;     s_count += (AngleCountTime*256+TCNT0);
	in R2,0x32
	lds R4,_AngleCountTime
	lds R5,_AngleCountTime+1
	mov R3,R4
	lds R4,_s_count
	lds R5,_s_count+1
	add R4,R2
	adc R5,R3
	sts _s_count+1,R5
	sts _s_count,R4
	.dbline 41
; 	AngleCountTime=0;
	clr R2
	clr R3
	sts _AngleCountTime+1,R3
	sts _AngleCountTime,R2
	.dbline 42
; 	TCNT0=0;
	out 0x32,R2
	.dbline -2
L24:
	.dbline 0 ; func end
	ld R2,y+
	out 0x3f,R2
	ld R5,y+
	ld R4,y+
	ld R3,y+
	ld R2,y+
	reti
	.dbend
	.dbfunc e TIMER1_OVF _TIMER1_OVF fV
	.even
_TIMER1_OVF::
	st -y,R2
	st -y,R24
	st -y,R25
	in R2,0x3f
	st -y,R2
	.dbline -1
	.dbline 51
; 
;     /*will lead to acummulative error
; 	s_count += (AngleCountTime*256+TCNT0);
; 	TCNT0=0;
; 	AngleCountTime=0;*/	
; }
; 
; void TIMER1_OVF()
; {	           
	.dbline 52
; 	TCNT1L = 0x00;
	clr R2
	out 0x2c,R2
	.dbline 53
; 	TCNT1H = 0x00;
	out 0x2d,R2
	.dbline 54
; 	SpeedCountTime++;	
	lds R24,_SpeedCountTime
	lds R25,_SpeedCountTime+1
	adiw R24,1
	sts _SpeedCountTime+1,R25
	sts _SpeedCountTime,R24
	.dbline -2
L25:
	.dbline 0 ; func end
	ld R2,y+
	out 0x3f,R2
	ld R25,y+
	ld R24,y+
	ld R2,y+
	reti
	.dbend
	.dbfunc e InitTimer1 _InitTimer1 fV
	.even
_InitTimer1::
	.dbline -1
	.dbline 58
; }
; 
; void InitTimer1()
; {
	.dbline 59
;     TCCR1B =0x00;
	clr R2
	out 0x2e,R2
	.dbline 60
; 	TCCR1A = 0;
	out 0x2f,R2
	.dbline 61
; 	TCNT1H = 0x00;           
	out 0x2d,R2
	.dbline 62
; 	TCNT1L = 0x00;
	out 0x2c,R2
	.dbline 63
; 	TCCR1B = 0x07;
	ldi R24,7
	out 0x2e,R24
	.dbline 64
; 	TIMSK |= (1<<TOIE1);
	in R24,0x39
	ori R24,128
	out 0x39,R24
	.dbline -2
L26:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e OpenInt0_Int1 _OpenInt0_Int1 fV
	.even
_OpenInt0_Int1::
	.dbline -1
	.dbline 68
; }
; 
; void OpenInt0_Int1()
; {
	.dbline 69
;     MCUCR = INT0_TRIG_FALLING_EDGE_INT1_TRIG_FALLING_EDGE;
	ldi R24,10
	out 0x35,R24
	.dbline 70
; 	GIMSK = INT0_ENA_INT1_ENA;	
	ldi R24,192
	out 0x3b,R24
	.dbline -2
L27:
	.dbline 0 ; func end
	ret
	.dbend
	.area vector(rom, abs)
	.org 14
	rjmp _TIMER0_OVF
	.area text(rom, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\SpeedDection.h
	.area data(ram, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\SpeedDection.h
_Orientation::
	.blkb 2
	.area idata
	.word 0
	.area data(ram, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\SpeedDection.h
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\Angel_Speed.c
	.dbsym e Orientation _Orientation I
_angle::
	.blkb 2
	.area idata
	.word 0
	.area data(ram, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\Angel_Speed.c
	.dbsym e angle _angle I
_pos::
	.blkb 2
	.area idata
	.word 0
	.area data(ram, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\Angel_Speed.c
	.dbsym e pos _pos I
_Data::
	.blkb 2
	.area idata
	.byte 35,0
	.area data(ram, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\Angel_Speed.c
	.blkb 1
	.area idata
	.byte 0
	.area data(ram, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\Angel_Speed.c
	.dbsym e Data _Data A[3:3]c
	.area text(rom, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\Angel_Speed.c
	.dbfunc e TIMER0_OVF _TIMER0_OVF fV
	.even
_TIMER0_OVF::
	st -y,R2
	st -y,R24
	st -y,R25
	in R2,0x3f
	st -y,R2
	.dbline -1
	.dbline 19
; #include "uartintr.h"
; #include "SpeedDection.h"
; 
; #pragma interrupt_handler TIMER0_OVF:8
; 
; //int PreCountNum = 0,CurrentCountNum = 0;
; //unsigned char SubNum =0;
; //int DataH =0,DataL = 0;
; //int flag= 0;
; int Orientation=0;
; int angle=0,pos = 0;
; //unsigned char TestNum;
; extern int s_count;
; extern int AngleCountTime;
; 
; unsigned char Data[3] ={'#',0,0};
; 
; void TIMER0_OVF()
; {
	.dbline 20
; 	TCNT0 = 00; 
	clr R2
	out 0x32,R2
	.dbline 21
; 	AngleCountTime++;
	lds R24,_AngleCountTime
	lds R25,_AngleCountTime+1
	adiw R24,1
	sts _AngleCountTime+1,R25
	sts _AngleCountTime,R24
	.dbline -2
L28:
	.dbline 0 ; func end
	ld R2,y+
	out 0x3f,R2
	ld R25,y+
	ld R24,y+
	ld R2,y+
	reti
	.dbend
	.dbfunc e InitTimer0 _InitTimer0 fV
	.even
_InitTimer0::
	.dbline -1
	.dbline 25
; }
; 
; void InitTimer0()
; {
	.dbline 26
; 	TCCR0 = 0x07;
	ldi R24,7
	out 0x33,R24
	.dbline 27
; 	TCNT0 = 00;
	clr R2
	out 0x32,R2
	.dbline 28
; 	TIMSK |= (1<<TOIE0);
	in R24,0x39
	ori R24,2
	out 0x39,R24
	.dbline -2
L29:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e Initial _Initial fV
	.even
_Initial::
	.dbline -1
	.dbline 32
; }
; 
; void Initial()
; {
	.dbline 33
; 	TCNT0 = 00;//8 bits counter
	clr R2
	out 0x32,R2
	.dbline 34
; 	TCNT1H = 0x00;// 16bits counter high byte           
	out 0x2d,R2
	.dbline 35
; 	TCNT1L = 0x00;//low byte
	out 0x2c,R2
	.dbline 36
; 	s_count=0;//software counter
	clr R3
	sts _s_count+1,R3
	sts _s_count,R2
	.dbline 37
; 	angle=0;//angle of handle
	sts _angle+1,R3
	sts _angle,R2
	.dbline 38
; 	pos = 0;//position
	sts _pos+1,R3
	sts _pos,R2
	.dbline 39
; 	AngleCountTime =0;//times of TCNT0 overflow
	sts _AngleCountTime+1,R3
	sts _AngleCountTime,R2
	.dbline 40
; 	SpeedCountTime =0;//Position CountTime;
	sts _SpeedCountTime+1,R3
	sts _SpeedCountTime,R2
	.dbline 41
; 	Data[1] =0;
	sts _Data+1,R2
	.dbline 42
; 	Data[2] =0;	
	sts _Data+2,R2
	.dbline -2
L30:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e DectectOrientation _DectectOrientation fI
	.even
_DectectOrientation::
	.dbline -1
	.dbline 46
; }
; 
; int DectectOrientation()
; {
	.dbline 47
; 	return (PINB & (1 << PB2) );
	in R16,0x16
	clr R17
	andi R16,4
	andi R17,0
	.dbline -2
L33:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e InitAngle _InitAngle fV
	.even
_InitAngle::
	.dbline -1
	.dbline 52
; 	
; }
; 
; void InitAngle()
; {
	.dbline 53
;  	 		TCNT0 = 00;
	clr R2
	out 0x32,R2
	.dbline 56
; 			//TCNT1H = 0x00;           
; 			//TCNT1L = 0x00;
; 			s_count=0;
	clr R3
	sts _s_count+1,R3
	sts _s_count,R2
	.dbline 57
; 			angle=0;
	sts _angle+1,R3
	sts _angle,R2
	.dbline 59
; 			//pos = 0;
; 			AngleCountTime =0;
	sts _AngleCountTime+1,R3
	sts _AngleCountTime,R2
	.dbline 60
; 			Data[1] =0;
	sts _Data+1,R2
	.dbline 61
; 			Data[2] =0;
	sts _Data+2,R2
	.dbline -2
L34:
	.dbline 0 ; func end
	ret
	.dbend
	.area lit(rom, con, rel)
L38:
	.byte 'V,'I,'R,'T,'U,'A,'L,'B,'I,'C,'Y,'C,'L,'E,35,0
	.area text(rom, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\Angel_Speed.c
	.dbfunc e main _main fV
;            VER -> y+0
;              i -> R20,R21
	.even
_main::
	sbiw R28,16
	.dbline -1
	.dbline 65
; }
; 
; void main()
; {
	.dbline 68
; 
; 
; 	char VER[] = "VIRTUALBICYCLE#";	
	ldi R24,<L38
	ldi R25,>L38
	mov R30,R28
	mov R31,R29
	ldi R16,16
	ldi R17,0
	st -y,R31
	st -y,R30
	st -y,R25
	st -y,R24
	rcall asgncblk
	.dbline 70
; 	int i;
; 	DDRB = 0x00;//"0"-input;"1"-output
	clr R2
	out 0x17,R2
	.dbline 71
; 	PORTB = 0x03;
	ldi R24,3
	out 0x18,R24
	.dbline 72
; 	DDRA = 0x00;
	out 0x1a,R2
	.dbline 73
; 	PORTA = 0xFF;
	ldi R24,255
	out 0x1b,R24
	.dbline 74
; 	DDRC = 0x00;//
	out 0x14,R2
	.dbline 75
; 	PORTC = 0xFF;//initial value
	out 0x15,R24
	.dbline 77
; 
; 	InitUART(11);//set bandrate,19200 in 3.686M
	ldi R16,11
	rcall _InitUART
	.dbline 78
; 	InitTimer0();
	rcall _InitTimer0
	.dbline 79
; 	InitTimer1();
	rcall _InitTimer1
	.dbline 80
; 	OpenInt0_Int1();
	rcall _OpenInt0_Int1
	.dbline 84
; 	
;     
; 
; 	_SEI();	
	sei
	rjmp L40
L39:
	.dbline 87
; 
; 	while(1)
; 	{
	.dbline 89
; 	    //check if Z is high,         
;         if( PINA  & (1 << PA7))//PA7 is high, corresponding to Z high.which is zero position signal of sensor
	sbis 0x19,7
	rjmp L42
X6:
	.dbline 90
;         {
	.dbline 91
; 			InitAngle();
	rcall _InitAngle
	.dbline 92
;         }
L42:
	.dbline 94
; 		
; 		switch(ReceiveByte())
	rcall _ReceiveByte
	mov R20,R16
	clr R21
	cpi R20,82
	ldi R30,0
	cpc R21,R30
	brne X19
	rjmp L65
X19:
X7:
	cpi R20,83
	ldi R30,0
	cpc R21,R30
	brne X20
	rjmp L64
X20:
X8:
	ldi R24,83
	ldi R25,0
	cp R24,R20
	cpc R25,R21
	brlt L71
X9:
L70:
	cpi R20,65
	ldi R30,0
	cpc R21,R30
	brne X21
	rjmp L55
X21:
X10:
	cpi R20,66
	ldi R30,0
	cpc R21,R30
	brne X22
	rjmp L60
X22:
X11:
	cpi R20,67
	ldi R30,0
	cpc R21,R30
	brne X23
	rjmp L63
X23:
X12:
	cpi R20,68
	ldi R30,0
	cpc R21,R30
	breq L48
X13:
	rjmp L44
L71:
	cpi R20,255
	ldi R30,0
	cpc R21,R30
	brne X24
	rjmp L45
X24:
X14:
	rjmp L44
L48:
	.dbline 100
; 		{
; 		case 0xFF:break; 
; 		case 'D':/*Sending ALL*/
; 		
; 		/*case A*/
; 			 if(DectectOrientation())
	rcall _DectectOrientation
	cpi R16,0
	cpc R16,R17
	breq L49
X15:
	.dbline 101
; 			{
	.dbline 102
; 				angle = s_count+(AngleCountTime*256+TCNT0);
	in R2,0x32
	lds R4,_AngleCountTime
	lds R5,_AngleCountTime+1
	mov R3,R4
	lds R4,_s_count
	lds R5,_s_count+1
	add R4,R2
	adc R5,R3
	sts _angle+1,R5
	sts _angle,R4
	.dbline 103
; 			}
	rjmp L50
L49:
	.dbline 105
; 			else
; 			{
	.dbline 106
; 				angle = s_count-(AngleCountTime*256+TCNT0);
	in R2,0x32
	lds R4,_AngleCountTime
	lds R5,_AngleCountTime+1
	mov R3,R4
	lds R4,_s_count
	lds R5,_s_count+1
	sub R4,R2
	sbc R5,R3
	sts _angle+1,R5
	sts _angle,R4
	.dbline 107
; 			}
L50:
	.dbline 108
; 			Data[1] =angle>>8;//high 
	lds R2,_angle
	lds R3,_angle+1
	mov R2,R3
	clr R3
	sbrc R2,7
	com R3
	sts _Data+1,R2
	.dbline 109
; 			Data[2] =angle&0x00FF;//low	
	lds R24,_angle
	lds R25,_angle+1
	andi R25,0
	sts _Data+2,R24
	.dbline 110
; 			TransmitByte('A');
	ldi R16,65
	rcall _TransmitByte
	.dbline 111
; 			SendString(Data);//send data[2] first,then data[1],data[0];
	ldi R16,<_Data
	ldi R17,>_Data
	rcall _SendString
	.dbline 114
; 			
; 		/*case B*/
; 			pos = TCNT1H*256+TCNT1L;
	in R2,0x2c
	in R3,0x2d
	sts _pos+1,R3
	sts _pos,R2
	.dbline 115
; 			Data[1] =pos>>8;
	mov R2,R3
	clr R3
	sbrc R2,7
	com R3
	sts _Data+1,R2
	.dbline 116
; 			Data[2] =pos&0x00FF;	
	lds R24,_pos
	lds R25,_pos+1
	andi R25,0
	sts _Data+2,R24
	.dbline 117
; 			TransmitByte('B');
	ldi R16,66
	rcall _TransmitByte
	.dbline 118
; 			SendString(Data);
	ldi R16,<_Data
	ldi R17,>_Data
	rcall _SendString
	.dbline 121
; 				
; 		/*case S*/
; 			TransmitByte('S');
	ldi R16,83
	rcall _TransmitByte
	.dbline 124
; 			//if(PINA & (1 << PA2));
; 			
; 			PORTC = PINC;
	in R2,0x13
	out 0x15,R2
	.dbline 125
; 			TransmitByte(PORTC);
	in R16,0x15
	rcall _TransmitByte
	.dbline 127
; 			
; 			PORTA = PINA;
	in R2,0x19
	out 0x1b,R2
	.dbline 128
; 			TransmitByte(PORTA);
	in R16,0x1b
	rcall _TransmitByte
	.dbline 129
; 			TransmitByte('#');		
	ldi R16,35
	rcall _TransmitByte
	.dbline 130
; 		break;
	rjmp L45
L55:
	.dbline 133
; 		
; 		case 'A'://angle
; 			if(DectectOrientation())
	rcall _DectectOrientation
	mov R10,R16
	mov R11,R17
	cpi R16,0
	cpc R16,R17
	breq L56
X16:
	.dbline 134
; 			{
	.dbline 135
; 				angle = s_count+(AngleCountTime*256+TCNT0);
	in R2,0x32
	lds R4,_AngleCountTime
	lds R5,_AngleCountTime+1
	mov R3,R4
	lds R4,_s_count
	lds R5,_s_count+1
	add R4,R2
	adc R5,R3
	sts _angle+1,R5
	sts _angle,R4
	.dbline 136
; 			}
	rjmp L57
L56:
	.dbline 138
; 			else
; 			{
	.dbline 139
; 				angle = s_count-(AngleCountTime*256+TCNT0);
	in R2,0x32
	lds R4,_AngleCountTime
	lds R5,_AngleCountTime+1
	mov R3,R4
	lds R4,_s_count
	lds R5,_s_count+1
	sub R4,R2
	sbc R5,R3
	sts _angle+1,R5
	sts _angle,R4
	.dbline 140
; 			}
L57:
	.dbline 141
; 			Data[1] =angle>>8;
	lds R2,_angle
	lds R3,_angle+1
	mov R2,R3
	clr R3
	sbrc R2,7
	com R3
	sts _Data+1,R2
	.dbline 142
; 			Data[2] =angle&0x00FF;	
	lds R24,_angle
	lds R25,_angle+1
	andi R25,0
	sts _Data+2,R24
	.dbline 143
; 			TransmitByte('A');
	ldi R16,65
	rcall _TransmitByte
	.dbline 144
; 			SendString(Data);	
	ldi R16,<_Data
	ldi R17,>_Data
	rcall _SendString
	.dbline 145
; 			break;
	rjmp L45
L60:
	.dbline 148
; 
; 		case 'B'://position
; 			pos = TCNT1H*256+TCNT1L;
	in R2,0x2c
	in R3,0x2d
	sts _pos+1,R3
	sts _pos,R2
	.dbline 149
; 			Data[1] =pos>>8;
	mov R2,R3
	clr R3
	sbrc R2,7
	com R3
	sts _Data+1,R2
	.dbline 150
; 			Data[2] =pos&0x00FF;	
	lds R24,_pos
	lds R25,_pos+1
	andi R25,0
	sts _Data+2,R24
	.dbline 151
; 			TransmitByte('B');
	ldi R16,66
	rcall _TransmitByte
	.dbline 152
; 			SendString(Data);	
	ldi R16,<_Data
	ldi R17,>_Data
	rcall _SendString
	.dbline 153
; 			break;
	rjmp L45
L63:
	.dbline 156
; 
; 		case 'C'://Clear Command
; 			 InitAngle();//only init angle, position imformation will not clear.
	rcall _InitAngle
	.dbline 157
; 			 TransmitByte('C');
	ldi R16,67
	rcall _TransmitByte
	.dbline 158
; 			 SendString(Data);
	ldi R16,<_Data
	ldi R17,>_Data
	rcall _SendString
	.dbline 159
; 			break;
	rjmp L45
L64:
	.dbline 162
; 
; 		case 'S'://switch, key
; 			TransmitByte('S');
	ldi R16,83
	rcall _TransmitByte
	.dbline 165
; 			//if(PINA & (1 << PA2));		
; 			
; 			PORTC = PINC;
	in R2,0x13
	out 0x15,R2
	.dbline 166
; 			TransmitByte(PORTC);
	in R16,0x15
	rcall _TransmitByte
	.dbline 168
; 			
; 			PORTA = PINA;
	in R2,0x19
	out 0x1b,R2
	.dbline 169
; 			TransmitByte(PORTA);
	in R16,0x1b
	rcall _TransmitByte
	.dbline 170
; 			TransmitByte('#');
	ldi R16,35
	rcall _TransmitByte
	.dbline 171
; 			break;
	rjmp L45
L65:
	.dbline 174
; 			
; 		case 'R'://version information
; 			 for(i = 0;VER[i]!='\0';i++)
	clr R20
	clr R21
	rjmp L69
L66:
	.dbline 175
; 			 {
	.dbline 176
; 			  TransmitByte(VER[i]);
	mov R24,R28
	mov R25,R29
	mov R30,R20
	mov R31,R21
	add R30,R24
	adc R31,R25
	ldd R16,z+0
	rcall _TransmitByte
	.dbline 177
; 			 }
L67:
	.dbline 174
	subi R20,255  ; offset = 1
	sbci R21,255
L69:
	.dbline 174
	mov R24,R28
	mov R25,R29
	mov R30,R20
	mov R31,R21
	add R30,R24
	adc R31,R25
	ldd R2,z+0
	tst R2
	brne L66
X17:
	.dbline 181
; 			 
; 			 
; 		
; 		break;
L44:
	.dbline 185
; 			
; 		
; 			
; 		default:;
	.dbline 186
; 		}
L45:
	.dbline 187
; 	}
L40:
	.dbline 86
	rjmp L39
X18:
	.dbline -2
L37:
	.dbline 0 ; func end
	adiw R28,16
	ret
	.dbsym l VER 0 A[16:16]c
	.dbsym r i 20 I
	.dbend
	.area bss(ram, con, rel)
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\Angel_Speed.c
_UART_TxTail:
	.blkb 1
	.dbfile D:\AVR_Work\“斯科达”展示上用的AVR程序\sensor_avr\uartintr.h
	.dbsym s UART_TxTail _UART_TxTail c
_UART_TxHead:
	.blkb 1
	.dbsym s UART_TxHead _UART_TxHead c
_UART_TxBuf:
	.blkb 128
	.dbsym s UART_TxBuf _UART_TxBuf A[128:128]c
_UART_RxTail:
	.blkb 1
	.dbsym s UART_RxTail _UART_RxTail c
_UART_RxHead:
	.blkb 1
	.dbsym s UART_RxHead _UART_RxHead c
_UART_RxBuf:
	.blkb 128
	.dbsym s UART_RxBuf _UART_RxBuf A[128:128]c
; 	/*  Orientation=DectectOrientation();
; 	if(flag)
; 	{
; 	flag = 0;
; 	CurrentCountNum =DataH*256 + DataL;
; 	if(CurrentCountNum>=PreCountNum)	
; 	{
; 	SubNum = CurrentCountNum - PreCountNum;
; 	}
; 	else
; 	{
; 	SubNum = CurrentCountNum + 65536 - PreCountNum;
; 	}
; 
; 	if(Orientation)
; 	angle +=SubNum;
; 	else
; 	angle -=SubNum;
; 
; 	PreCountNum = CurrentCountNum;
; 	}
; 	}*/
; }
