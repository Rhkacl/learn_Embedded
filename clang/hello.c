#include <stdio.h> // IO 관련 헤더파일 불러옴 , 전처리기, 표준함수 -> 입출력
// #define APPLE 10 // 앞으로 APPLE는 10(숫자)이다.
// #define NAME "사과" // 문자열 %s

// int main() //C언어 메인함수의 시작 
// {
//     //printf("Hello World \n\n\n"); //터미널에 프린트
//     int a = 20;
//     int b = 0xff;
//     printf("%s, %d, %c, %d%%, %d \n\n\n" , NAME, APPLE, 'a', a, b); // %s - 문자열, %c - 문자, %d - 부호포함 int 타입크기의 정수 
//     // \n 줄바꿈
//     // \r 커서를 맨 앞으로
//     // \t 탭

//     return 0;
// }
// /* 서식지정자
// * 
// */

//sizeof() 연산자 - 괄호안에 있는것을 바이트 크기로 반환
// int main()
// {
//     char ch;
//     int num;
//     double x;

//     printf("char 형의 바이트 크기 : %d \n", sizeof(char));
//     printf("short 형의 바이트 크기 : %d \n", sizeof(short));
//     printf("long 형의 바이트 크기 : %d \n", sizeof(long));
//     printf("float 형의 바이트 크기 : %d \n", sizeof(float));

//     printf("ch 형의 바이트 크기 : %d \n", sizeof(ch));
//     printf("num 형의 바이트 크기 : %d \n", sizeof(num));
//     printf("x 형의 바이트 크기 : %d \n\n", sizeof(x));
// }

// C언어에서 변수의 선언과 사용
// int num 
// 영문자, 숫자, 특수문자(_) : 변수명 선언자
// 첫글자는 반드시 영문자, 특수문자만 가능
// C언어는 대소문자를 구분함
// 변수명에 키워드(예약어) 불가

// 카멜 표기법 - int manAge : 첫단어는 소문자 결합되는 단어는 대문자로 시작
// 스네이크 표기법 - int man_age : 단어사이는 언더스코어로 연결
// 파스칼 표기법 - int ManAge : 첫 시작 단어는 대문자로
// 헝가리안 표기법 - int iManName : 변수명 앞에 데이터 타입을 명시

// 변수의 초기화 : 변수를 선언하고 초기화 하지 않으면 지역변수는 쓰레기값

// int g; // 전역변수 

// int main()
// {
//     int price = 6;      // 지역변수(Local Variable)
//     static int num; // 지역변수, 정적변수

//     printf("%d \n", price);
//     printf("%d \n", g);
//     printf("%d \n", num);
// }

// 순서대로 진행, 지역변수는 초기화 필요
// int main()
// {
//     int amount = 0;
//     int price = 0;
//     int totalPrcie = 0;

//     printf("amount = %d, price = %d \n", amount, price);
//     printf("수량을 입력하세요 : ");
//     scanf("%d", &amount);

//     price = 100;

//     totalPrcie = amount * price;
//     printf("합계 : %d \n\n\n", totalPrcie);
// }

// 산술연산자 (+, -, *, /, %, ++, --)
// int main()
// {
//     int a = 39;
//     int b = 17;
//     int result;

//     result = a + b;
//     printf("a + b = %d\n", result);

//     result = a - b;
//     printf("a - b = %d\n", result);

//     result = a * b;
//     printf("a * b = %d\n", result);

//     result = a / b;
//     printf("a / b = %d\n", result);

//     result = a % b;
//     printf("a %% b = %d\n", result);
// }

// 대입연산자 (=, +=, -=, *=, /=, %=)
// ex) a += b -> a = a + b

// 관계연산자
// ==, !=(같지않다), >, <, >=, <=   

// 논리연산자
// && 두개의 값이 ture 일때만 true
// || 두개의 값 중 하나만 true -> true
// ! true이면 false, false면 true

// int main()
// {
//     int month;
//     printf("몇 월?? : ");
//     scanf("%d", &month);

