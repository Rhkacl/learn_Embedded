

#ifndef INC_MOTOR_H_
#define INC_MOTOR_H_

#include "main.h"

//void MotorInit();
//void Forward();
//void Backward();
//void Stop();
//void Left();
//void Right();
//void SetSpeed(uint16_t speed);  // 모터 속도 설정 + PWM 업데이트
//uint16_t GetSpeed();  // 현재 모터 속도
//void UpdatePWM(); // CCR1,2에 적용

typedef enum {
    STOP = 0,
    FORWARD,
    BACKWARD
} DriveState;

typedef enum {
    None = 0,
    Left,
    Right
} TurnState;

extern DriveState currentState;
extern TurnState turn;

void MotorInit();
void frontBehave();
void backBehave();
void front_Left();
void front_Right();
void back_Left();
void back_Right();
void stop();
void autofrontBehave();
void autobackBehave();
void autostop();
void auto_Right();
void auto_Left();

#endif /* INC_MOTOR_H_ */
