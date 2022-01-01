#include "stm32f10x.h"
#include "bsp_led.h"

#include <stdio.h>

void Delay(__IO uint32_t nCount);

#define DELAY_TIME 0x5fffff

int main(void)
{
	LED_GPIO_Config();	 
	
	while (1) {
		LED1( ON );
		Delay(DELAY_TIME);
		LED1( OFF );

		LED2( ON );
		Delay(DELAY_TIME);
		LED2( OFF );

		LED3( ON );
		Delay(DELAY_TIME);
		LED3( OFF );		
	}
}

void Delay(__IO uint32_t nCount)
{
	for(; nCount != 0; nCount--);
}
/*********************************************END OF FILE**********************/