//     if(month >= 6 && month <=8) // AND
//     {
//         printf("성수기 요금 적용\n");
//     }

//     if(month < 6 || month > 8) // OR
//     {
//         printf("일반 요금 적용\n");
//     }
//     ;
// }

// // 삼향연산자 (또는 조건 연산자)
// expression1 ? expression2 : expression3
// // 만약 express 1이 참이면 express 2가 수행, 참이 아니면 express3 수행

// a = 1, b = 0
// a || b ? 1 : 2
// a && b ? 1 : 2

// 특수연산자
// sizeof() 소괄호안에 것을 바이트크기로 반환
// & // 변수가 저장된 메모리상의 주소값을 반환
// * // 변수의 포인터

// 비트 연산자
// &, |, ^, ~, <<, >> 

// int main()
// {
//     int n1 = 15;            // 0b00000000 00000000 00000000 00001111
//     int n2 = 20;            // 0b00000000 00000000 00000000 00010100
//     //int result = n1 & n2;   // 0b00000000 00000000 00000000 00000100
//     //int result = n1 | n2;   // 0b00000000 00000000 00000000 00011111
//     //int result = n1 ^ n2;   // 0b00000000 00000000 00000000 00011011
//     int result = ~n1;       // 0b00000000 00000000 00000000 11110000

//     printf("n1 = %d\n", n1);
//     printf("n2 = %d\n", n2);
//     printf("result = %d\n", result);
// }

// int main()
// {
//     int n1 = 1;             // 0b00000000 00000000 00000000 00000001
//     int s1 = n1 << 1;       // 0b00000000 00000000 00000000 00000010
//     int s2 = n1 << 2;       // 0b00000000 00000000 00000000 00000100
//     int s3 = n1 << 3;       // 0b00000000 00000000 00000000 00001000
//     int s4 = n1 << 4;       // 0b00000000 00000000 00000000 00010000

//     printf("N1 = %d\n", n1);
//     printf("S1 = %d\n", s1);
//     printf("S2 = %d\n", s2);
//     printf("S3 = %d\n", s3);
//     printf("S4 = %d\n", s4);
// }

// int main()
// {
//     char a;

//     a = -128;
//     printf("%d\n", a);

//     a = -129;
//     printf("%d\n", a);
// }

// int main()
// {
//     unsigned char a; 

//     a = 255;
//     printf("%d\n", a);

//     a = 256;
//     //a += 1; // 위에랑 똑같음
//     printf("%d\n", a);
// }

// 비트 마스크 - 특정 비트를 조작

// int main()
// {
//     //unsigned short data = 0x5678; // 0101 0110 0111 1000
//     unsigned short data = 0x0000; // 0000 0000 0000 0000

//     unsigned short msk1 = 0xf000; // 1111 0000 0000 0000
//     unsigned short msk2 = 0x0f00; // 0000 1111 0000 0000
//     unsigned short msk3 = 0x00f0; // 0000 0000 1111 0000
//     unsigned short msk4 = 0x000f; // 0000 0000 0000 1111
 
//     // printf("결과값 1 = %#.4x\n", data & msk1); // 0101 - 0x5000 
//     // printf("결과값 2 = %#.4x\n", data & msk2); // 0110 - 0x0600
//     // printf("결과값 3 = %#.4x\n", data & msk3); // 0111 - 0x0070
//     // printf("결과값 4 = %#.4x\n", data & msk4); // 1000 - 0x0008

//     printf("결과값 1 = %#.4x\n", data | msk1); // 1111 
//     printf("결과값 2 = %#.4x\n", data | msk2); // 1111
//     printf("결과값 3 = %#.4x\n", data | msk3); // 1111
//     printf("결과값 4 = %#.4x\n", data | msk4); // 1111
// }

// & 연산자는 특정비트를 0으로 만들고, | 연산자는 특정비트를 1로 만들고, ^ 연산자는 특정비트를 반전시킨다.
/*
0b10101 -> 0b11101 만들고 싶음
  10101
|     1 << 3 => 01000

  10101
| 01000   
---------
  11101 => 3번째 자리에 1을 추가함
  
*** 삭제
  11101 => 3번째 자리의 1을 삭제 하고 싶음 => & 사용
  
  1 << 3 => 01000
  추가 하고 싶으면 |, 삭제하고 싶으면 &
  */

