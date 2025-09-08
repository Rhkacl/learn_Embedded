
#ifndef INC_BUTTON_H_
#define INC_BUTTON_H_


#include "main.h"
#include "stdbool.h"



typedef struct
{
  GPIO_TypeDef    *port;
  uint16_t        pinNumber;
  GPIO_PinState   onState;
}BUTTON_CONTROL;


bool buttonGetPressed(uint8_t num);   // bool -> 참 아니면 거짓 값만 가진다.



#endif /* INC_BUTTON_H_ */
