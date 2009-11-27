#include "uartintr.h"
#include "SpeedDection.h"

#pragma interrupt_handler TIMER0_OVF:8

//int PreCountNum = 0,CurrentCountNum = 0;
//unsigned char SubNum =0;
//int DataH =0,DataL = 0;
//int flag= 0;
int Orientation=0;
int angle=0,pos = 0;
//unsigned char TestNum;
extern int s_count;
extern int AngleCountTime;

unsigned char Data[3] ={'#',0,0};

void TIMER0_OVF()
{
	TCNT0 = 00; 
	AngleCountTime++;
}

void InitTimer0()
{
	TCCR0 = 0x07;
	TCNT0 = 00;
	TIMSK |= (1<<TOIE0);
}

void Initial()
{
	TCNT0 = 00;//8 bits counter
	TCNT1H = 0x00;// 16bits counter high byte           
	TCNT1L = 0x00;//low byte
	s_count=0;//software counter
	angle=0;//angle of handle
	pos = 0;//position
	AngleCountTime =0;//times of TCNT0 overflow
	SpeedCountTime =0;//Position CountTime;
	Data[1] =0;
	Data[2] =0;	
}

int DectectOrientation()
{
	return (PINB & (1 << PB2) );
	
}

void InitAngle()
{
 	 		TCNT0 = 00;
			//TCNT1H = 0x00;           
			//TCNT1L = 0x00;
			s_count=0;
			angle=0;
			//pos = 0;
			AngleCountTime =0;
			Data[1] =0;
			Data[2] =0;
}

void main()
{


	char VER[] = "VIRTUALBICYCLE#";	
	int i;
	DDRB = 0x00;//"0"-input;"1"-output
	PORTB = 0x03;
	DDRA = 0x00;
	PORTA = 0xFF;
	DDRC = 0x00;//
	PORTC = 0xFF;//initial value

	InitUART(11);//set bandrate,19200 in 3.686M
	InitTimer0();
	InitTimer1();
	OpenInt0_Int1();
	
    

	_SEI();	

	while(1)
	{
	    //check if Z is high,         
        if( PINA  & (1 << PA7))//PA7 is high, corresponding to Z high.which is zero position signal of sensor
        {
			InitAngle();
        }
		
		switch(ReceiveByte())
		{
		case 0xFF:break; 
		case 'D':/*Sending ALL*/
		
		/*case A*/
			 if(DectectOrientation())
			{
				angle = s_count+(AngleCountTime*256+TCNT0);
			}
			else
			{
				angle = s_count-(AngleCountTime*256+TCNT0);
			}
			Data[1] =angle>>8;//high 
			Data[2] =angle&0x00FF;//low	
			TransmitByte('A');
			SendString(Data);//send data[2] first,then data[1],data[0];
			
		/*case B*/
			pos = TCNT1H*256+TCNT1L;
			Data[1] =pos>>8;
			Data[2] =pos&0x00FF;	
			TransmitByte('B');
			SendString(Data);
				
		/*case S*/
			TransmitByte('S');
			//if(PINA & (1 << PA2));
			
			PORTC = PINC;
			TransmitByte(PORTC);
			
			PORTA = PINA;
			TransmitByte(PORTA);
			TransmitByte('#');		
		break;
		
		case 'A'://angle
			if(DectectOrientation())
			{
				angle = s_count+(AngleCountTime*256+TCNT0);
			}
			else
			{
				angle = s_count-(AngleCountTime*256+TCNT0);
			}
			Data[1] =angle>>8;
			Data[2] =angle&0x00FF;	
			TransmitByte('A');
			SendString(Data);	
			break;

		case 'B'://position
			pos = TCNT1H*256+TCNT1L;
			Data[1] =pos>>8;
			Data[2] =pos&0x00FF;	
			TransmitByte('B');
			SendString(Data);	
			break;

		case 'C'://Clear Command
			 InitAngle();//only init angle, position imformation will not clear.
			 TransmitByte('C');
			 SendString(Data);
			break;

		case 'S'://switch, key
			TransmitByte('S');
			//if(PINA & (1 << PA2));		
			
			PORTC = PINC;
			TransmitByte(PORTC);
			
			PORTA = PINA;
			TransmitByte(PORTA);
			TransmitByte('#');
			break;
			
		case 'R'://version information
			 for(i = 0;VER[i]!='\0';i++)
			 {
			  TransmitByte(VER[i]);
			 }
			 
			 
		
		break;
			
		
			
		default:;
		}
	}
	/*  Orientation=DectectOrientation();
	if(flag)
	{
	flag = 0;
	CurrentCountNum =DataH*256 + DataL;
	if(CurrentCountNum>=PreCountNum)	
	{
	SubNum = CurrentCountNum - PreCountNum;
	}
	else
	{
	SubNum = CurrentCountNum + 65536 - PreCountNum;
	}

	if(Orientation)
	angle +=SubNum;
	else
	angle -=SubNum;

	PreCountNum = CurrentCountNum;
	}
	}*/
}