// int main()
// {
//     int a, b, c; // 정수
//     double average; // 실수

//     printf("정수 3개를 입력하세요 : \n");
//     scanf("%d %d %d", &a, &b, &c);

//     average = (double)(a + b + c) / 3;
//     printf("평균은 : %f\n", average);
// }

//if문
// int main()
// {
//     int num = 0;
    
//     printf("숫자를 입력하세요 : \n");
//     scanf("%d", &num);

//     if(num < 5){
//         printf("입력한 숫자는 5보다 작다.\n");
//     }
    // if(num = 5){
    //     printf("입력한 숫자는 5하고 같다.\n");
    // }
    // else{
    //     if(num == 5){
    //         printf("입력한 숫자는 5와 같다.\n");
    //     }
    //     else{
    //         printf("입력한 숫자는 5보다 크다.\n");
    //     }
    // }
    // if(num < 5){
    //     printf("입력한 숫자는 5보다 크다.\n");
    // }
//}

// int main()
// {
//     int num;
//     printf("숫자를 입력하세요 : \n");
//     scanf("%d", &num);
//     printf("%s\n", num < 5 ? "입력한 숫자는 5보다 작다" :
//                    num == 5 ? "입력한 숫자는 5와 같다." :
//                               "입력한 숫자는 5보다 크다.");
// }

// switch case 문

// int main()
// {
//     int num;
//     printf("미세먼지 농도를 선택하시오 : \n");
//     printf("1 : 좋음\n");
//     printf("2 : 보통\n");
//     printf("3 : 나쁨\n");
//     scanf("%d", &num);

//     switch (num)
//     {
//         case 1:
//             printf("미세먼지 농도가 좋음 마스크 필요x\n");
//             break;
//         case 2:
//             printf("미세먼지 농도가 보통 마스크 선택\n");
//             break;
//         case 3:
//             printf("미세먼지 농도가 나쁨 마스크를 착용하세요\n");
//             break;
//     default:
//         printf("다시 입력하세요.\n");
//         break;
//     }
// }

//while 문

// int main()
// {
//     int weight = 80; 
//     int count = 0;

//     while (weight > 60)
//     {
//         printf("운동해서 1kg을 뺀다.\n");
//         weight--;
//         count++;
//     }
//     printf("축하합니다. 운동 안해도 됩니다.\n");
//     printf("%d 일 운동 했음\n\n", count);
    
// }

//for 문

// int main()
// {
//     int weight;
//     int count = 0;

//     // for(초기식(값); 조건식; 증감식)
//     for(weight = 80; weight > 60; weight--)
//     {
//         printf("열심히 운동 했음\n");
//         count++;
//     }
//     printf("운동을 더 이상 안해도 됨 %d일 운동함.\n", count);
// }

// int main()
// {
//   int i, j;

//   for(i = 0; i < 5; i++)
//   {
//     for(j = 0; j <= i; j++)
//     {
//       printf("*");
//     }
//     printf("\n");
//   }
  
//   for(i = 4; i > 0; i--)
//   {
//     for(j = 0; j < i; j++)
//     {
//       printf("*");
//     }
//     printf("\n");
//   }
// }

/*
*함수 (Function)
- 프로그래밍에서 함수란 특별한 목적의 작업을 수행하기 위한 독립적으로 설계된 프로그램 코드의 집합
- 표준함수 / 사용자정의 함수

type function_name(parameter list, , , , ,)
{
  declations
  statement
}

int sum(x, y)
{
  int sum;
  sum = x + y; // 함수의 본체
  return sum;
}

void sum(x, y)
{
  int sum;
  sum = x + y;
}
*/

// int printHello()
// {
//   printf("Hello World\n");
//   return 0;
// }

//int printHello(); // 함수의 원형

// int main()
// {
//   printf("함수를 호출합니다.\n");
//   printHello();

