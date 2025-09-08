#include "led.h"


LED_CONTROL led[8] =
    {
        {GPIOC, GPIO_PIN_9, 1, 0,},
        {GPIOB, GPIO_PIN_8, 1, 0,},
        {GPIOB, GPIO_PIN_9, 1, 0,},
        {GPIOA, GPIO_PIN_5, 1, 0,},
        {GPIOA, GPIO_PIN_6, 1, 0,},
        {GPIOA, GPIO_PIN_7, 1, 0,},
        {GPIOB, GPIO_PIN_6, 1, 0,},
        {GPIOC, GPIO_PIN_7, 1, 0,}
    };


void ledOn(uint8_t num)
{
  for(uint8_t i = 0; i < num; i++)
  {
    HAL_GPIO_WritePin(led[i].port, led[i].pinNumber, led[i].onState);
  }
}

void ledOff(uint8_t num)
{
  for(uint8_t i = 0; i < num; i++)
  {
    HAL_GPIO_WritePin(led[i].port, led[i].pinNumber, led[i].offState);
  }
}

void ledToggle(uint8_t num)
{
  for(uint8_t i = 0; i < num; i++)
  {
    HAL_GPIO_TogglePin(led[i].port, led[i].pinNumber);
  }
}


void ledLeftShift(uint8_t num)
{
  for(uint8_t i = 0; i < num; i++)
  {
    HAL_GPIO_WritePin(led[i].port, led[i].pinNumber, led[i].onState);
    HAL_Delay(200);
    HAL_GPIO_WritePin(led[i].port, led[i].pinNumber, led[i].offState);
  }
}


void ledRightShift(uint8_t num)
{
  for(uint8_t i = num; i > 0; i--)
  {
    HAL_GPIO_WritePin(led[i-1].port, led[i-1].pinNumber, led[i-1].onState);
    HAL_Delay(200);
    HAL_GPIO_WritePin(led[i-1].port, led[i-1].pinNumber, led[i-1].offState);
  }
}


void ledFlower(uint8_t num)
{
  for(int8_t i = 0; i < num / 2; i++)
  {
    // 양쪽 LED ON
    HAL_GPIO_WritePin(led[i].port, led[i].pinNumber, led[i].onState);
    HAL_GPIO_WritePin(led[num - 1 - i].port, led[num - 1 - i].pinNumber, led[num - 1 - i].onState);
    HAL_Delay(200);
    // 양쪽 LED OFF
    HAL_GPIO_WritePin(led[i].port, led[i].pinNumber, led[i].offState);
    HAL_GPIO_WritePin(led[num - 1 - i].port, led[num - 1 - i].pinNumber, led[num - 1 - i].offState);
  }

  // 양쪽 가운데로
  for(int8_t i = num / 2 - 1;i >= 0;i--)
  {
    HAL_GPIO_WritePin(led[i].port, led[i].pinNumber, led[i].onState);
    HAL_GPIO_WritePin(led[num - 1 - i].port, led[num - 1 - i].pinNumber, led[num - 1 - i].onState);
    HAL_Delay(200);
    HAL_GPIO_WritePin(led[i].port, led[i].pinNumber, led[i].offState);
    HAL_GPIO_WritePin(led[num - 1 - i].port, led[num - 1 - i].pinNumber, led[num - 1 - i].offState);
  }
}

void ledEven(uint8_t num)   // 짝수 LED ON
{
  for(uint8_t i = 0;i < num;i++)
  {
    if(i % 2 == 0)
    {
      HAL_GPIO_WritePin(led[i].port, led[i].pinNumber, led[i].onState);
      HAL_Delay(200);
      HAL_GPIO_WritePin(led[i].port, led[i].pinNumber, led[i].offState);
    }
  }
}


void ledOdd(uint8_t num)    // 홀수 LED OFF
{
  for(uint8_t i = 0;i < num;i++)
  {
    if(i % 2 == 1)
    {
      HAL_GPIO_WritePin(led[i].port, led[i].pinNumber, led[i].onState);
      HAL_Delay(200);
      HAL_GPIO_WritePin(led[i].port, led[i].pinNumber, led[i].offState);
    }
  }
}
