#line 1 "C:/Users/bianc/Documents/PIC/SensorTemperatura/SensorTemperatura.c"

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




const unsigned short TEMP_RES_B = 12;
const unsigned short TEMP_RES_S = 9;
unsigned short TEMP_RESOLUTION;
unsigned temp;







char family_code;
char family_code_hex[2];

char *text = "00.00";

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

 Ow_Reset(&PORTE, 2);
 Ow_Write(&PORTE, 2, 0xCC);
 Ow_Write(&PORTE, 2, 0x44);
 Delay_us(120);

 Ow_Reset(&PORTE, 2);
 Ow_Write(&PORTE, 2, 0xCC);
 Ow_Write(&PORTE, 2, 0xBE);

 temp = Ow_Read(&PORTE, 2);
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


void Atingiu_Limite(char *text)
{
 if(text[1] == '2' && text[2] == '1' || text[1] == '1' || text[1] == '0')
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

 if (temp2write & 0x8000)
 {
 text[0] = '-';
 temp2write = ~temp2write + 1;
 }


 temp_whole = temp2write >> RES_SHIFT ;


 if (temp_whole/100)
 text[0] = ' ';

 text[1] = (temp_whole/10)%10 + 48;
 text[2] = temp_whole%10 + 48;
 text[3] = '.';

 temp_fraction = temp2write << (4-RES_SHIFT);
 temp_fraction &= 0x000F;
 temp_fraction *= 625;


 text[4] = temp_fraction/1000 + 48;


 Atingiu_Limite(text);

 Lcd_Out(1, 7, text);

 Lcd_Chr_CP('\'');
 Lcd_Chr_CP('C');
}

char uart_rd[10];

void LeTerminal()
{
 char output[100];
 if(UART1_Data_Ready())
 {
 uart1_read_text(uart_rd, "\r", 16);

 UART1_Write(uart_rd);
 }
}

void main()
{
 CMCON |=7;
 ADCON1 = 0x0D;

 PORTA = 0 ;
 TRISD = 0x00;
 TRISA = 0x03;
 TRISE.B2 = 1;

 Lcd_Init();
 UART1_Init(9600);
 delay_ms(100);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);


 do
 {
 Resolution();
 Display_Type();
 LeTerminal();

 switch( family_code )
 {
 case 0x28:
 Read_Temperature();
 Display_Temperature();
 break;

 default:
 break;
 }

 Delay_ms(100);
 } while (1);
}