//   printf("함수를 또 호출합니다.\n");
//   printHello();
// }

// int printHello()
// {
//   printf("Hello World\n");
//   return 0;
// }

// int add(int a, int b);

// int main()
// {
//   int x, y, z;
//   printf("정수 2개를 입력하세요 : ");
//   scanf("%d %d", &x, &y);

//   z = add(x, y);
//   printf("%d\n", z);
// }

// int add(int a, int b)
// {
//   int sum;
//   sum = a + b;
//   return sum;
// }

/*
*변수의 유효범위
-지역변수
-전역변수
-정적변수
*/

//지역변수
/*
-블록 {} 내에서 선언된 변수
-블록 내에서만 유효, 블록이 종료되면 메모리에서 사라짐
-메모리영역내의 stack(스택)영역에 저장, 초기화하지 않으면 쓰레기값
-함수의 매개변수도 함수내에서는 지역변수로 취급
-프로그램이 실행될 때 메모리 확보
*/

// int main()
// {
//   int i = 5; // local variable
//   int var = 10; // local variable

//   printf("main()함수내의 지역변수 var의 값 : %d\n", var);

//   if(i < 10)
//   {
//     local(); // 함수 호출
//     int var = 30; // if문 내의 local variable
//     printf("if문내에서의 var 값 : %d\n", var);
//   }
//   printf("현재 지역변수 var의 값 : %d\n", var);
// }

// void local(void)
// {
//   int var = 20; // local() 내의 local variable
//   printf("local() 함수 내에서의 지역변수 : %d\n", var);
// }

/*
*정적변수
-static(키워드)로 정의된 변수 ex) static int a;
-전역변수와 지역변수의 특징을 모두 가지고 있다.
-함수내에서 선언된 정적변수는 단 한번만 초기화 가능
 프로그램이 종료되어야 메모리에서 삭제됨
 위에처럼 선언된 정적변수는 지역변수처럼 해당 함수(블록)에서만 접근 가능
-전역변수처럼 초기화 하지 않으면 0으로 초기화 됨
*/

// void local();
// void staticVar();

// int main()
// {
//   int i;
//   for(i = 0; i < 3; i++)
//   {
//     local();
//     staticVar();
//   }
// }

// void local()
// {
//   int count = 1;
//   printf("local() 함수가 %d 번째 호출되었다.\n", count);
//   count++;
// }

// void staticVar()
// {
//   static int staticCount = 1;
//   printf("staticVar() 함수가 %d 번째 호출되었다.\n", staticCount);
//   staticCount++;
// }

/*
*전역변수란 ? >> 함수의 외부에 선언된 변수(main)
-프로그램의 어디에서나 접근이 가능, 프로그램이 종료되어야 메모리에서 삭제
-data 영역에 저장, 컴파일할 때 메모리 확보
-초기화하지 않아도 자동으로 0으로 초기화
*/

// void local(); // 함수의 원형 선언
// int var;      // var이라는 전역변수 선언

// int main()
// {
//   printf("전역변수 var값 : %d\n", var);
//   int var = 10; // 지역변수
//   printf("main() 내에서의 지역변수 var 값 : %d\n", var);

//   if(1)
//   {
//     local();
//     printf("현재 변수 var의 값 : %d\n", var);
//   }
//   printf("더 이상 main()함수에서는 전역변수 var에 접근 불가 !\n");
// }

// void local()
// {
//   int var = 20;
//   printf("local()함수 내에서 접근한 var의 값은? : %d\n", var);
// }

/*
*배열
-같은 데이터타입(형)의 변수들로 이루어진 유한집합!
-배열을 구성하는 각각의 값 >> 배열요소(element)
-요소의 위치를 가리키는 것 >> 인덱스(index)
-인덱스의 값은 언제나 0부터 시작, 양의정수값만 가질수 있다.
-배열의 요소는 항상 연속된 메모리에 저장됨

=> int num[0]; >> 배열의 크기는 0이 될 수 없음(불가)
=> int size = 100;
   int data[size]; >> 불가

=> #define MAX 5
   int data[MAX]; >> 가능(매크로 상수)
*/

