
#include "motor.h"

uint16_t MotorData = {400};



void MotorInit()
{
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_1,  GPIO_PIN_SET);	// IN1
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_13, GPIO_PIN_SET);	// IN2

	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_14, GPIO_PIN_SET);	// IN3
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_15, GPIO_PIN_SET);	// IN4
	TIM3 -> CCR1 = 0;
	TIM3 -> CCR2 = 0;
}

void frontBehave()
{
	// 오른쪽 바퀴, 왼쪽 바퀴 모두 전진 (PWM 값 증가)
	if (MotorData <= 1000)
	{
		HAL_GPIO_WritePin(GPIOB, GPIO_PIN_1,  GPIO_PIN_RESET);
		HAL_GPIO_WritePin(GPIOB, GPIO_PIN_13, GPIO_PIN_SET);

		HAL_GPIO_WritePin(GPIOB, GPIO_PIN_14, GPIO_PIN_RESET);
		HAL_GPIO_WritePin(GPIOB, GPIO_PIN_15, GPIO_PIN_SET);
		MotorData += 50;
		TIM3 -> CCR1 = MotorData;
		TIM3 -> CCR2 = MotorData;
	}
	else
	{
		MotorData = 1000;
	}

}

void autofrontBehave()
{
		HAL_GPIO_WritePin(GPIOB, GPIO_PIN_1, GPIO_PIN_RESET);
		HAL_GPIO_WritePin(GPIOB, GPIO_PIN_13, GPIO_PIN_SET);

		HAL_GPIO_WritePin(GPIOB, GPIO_PIN_14, GPIO_PIN_RESET);
		HAL_GPIO_WritePin(GPIOB, GPIO_PIN_15, GPIO_PIN_SET);

		TIM3 -> CCR1 = 450;
		TIM3 -> CCR2 = 450;
}

void backBehave()
{
	// PWM 값 감소, 최소 400 제한
	if (MotorData >= 400)
	{
		HAL_GPIO_WritePin(GPIOB, GPIO_PIN_1, GPIO_PIN_SET);
		HAL_GPIO_WritePin(GPIOB, GPIO_PIN_13, GPIO_PIN_RESET);

		HAL_GPIO_WritePin(GPIOB, GPIO_PIN_14, GPIO_PIN_SET);
		HAL_GPIO_WritePin(GPIOB, GPIO_PIN_15, GPIO_PIN_RESET);
		MotorData -= 50;
		TIM3 -> CCR1 = MotorData;
		TIM3 -> CCR2 = MotorData;
	}
	else
	{
		MotorData = 400;
	}
}

void autobackBehave()
{

	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_1, GPIO_PIN_SET);
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_13, GPIO_PIN_RESET);

	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_14, GPIO_PIN_SET);
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_15, GPIO_PIN_RESET);
	TIM3 -> CCR1 = 450;
	TIM3 -> CCR2 = 450;

}

void front_Left()
{
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_1, GPIO_PIN_SET);
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_13, GPIO_PIN_SET);

	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_14, GPIO_PIN_RESET);
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_15, GPIO_PIN_SET);
	TIM3 -> CCR1 = MotorData;
	TIM3 -> CCR2 = MotorData;
}

void front_Right()
{
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_1, GPIO_PIN_RESET);
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_13, GPIO_PIN_SET);

	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_14, GPIO_PIN_SET);
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_15, GPIO_PIN_SET);

	TIM3 -> CCR1 = MotorData;
	TIM3 -> CCR2 = MotorData;
}

void back_Left()
{
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_1, GPIO_PIN_SET);
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_13, GPIO_PIN_RESET);

	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_14, GPIO_PIN_SET);
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_15, GPIO_PIN_SET);
	TIM3 -> CCR1 = MotorData;
	TIM3 -> CCR2 = MotorData;
}

void back_Right()
{
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_1, GPIO_PIN_SET);
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_13, GPIO_PIN_SET);

	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_14, GPIO_PIN_SET);
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_15, GPIO_PIN_RESET);

	TIM3 -> CCR1 = MotorData;
	TIM3 -> CCR2 = MotorData;
}

void stop()
{
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_1, GPIO_PIN_SET);
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_13, GPIO_PIN_SET);

	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_14, GPIO_PIN_SET);
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_15, GPIO_PIN_SET);
	TIM3 -> CCR1 = 0;
	TIM3 -> CCR2 = 0;
}

void autostop()
{
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_1, GPIO_PIN_SET);
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_13, GPIO_PIN_SET);

	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_14, GPIO_PIN_SET);
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_15, GPIO_PIN_SET);
	TIM3 -> CCR1 = 0;
	TIM3 -> CCR2 = 0;
}

void auto_Left()
{
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_1, GPIO_PIN_SET);
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_13, GPIO_PIN_SET);

	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_14, GPIO_PIN_RESET);
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_15, GPIO_PIN_SET);
	TIM3 -> CCR1 = 700;
	TIM3 -> CCR2 = 700;
}

void auto_Right()
{
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_1, GPIO_PIN_RESET);
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_13, GPIO_PIN_SET);

	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_14, GPIO_PIN_SET);
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_15, GPIO_PIN_SET);
	TIM3 -> CCR1 = 700;
	TIM3 -> CCR2 = 700;
}


//static uint16_t motorSpeed = 500; // 기본 속도
//
//
//void MotorInit()
//{
//
//}
//
//// 모터 속도 설정 + PWM 업데이트
//void SetSpeed(uint16_t speed)
//{
//  if(speed > 1000) speed = 1000;
//  motorSpeed = speed;
//  UpdatePWM();
//}
//
//// 현재 모터 속도
//uint16_t GetSpeed()
//{
//  return motorSpeed;
//}
//
//// CCR1,2에 적용
//void UpdatePWM()
//{
//  TIM3->CCR1 = motorSpeed;
//  TIM3->CCR2 = motorSpeed;
//}
//
//void Forward()
//{
//  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_1, GPIO_PIN_SET);     // IN1
//  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_13, GPIO_PIN_RESET);  // IN2
//  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_14, GPIO_PIN_SET);    // IN3
//  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_15, GPIO_PIN_RESET);  // IN4
//
//  UpdatePWM();
//}
//
//void Backward()
//{
//  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_1, GPIO_PIN_RESET);   // IN1
//  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_13, GPIO_PIN_SET);    // IN2
//  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_14, GPIO_PIN_RESET);  // IN3
//  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_15, GPIO_PIN_SET);    // IN4
//
//  UpdatePWM();
//}
//
//void Stop()
//{
//  TIM3->CCR1 = 0;
//  TIM3->CCR2 = 0;
//}
//
//void Left()
//{
//  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_1, GPIO_PIN_RESET);   // IN1
//  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_13, GPIO_PIN_SET);    // IN2
//  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_14, GPIO_PIN_SET);    // IN3
//  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_15, GPIO_PIN_RESET);  // IN4
//
//  UpdatePWM();
//}
//
//void Right()
//{
//  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_1, GPIO_PIN_SET);     // IN1
//  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_13, GPIO_PIN_RESET);  // IN2
//  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_14, GPIO_PIN_RESET);  // IN3
//  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_15, GPIO_PIN_SET);    // IN4
//
//  UpdatePWM();
//}


