#include <stdio.h>

// LCD
sbit LCD_RS at LATB4_bit;
sbit LCD_EN at LATB5_bit;
sbit LCD_D4 at LATB0_bit;
sbit LCD_D5 at LATB1_bit;
sbit LCD_D6 at LATB2_bit;
sbit LCD_D7 at LATB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;


// Setar TEMP_RESOLUTION para a resolução correspondente do sensor
// Ex: 18B20: 12, 18S20: 9
const unsigned short TEMP_RES_B = 12;
const unsigned short TEMP_RES_S = 9;
unsigned short TEMP_RESOLUTION;
unsigned temp;



// family_code: código correspondente ao sensor
// Ex: 0x28: DS18B20 (sensor usado)
// 0x10: DS18S20
// 0xFF: NoID
char family_code;
char family_code_hex[2];

char *text = "00.00";
char Tmax, *Tmin = "23";
char sernum[8];
char sernum_hex[2];
int i;
int colona;


void Resolution()
{
      Ow_Reset(&PORTE, 2);
      Ow_Write(&PORTE, 2, 0x33);
      Delay_us(120);

      family_code = Ow_Read(&PORTE, 2);
      
      switch( family_code )
      {
       case 0x28:
       TEMP_RESOLUTION = TEMP_RES_B;
       break;
       
       case 0x10:
       TEMP_RESOLUTION = TEMP_RES_S;
       break;
       
       case 0x01:
       TEMP_RESOLUTION = 0;
       break;
       
       case 0xFF:
       TEMP_RESOLUTION = 0;
       break;
       
       default:
       TEMP_RESOLUTION = 0;
       break;
      }
      

     Ow_Reset(&PORTE, 2);
     Ow_Write(&PORTE, 2, 0x33);
     Delay_us(120);

  for(i = 0; i <= 7; i++)
  {
   sernum[i] = Ow_Read(&PORTE, 2);
  }
}

void Read_Temperature()
{
 // Faz a leitura da temperatura
    Ow_Reset(&PORTE, 2);
    Ow_Write(&PORTE, 2, 0xCC);
    Ow_Write(&PORTE, 2, 0x44);
    Delay_us(120);

    Ow_Reset(&PORTE, 2);
    Ow_Write(&PORTE, 2, 0xCC);
    Ow_Write(&PORTE, 2, 0xBE);

    temp =  Ow_Read(&PORTE, 2);
    temp = (Ow_Read(&PORTE, 2) << 8) + temp;
}

void Display_SerialNumber()
{
 int i;
 colona = 17;

       for(i = 0; i <= 7; i++)
          {
            colona = colona - 2;
            ByteToHex(sernum[i], sernum_hex);
            Lcd_Out(1, colona, sernum_hex);
          }
}

void Display_Type()
{
      switch( family_code )
      {
       case 0x28:
       Lcd_Out(1, 1, "Temp:");
       break;

       case 0xFF:
       Lcd_Out(1, 1, "Error 404:");
       Lcd_Out(2, 1, "Sensor not found");
       break;

       default:
       ByteToHex(family_code, family_code_hex);
       Lcd_Out(1, 1, family_code_hex );
       break;
      }
}

//Verifica se as temperaturas limites (abaixo de 21°C ou acima de 29°C) não foram atingidas
void Atingiu_Limite(char *text, char *min)
{
     if(text[1] == min[0] && text[2] == min[1])
     {
       Lcd_Out(2,1, "Min. Atingido");

     }
     /*if(text[1] == max[0] && text[2] == max[1])
     {
      Lcd_Out(2,1, "Max. Atingido");

     } */
     if(text[1] == '2' && text[2] == '9' || text[1] == '3')
     {
      Lcd_Out(2,1, "Max. Atingido");

     }
}

void Limite_Padrao(char *text)
{
     if(text[1] == '2' && text[2] == '1' || text[1] == '1')
     {
       Lcd_Out(2,1, "Min. Atingido");

     }
     if(text[1] == '2' && text[2] == '9' || text[1] == '3')
     {
      Lcd_Out(2,1, "Max. Atingido");

     }
}

void Display_Temperature()
{
     unsigned short RES_SHIFT = TEMP_RESOLUTION - 8;
     char temp_whole;
     unsigned int temp2write;
     unsigned int temp_fraction;
     
     temp2write = temp;
     // Checa se a temperatura é negativa
     if (temp2write & 0x8000) 
        {
        text[0] = '-';
        temp2write = ~temp2write + 1;
        }

     //Extrai a temperatura
     temp_whole = temp2write >> RES_SHIFT ;

     //Converte a temperatura para char
     if (temp_whole/100)
        text[0] = ' ';

     text[1] = (temp_whole/10)%10 + 48;
     text[2] =  temp_whole%10     + 48;
     text[3] = '.';

     temp_fraction  = temp2write << (4-RES_SHIFT);
     temp_fraction &= 0x000F;
     temp_fraction *= 625;


     text[4] =  temp_fraction/1000    + 48;

     //Verifica se os limites de temperatura não foram atingidos
     Atingiu_Limite(text, Tmin);
     //Mostra a temperatura no LCD
     Lcd_Out(1, 7, text);
     
     Lcd_Chr_CP('\'');                             // 176 ASCII para o símbolo de °
     Lcd_Chr_CP('C');
}

char uart_rd[10];


char TempMax()
{
      char MaxT;
      UART1_Write_Text("Temperatura Maxima: <Enter para enviar>\n");
      if (UART1_Data_Ready() == 1) {
        UART1_Read_Text(MaxT, "\r", 10);
        UART1_Write_Text(MaxT);
      }
      return MaxT;
}

char TempMin()
{
      char MinT;
      UART1_Write_Text("Temperatura Minima: <Enter para enviar>\n");
      if (UART1_Data_Ready() == 1) {
        UART1_Read_Text(MinT, "\r", 10);
        UART1_Write_Text(MinT);
      }
      return MinT;
}


void main()
{
 CMCON |=7;
 ADCON1 = 0x0D;
 
 PORTA = 0 ;
 TRISD = 0x00;
 TRISA = 0x03;
 TRISE.B2 = 1;

 Lcd_Init();                                    //Inicia o LCD
 UART1_Init(9600);
 delay_ms(100);
 Lcd_Cmd(_LCD_CLEAR);                           //Limpa o LCD
 Lcd_Cmd(_LCD_CURSOR_OFF);                      //Desativa o cursor
 //Tmax = TempMax();
 Tmin = TempMin();

  do
  {
    Resolution();
    Display_Type();


    switch( family_code )
    {
       case 0x28: // DS18B20
            Read_Temperature();
            Display_Temperature();
            break;

       default:
               break;
    }

    Delay_ms(100);
  } while (1);
}