// 배열의 크기 (단차원) 

// int main()
// {
//   int arr[5] = {0}; //초기화 // 4byte인 int 타입의 배열 5칸 선언
//   int byteArr = 0; // 배열의 byte 크기를 저장할 변수 선언
//   int size = 0; // 배열의 크기를 저장할 변수

//   byteArr = (sizeof(arr));
//   printf("배열의 byte크기 : %d\n", byteArr);

//   size = sizeof(arr) / sizeof(arr[0]);
//   printf("배열의 크기 : %d\n", size);
  
//   arr[2] = 7;

//  // for(int i = 0; i < size; i++)
//  // {
//  //   arr[i] = 0;
//  // }
//   for(int i = 0; i < size; i++)
//   {
//     printf("arr[%d] : %d :", i, arr[i]);
//   } //초기화
// }

// #define ARR_SIZE 5 // 매크로 상수로 지정

// int add(int a, int b) //{return a + b;} 같은 것
// {
//   return a + b;
// }

// int main()
// {
//   int arr[ARR_SIZE] = {0}; // 배열 전체를 0으로 초기화

//   arr[0] = 5;
//   arr[1] = arr[0] + 10; // 배열의 요소(원소)를 수식에 이용 
//   arr[2] = add(arr[0], arr[1]); // 함수의 인자로 사용 

//   printf("정수 2개를 입력하세요 : ");
//   scanf("%d %d", &arr[3], &arr[4]); // 입력값을 배열의 요소로 저장 

//   for(int i = 0; i < ARR_SIZE;i++)
//   {
//     printf(" %d  ", arr[i]);
//   }
//   printf("\n\n");
//   printf(" arr[5] = %d\n", arr[5]); // 쓰레기값 
// }

// int main()
// {
//   int i = 5;
//   char c = 'A';

//   printf(" 변수 i의 주소값 : %p\t 변수 i의 값 : %d\n", &i, i);
//   printf(" 변수 c의 주소값 : %p\t 변수 c의 값 : %d\n", &c, c);
// }

// int main()
// {
//   int arr[4]; // = {1, 3, 5, 7};
//   arr[0] = 1;
//   arr[1] = 3;
//   arr[2] = 5;
//   arr[3] = 7;
//   printf(" arr 배열의 첫번째 주소값 : %p\t 요소값 : %d\n", &arr[0], arr[0]);
//   printf(" arr 배열의 두번째 주소값 : %p\t 요소값 : %d\n", &arr[1], arr[1]);
//   printf(" arr 배열의 세번째 주소값 : %p\t 요소값 : %d\n", &arr[2], arr[2]);
//   printf(" arr 배열의 네번째 주소값 : %p\t 요소값 : %d\n", &arr[3], arr[3]);
// }

// 2차원 배열 

// int main()
// {
//   int arr_2[3][3] = {{1,2,3},{4,5,6},{7,8,9}}; // 행은 생략 가능, 열은 불가능 

//   for(int i = 0;i < 3;i++)
//   {
//     for(int j = 0;j < 3; j++)
//     {
//       printf("%d행 %d열 : %d | 주소 : %p\n", i+1, j+1, arr_2[i][j], &arr_2[i][j]);
//     }
//   }

  // for(int i = 0;i < 3;i++)
  // {
  //   for(int j = 0;j < 3; j++)
  //   {
  //     printf("%d행 %d열 : %d", i, j, arr_2[i][j]);
  //     if(j<3) printf(" | ");
  //     if(j==2) printf("\n");
  //   }
  // }

  // printf(" 1행 1열 : %d | ", arr_2[0][0]);
  // printf(" 1행 2열 : %d | ", arr_2[0][1]);
  // printf(" 1행 3열 : %d\n ", arr_2[0][2]);
  // printf(" 2행 1열 : %d | ", arr_2[0][0]);
  // printf(" 2행 2열 : %d | ", arr_2[0][1]);
  // printf(" 2행 3열 : %d\n ", arr_2[0][2]);
  // printf(" 3행 1열 : %d | ", arr_2[0][0]);
  // printf(" 3행 2열 : %d | ", arr_2[0][1]);
  // printf(" 3행 3열 : %d\n ", arr_2[0][2]);

  // int arr_2[3][3] = {
  //     {1,2,3},
  //     {4,5,6},
  //     {7,8,9}
  // };

  //int arr_2[3][3] = {1,2,3,4,5,6,7,8,9}; 
  // 같은 2차원 배열 코딩
