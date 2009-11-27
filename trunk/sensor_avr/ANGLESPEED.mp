NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   001A   0010 =     16. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       001A  __lit_start
       002A  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                           idata   002A   0010 =     16. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       002A  __idata_start
       003A  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   003A   05C8 =   1480. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       001D  __text_start
       001D  __start
       003E  _exit
       003F  _InitUART
       004E  _UART_RX_interrupt
       0075  _UART_TX_interrupt
       00A0  _ReceiveByte
       00B6  _TransmitByte
       00CD  _DataInReceiveBuffer
       00D9  _SendString
       00EB  _ISR_int0_handler
       010F  _ISR_int1_handler
       0133  _TIMER1_OVF
       014A  _InitTimer1
       0155  _OpenInt0_Int1
       015A  _TIMER0_OVF
       0170  _InitTimer0
       0178  _Initial
       0196  _DectectOrientation
       019B  _InitAngle
       01AF  _main
       02DE  push_xgset300C
       02E3  pop_xgset300C
       02E8  asgncblk
       0301  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0060   0010 =     16. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __data_start
       0060  _UartData
       0061  _s_count
       0063  _AngleCountTime
       0065  _SpeedCountTime
       0067  _Orientation
       0069  _angle
       006B  _pos
       006D  _Data
       0070  __data_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0070   0104 =    260. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0070  uartintr.h:UART_TxTail
       0070  __bss_start
       0071  uartintr.h:UART_TxHead
       0072  uartintr.h:UART_TxBuf
       00F2  uartintr.h:UART_RxTail
       00F3  uartintr.h:UART_RxHead
       00F4  uartintr.h:UART_RxBuf
       0174  __bss_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0016 =     22. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

D:\iccv7avr\lib\crtAVR.o	[ crtavr.s ]
Angel_Speed.o	[ Angel_Speed.c ]
<library>	[ gpushx.s, pmstruct.s ]

User Global Definitions

ram_end = 0x25f
hwstk_size = 0x1e

User Base Address Definitions

func_lit = 0x1a
data = 0x60
eeprom:1.512

