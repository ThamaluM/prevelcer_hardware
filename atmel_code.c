#define F_CPU 8888888UL			/* Define frequency here its 8MHz */
#include <avr/io.h>
#include <util/delay.h>
#include <stdlib.h>
#include <stdio.h>
//#include <iostream>
//#include <string>
//#include <string>

#define ROWPORT PORTB
#define COLPORT PORTC

#define ROWPORTDIR DDRB
#define COLPORTDIR DDRC

#define NROWS 8
#define NCOLS 8


//#define USART_BAUDRATE 115200
#define BAUD_PRESCALE (((F_CPU / (USART_BAUDRATE* 16UL))) - 1)


void UART_init(long USART_BAUDRATE)
{
	UCSRB |= (1 << RXEN) | (1 << TXEN);/* Turn on transmission and reception */
	UCSRC |= (1 << URSEL) | (1 << UCSZ0) | (1 << UCSZ1);/* Use 8-bit character sizes */
	//UCSRC = (1<<URSEL)|(1<<USBS)|(3<<UCSZ0);
	UBRRL = BAUD_PRESCALE;		/* Load lower 8-bits of the baud rate value */
	UBRRH = (BAUD_PRESCALE >> 8);	/* Load upper 8-bits*/
}

unsigned char UART_RxChar()
{
	while ((UCSRA & (1 << RXC)) == 0);/* Wait till data is received */
	return(UDR);			/* Return the byte*/
}

void UART_TxChar(char ch)
{
	while (! (UCSRA & (1<<UDRE)));	/* Wait for empty transmit buffer*/
	UDR = ch ;
	//_delay_ms(50);
}

void UART_SendString(char *str)
{
	unsigned char j=0;
	
	while (str[j]!=0)		/* Send string till null */
	{
		UART_TxChar(str[j]);
		j++;
	}
}

char * UART1_Rx_Str()
{
	char string[20], x, i = 0;

	//receive the characters until ENTER is pressed (ASCII for ENTER = 13)
	while((x = UART_RxChar()) != 13)
	{
		//and store the received characters into the array string[] one-by-one
		string[i++] = x;
	}

	//insert NULL to terminate the string
	string[i] = '\0';

	//return the received string
	return(string);
}



void ADC_Init()
{
	DDRA=0x0;			/* Make ADC port as input */
	ADCSRA = 0x87;			/* Enable ADC, fr/128  */
	ADMUX = 0x40;			/* Vref: Avcc, ADC channel: 0 */
	
}

int ADC_Read(char channel)
{
	int Ain,AinLow;
	
	ADMUX=ADMUX|(channel & 0x0f);	/* Set input channel to read */

	ADCSRA |= (1<<ADSC);		/* Start conversion */
	while((ADCSRA&(1<<ADIF))==0);	/* Monitor end of conversion interrupt */
	
	_delay_us(10);
	AinLow = (int)ADCL;		/* Read lower byte*/
	Ain = (int)ADCH*256;		/* Read higher 2 bits and 
					Multiply with weight */
	Ain = Ain + AinLow;				
	return(Ain);			/* Return digital value*/
}
 

int main()
{
	char c;
	int value;
	char buffer [50];
	TCCR0 = 0x03;
	UART_init(9600);
	ADC_Init();
	
	
	
	
	//UART_SendString("\n\t Echo Test ");
	//DDRC = 11111111;
	ROWPORTDIR = 7;
	COLPORTDIR = 7;
	while(1)
	{
		
		int i = 0;
		int j = 0;
		
		_delay_ms(50);
		UART_SendString("start_cycle\n");
		_delay_ms(1000);
		while (i<NROWS){
			ROWPORT = i;
			j = 0;
			while(j<NCOLS){
				COLPORT = j;
				value = ADC_Read(0);
				char buffer[20];
				snprintf(buffer, 20, "x=%d&y=%d&p=%d\n",j+1,i+1,value);				
				UART_SendString(buffer);	
				_delay_ms(1000);
				j++;			
			}
			i++;
		}
		
		
		
		//PORTC = 11111111;
		_delay_ms(2000);
	}
}