//}

// 포인터 : 메모리상에 위치한 특정 데이터의 시작주소를 보관하는 변수 
// 포인터 연산자
// 주소연산자 (&) : 변수의 이름앞에 사용, 해당(변수) 주소값을 반환
// 참조연산자 (*) : 포인터의 이름앞에 사용, 포인터가 가리키는 곳(주소)에 저장된 값 반환 
// 포인터 선언
// 데이터형 *변수명; << 포인터 변수 선언
// 데이터형* 변수명;
// int *ptr;
// 포인터의 크기는 일정
// 포인터의 크기는 플랫폼에 따라서 결정
// 32bit : 4byte, 64bit 8byte

// int main()
// {
//   int *pi; // int 타입의 포인터변수 선언 
//   double *pd; // double 타입의 포인터변수 선언
//   char *pc; // char 타입의 포인터변수 선언

//   printf(" int형의 포인터 크기 : %d\n", sizeof(pi));
//   printf(" double형의 포인터 크기 : %d\n", sizeof(pd));
//   printf(" char형의 포인터 크기 : %d\n", sizeof(pc));
// }

// 포인터의 초기화
// 절대 포인터에 주소를 직접 대입해서는 안됨! 
// int *ptr
// prt = 0x123456; << xxxxx
// ===================
// int *prt // = 0; or
// prt = NULL; (권장)

/*
* &연산자 -> 주소를 반환
*/
// int main()
// {
//   int a;
//   a = 2;
//   printf("%p\n", &a);
// }

/*
* 포인터의 시작
*/
// int main()
// {
//   int *ptr;
//   int a;

//   ptr = &a;
//   printf("포인터변수 ptr에 들어있는 값 : %p\n", ptr);
//   printf("포인터변수 ptr에 들어있는 값 : %p\n", &ptr);
//   printf("int a 변수의 메모리 주소값 : %p\n ", &a);
// }

/*
*  *연산자 (역참조연산자)
    주소에 대응하는 데이터를 반환
*/

// int main()
// {
//   int *ptr;
//   int a = 2;

//   ptr = &a;

//   printf("a의 값 : %d\n", a);
//   printf("a의 주소값 : %p\n", &a);

//   printf("*ptr의 값 : %d\n", *ptr);
//   printf("*ptr이 가리키는곳 : %p\n", ptr);

// }

// 포인터도 변수다

// int main()
// {
//   int a, b;
//   int *ptr; // 여기에서 int 의미는 포인터가 가르키는 곳의 데이터 타입

//   ptr = &a; // 포인터 ptr변수에 a의 주소값으로 저장
//   *ptr = 2; // 포인터 ptr이 가리키는 곳에 2를 저장(결국 a)
//   ptr = &b; // 포인터 ptr변수에 b의 주소값으로 변경 저장
//   *ptr = 3; // 포인터 ptr이 변경된 곳에 3을 저장(결국 b)

//   printf("a의 값 : %d\n", a);
//   printf("b의 값 : %d\n\n\n", b);
// }

// int main()
// {
//   int a, b;
//   const int *ptr = &a;

//   ptr = &a; // 정상 (포인터가 가리키는 곳을 변경 가능)
//   *ptr = 3; // 오류 (포인터가 가리키는 곳의 값을 변경 불가)
//   ptr = &b; // 정상 (포인터가 가리키는 곳을 변경 가능)
// }

// int main()
// {
//   int a, b;
//   int *const ptr = &a; // const로 한거는 반드시 선언과 동시에 초기화 해야함 

