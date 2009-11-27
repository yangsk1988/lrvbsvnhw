#include <io8515v.h>
#include <macros.h>

#pragma interrupt_handler ISR_int0_handler:2 TIMER1_OVF:7 ISR_int1_handler:3

#define CLK_DIV_BY_1		0x01 
#define CLK_DIV_BY_8		0x02  
#define CLK_DIV_BY_64		0x03  
#define CLK_DIV_BY_256		0x04
#define CLK_DIV_BY_1024		0x05
#define TMR1_OVF_INT_ENA	0x80
#define INT0_ENA_INT1_ENA	0xC0
#define INT0_TRIG_FALLING_EDGE_INT1_TRIG_FALLING_EDGE	0x0A

//int PreviousNum =0;
//int CurrentNum =0;
//int count =0;
//int Frequency =0;
//static int SubNum =0;
//static int temptime =0;
//static unsigned char StartFlag =0;
//unsigned char Data[4] ={'#',0,0,'#'};
int s_count=0;
int AngleCountTime = 0;
int SpeedCountTime = 0;

void ISR_int0_handler()
{
	s_count -= (AngleCountTime*256+TCNT0);
	AngleCountTime=0;
	TCNT0=0;

	//CurrentNum = TCNT1H*256+TCNT1L;	
	//StartFlag =1;
	//count++;	
}

void ISR_int1_handler()
{
    s_count += (AngleCountTime*256+TCNT0);
	AngleCountTime=0;
	TCNT0=0;

    /*will lead to acummulative error
	s_count += (AngleCountTime*256+TCNT0);
	TCNT0=0;
	AngleCountTime=0;*/	
}

void TIMER1_OVF()
{	           
	TCNT1L = 0x00;
	TCNT1H = 0x00;
	SpeedCountTime++;	
}

void InitTimer1()
{
    TCCR1B =0x00;
	TCCR1A = 0;
	TCNT1H = 0x00;           
	TCNT1L = 0x00;
	TCCR1B = 0x07;
	TIMSK |= (1<<TOIE1);
}

void OpenInt0_Int1()
{
    MCUCR = INT0_TRIG_FALLING_EDGE_INT1_TRIG_FALLING_EDGE;
	GIMSK = INT0_ENA_INT1_ENA;	
}

/*void delay()
{
int i,j;
for(i=0;i<256;i++)
for(j=0;j<256;j++)
;
}*/

/*
int TestCondition()
{
    int TempFrequency =0;
	if(count==2)
	{
		SubNum = CurrentNum-PreviousNum;
		if(SubNum<0)
		{
			SubNum = SubNum+65536;	
		}
		TempFrequency = 460800/SubNum;
		if(TempFrequency<=10)
		{
			count =1;
			PreviousNum = CurrentNum;	
			return 0;
		}
		temptime = TempFrequency/300+1;
		if(temptime<=count-1)
			return 1;
		else 
			return 0;
	}
	else
	{
		if(temptime<=count-1)
			return 1;
		else
			return 0;
	}
}

void GetSpeedFrequency()
{
     if(StartFlag)
		{
			StartFlag =0;
			if(count<=1)
			{
				PreviousNum = CurrentNum;	
			}
			else
				if(TestCondition())
				{
					count =1;
					SubNum = CurrentNum-PreviousNum;
					if(SubNum<0)
					{
						SubNum = SubNum+65536;	
					}					
					Frequency = 460800/(SubNum/temptime);
					//Data[1] = Frequency%256;
					//Data[2] = Frequency/256;
					PreviousNum = CurrentNum;	
				}	
		}
}*/

/*
void main()
{
	DDRB = 0xFF;
	PORTB = 0x00;

	TCCR1B =0x00;
	TCCR1A = 0;
	TCNT1H = 0x00;           
	TCNT1L = 0x00;
	TCCR1B = CLK_DIV_BY_8;
	TIMSK = TMR1_OVF_INT_ENA;
	MCUCR = INT0_TRIG_RISING_EDGE;
	GIMSK = INT0_ENA;	
	SREG = GLOBAL_INT_ENA;

	InitUART(11);

	while(1)
	{	
		if(StartFlag)
		{
			StartFlag =0;
			if(count<=1)
			{
				PreviousNum = CurrentNum;	
			}
			else
				if(TestCondition())
				{
					count =1;
					SubNum = CurrentNum-PreviousNum;
					if(SubNum<0)
					{
						SubNum = SubNum+65536;	
					}					
					Frequency = 460800/(SubNum/temptime);
					Data[1] = Frequency%256;
					Data[2] = Frequency/256;
					PreviousNum = CurrentNum;	
					SendString(Data);
				}	
		}
	}	
}*/