//   ptr = &a; // 정상 (포인터가 가리키는 곳을 변경 불가)
//   *ptr = 3; // 정상 (포인터가 가리키는 곳의 값을 변경 가능)
//   ptr = &b; // 오류 (포인터가 가리키는 곳을 변경 불가)
// }

// 포인터의 덧셈 (주소값이 증가)

// int main()
// {
//   int a;
//   char b;
//   double c;

//   int *pa = &a;
//   char *pb = &b;
//   double *pc = &c;
//   //pa = &a;

//   printf("pa의 값 : %p\n", pa);
//   printf("(pa + 1)의 값 : %p\n", (pa+1));
//   printf("pb의 값 : %p\n", pb);
//   printf("(pb + 1)의 값 : %p\n", (pb+1));
//   printf("pc의 값 : %p\n", pc);
//   printf("(pc + 1)의 값 : %p\n", (pc+1));

  // int a;
  // int *pa = &a;
  // int b;
  // int *pb = &b;
  // int *pc = pa + pb; // 포인터 변수끼리의 덧셈은 불가능 
//}

// 포인터 대입

// int main()
// {
//   int a;
//   int *pa = &a;
//   int *pb;

//   *pa = 3;
//   pb = pa; // 둘다 주소이기 때문에 가능

//   printf("pa가 가리키는 것 : %d\n", *pa);
//   printf("pb가 가리키는 것 : %d\n", *pb);
// }

// 배열과 포인터 관계 

// int main()
// {
//   int arr[10] = {1,2,3,4,5,6,7,8,9,10};

//   for(int i =0;i < 10;i++)
//   {
//     printf("arr[%d]의 주소값 : %p\n", i, &arr[i]);
//   }
// }

// 포인터로써 배열에 접근

// int main()
// {
//   int arr[10] = {1,2,3,4,5,6,7,8,9,10};
//   int *parr;
//   parr = &arr[0];

  // for(int i =0; i < 10;i++)
  // {
  //   printf("arr[%d]의 주소값 : %p\n", i, &arr[i]);
  //   printf("*(parr + %d)의 값 : %p\n", i, (parr + i));

  //   if(&arr[i] == (parr + i)) // 만일 (parr + i)가 성공적으로 arr[i]를 가리킨다면
  //   {
  //     printf("--> 일치\n");
  //   }
  //   else
  //   {
  //     printf("--> 불일치\n");
  //   }
  // }

  //* 연산자로 접근
//   printf("arr[3] = %d \n *(parr + 3) = %d \n", arr[3], *(parr + 3));
// }

// 배열의 이름과포인터와의 관계
// arr[0]과 주소값의 관계

// int main()
// {
//   int arr[3] = {1,2,3};
  // printf("arr의 정체 : %p\n", arr);
  // printf("arr[0]의 주소값 : %p\n", &arr[0]);

  // 배열의 이름 arr과 arr[0]의 주소값이 동일
  // 배열의 이름이 첫번째 원소를 가리키는데 포인터는 아니다.
  // 배열은 배열이고 포인터는 포인터다.

  // int *parr = arr;

  // printf("sizeof(arr) : %d\n", sizeof(arr));
  // printf("sizeof(parr) : %d\n", sizeof(parr));

  // c언어에서 배열의 이름이 sizeof, &(주소값) 연산자 등과 같이 사용할때를 제외하면 
  // 배열의 이름이 암묵적으로 첫번째 원소를 가리키는 포인터 타입으로 변환된다.

//   int *parr;
//   parr = arr; // parr = &arr[0];
//   // arr[i] --> (arr + i) <<< 컴파일러가 이렇게 해석
//   printf("arr[1] : %d\n", arr[1]);
//   printf("parr[1] : %d\n", parr[1]);
// }

// int main()
// {
//   int arr[10] = {100,99,87,67,78,78,56,56,78,90};
//   int *parr = arr; // 포인터변수 선언과 동시에 배열을 가리킴 (0번 인덱스)
//   int sum;

//   while (parr - arr <= 9)
//   {
//     sum += (*parr); // sum = sum + (*parr);
//     parr++;
//     // arr++; // 불가능 ->포인터가 아님, 포인터처럼 행동함 
//   }
//   printf("평균은 ? : %d\n", sum / 10);
// }

// 포인터의 포인터 (이중포인터)

// int main()
// {
//   int a;
//   int *pa;
//   int **ppa;

//   pa = &a;
//   ppa = &pa;

//   a = 3;

//   printf("a의 값 : %d || *pa : %d || **ppa : %d\n", a, *pa, **ppa);
//   printf("a의 주소 : %p || pa가리키는 주소 : %p || *ppa의 저장값 : %p\n", &a, pa, *ppa);
//   printf("pa의 주소 : %p || ppa가리키는 주소 : %p\n", &pa, ppa);
// }

// int main()
// {
//   int arr[2][3];
//   printf("arr[0] : %p\n", arr[0]);
//   printf("&arr[0][0] : %p\n", &arr[0][0]);

//   printf("arr[1] : %p\n", arr[1]);
//   printf("&arr[1][0] : %p\n", &arr[1][0]);
// }


// 구조체 
// 정의 : 서로 다른 데이터형의 변수들을 묶어서 사용 --> 사용자 정의 데이터형을 생성

// struct human // human 이라는 구조체 정의
// {
//   int age; // 나이 --> 멤버변수
//   int height; // 키 --> 멤버변수
//   int weight; // 몸무게 --> 멤버변수
// }; // 마지막에 세미콜론

// int main()
// {
//   struct human info; // struct human 이라는 데이터형, info라는 변수명
  
//   // 변수를 초기화
//   info.age = 99;
//   info.height = 180;
//   info.weight = 100;

//   printf("info의 멤버변수 나이는? : %d\n", info.age);
//   printf("info의 멤버변수 키는? : %d\n", info.height);
//   printf("info의 멤버변수 몸무게는? : %d\n", info.weight);
// }

// #include <string.h> // 표준함수 ->  

// struct contact
// {
//   char name[20];
//   char phone[20];
//   int ringtone;
// };

// int main()
// {
//   struct contact ct = {"김석진", "01012345678", 0};
//   struct contact ct1 = {0}, ct2 = {0};

//   ct.ringtone = 5;
//   strcpy(ct.phone, "01012345678");
//   printf("이 름 : %s\n", ct.name);
//   printf("전화번호 : %s\n", ct.phone);
//   printf("벨소리 : %d\n", ct.ringtone);
// }

/*
* C언어에는 문자열이 없다.
* 문자열 -> "very" (연속된 문자들의 집합)
* 문자 -> 'a' (하나의 문자로 구성)
* 문자열의 표현방법 -> 배열에 저장 (char 배열에 저장)
* --> 배열의 마지막 인덱스에 널문자가 있어야함.
* very\0 -> very 자체는 4문자 이지만 문자열로 저장시 널문자 추가해서 5칸의 크기가 필요함
*/

// typedef unsigned int myunsignedInterger; // 자료형 재 정의

// int main()
// {
//   //unsigned int a; // 아래와 같은것
//   myunsignedInterger a;

//   a = 10;

//   printf(" a : %d\n", a); 
// }

// typedef struct food
// {
//   char name[10];
//   int price;
//   int cookTime;
//   int preperence;
// }FOOD;    // int, double, char

// int main()
// {
//   FOOD good = {"pasta", 30, 50, 100};
//   printf("name : %s\n", good.name);
// }

typedef struct test
{
  int a; // 0x1234(예 : 주소)
  int b; // 0x1238(예 : 주소)
}TEST;

int main()
{
  TEST st = {0}; // st의 첫번째 메모리 주소 (예시 : 0x1234, 0x1238)

  TEST *ptr; // struct test 타입의 구조체르르 가리키는 포인터 변수 (구조체가 아님)

  ptr = &st; // ptr에서 st의 주소 0x1234

  (*ptr).a = 1; // 아래처럼 멤버변수의 값을 제어할려면 (->) 를 사용 
  ptr->b = 2;
}
