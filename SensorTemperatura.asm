
_Resolution:

	MOVLW       PORTE+0
	MOVWF       FARG_Ow_Reset_port+0 
	MOVLW       hi_addr(PORTE+0)
	MOVWF       FARG_Ow_Reset_port+1 
	MOVLW       2
	MOVWF       FARG_Ow_Reset_pin+0 
	CALL        _Ow_Reset+0, 0
	MOVLW       PORTE+0
	MOVWF       FARG_Ow_Write_port+0 
	MOVLW       hi_addr(PORTE+0)
	MOVWF       FARG_Ow_Write_port+1 
	MOVLW       2
	MOVWF       FARG_Ow_Write_pin+0 
	MOVLW       51
	MOVWF       FARG_Ow_Write_data_+0 
	CALL        _Ow_Write+0, 0
	MOVLW       79
	MOVWF       R13, 0
L_Resolution0:
	DECFSZ      R13, 1, 1
	BRA         L_Resolution0
	NOP
	NOP
	MOVLW       PORTE+0
	MOVWF       FARG_Ow_Read_port+0 
	MOVLW       hi_addr(PORTE+0)
	MOVWF       FARG_Ow_Read_port+1 
	MOVLW       2
	MOVWF       FARG_Ow_Read_pin+0 
	CALL        _Ow_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _family_code+0 
	GOTO        L_Resolution1
L_Resolution3:
	MOVLW       12
	MOVWF       _TEMP_RESOLUTION+0 
	GOTO        L_Resolution2
L_Resolution4:
	MOVLW       9
	MOVWF       _TEMP_RESOLUTION+0 
	GOTO        L_Resolution2
L_Resolution5:
	CLRF        _TEMP_RESOLUTION+0 
	GOTO        L_Resolution2
L_Resolution6:
	CLRF        _TEMP_RESOLUTION+0 
	GOTO        L_Resolution2
L_Resolution7:
	CLRF        _TEMP_RESOLUTION+0 
	GOTO        L_Resolution2
L_Resolution1:
	MOVF        _family_code+0, 0 
	XORLW       40
	BTFSC       STATUS+0, 2 
	GOTO        L_Resolution3
	MOVF        _family_code+0, 0 
	XORLW       16
	BTFSC       STATUS+0, 2 
	GOTO        L_Resolution4
	MOVF        _family_code+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_Resolution5
	MOVF        _family_code+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_Resolution6
	GOTO        L_Resolution7
L_Resolution2:
	MOVLW       PORTE+0
	MOVWF       FARG_Ow_Reset_port+0 
	MOVLW       hi_addr(PORTE+0)
	MOVWF       FARG_Ow_Reset_port+1 
	MOVLW       2
	MOVWF       FARG_Ow_Reset_pin+0 
	CALL        _Ow_Reset+0, 0
	MOVLW       PORTE+0
	MOVWF       FARG_Ow_Write_port+0 
	MOVLW       hi_addr(PORTE+0)
	MOVWF       FARG_Ow_Write_port+1 
	MOVLW       2
	MOVWF       FARG_Ow_Write_pin+0 
	MOVLW       51
	MOVWF       FARG_Ow_Write_data_+0 
	CALL        _Ow_Write+0, 0
	MOVLW       79
	MOVWF       R13, 0
L_Resolution8:
	DECFSZ      R13, 1, 1
	BRA         L_Resolution8
	NOP
	NOP
	CLRF        _i+0 
	CLRF        _i+1 
L_Resolution9:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _i+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Resolution46
	MOVF        _i+0, 0 
	SUBLW       7
L__Resolution46:
	BTFSS       STATUS+0, 0 
	GOTO        L_Resolution10
	MOVLW       _sernum+0
	ADDWF       _i+0, 0 
	MOVWF       FLOC__Resolution+0 
	MOVLW       hi_addr(_sernum+0)
	ADDWFC      _i+1, 0 
	MOVWF       FLOC__Resolution+1 
	MOVLW       PORTE+0
	MOVWF       FARG_Ow_Read_port+0 
	MOVLW       hi_addr(PORTE+0)
	MOVWF       FARG_Ow_Read_port+1 
	MOVLW       2
	MOVWF       FARG_Ow_Read_pin+0 
	CALL        _Ow_Read+0, 0
	MOVFF       FLOC__Resolution+0, FSR1
	MOVFF       FLOC__Resolution+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
	GOTO        L_Resolution9
L_Resolution10:
L_end_Resolution:
	RETURN      0
; end of _Resolution

_Read_Temperature:

	MOVLW       PORTE+0
	MOVWF       FARG_Ow_Reset_port+0 
	MOVLW       hi_addr(PORTE+0)
	MOVWF       FARG_Ow_Reset_port+1 
	MOVLW       2
	MOVWF       FARG_Ow_Reset_pin+0 
	CALL        _Ow_Reset+0, 0
	MOVLW       PORTE+0
	MOVWF       FARG_Ow_Write_port+0 
	MOVLW       hi_addr(PORTE+0)
	MOVWF       FARG_Ow_Write_port+1 
	MOVLW       2
	MOVWF       FARG_Ow_Write_pin+0 
	MOVLW       204
	MOVWF       FARG_Ow_Write_data_+0 
	CALL        _Ow_Write+0, 0
	MOVLW       PORTE+0
	MOVWF       FARG_Ow_Write_port+0 
	MOVLW       hi_addr(PORTE+0)
	MOVWF       FARG_Ow_Write_port+1 
	MOVLW       2
	MOVWF       FARG_Ow_Write_pin+0 
	MOVLW       68
	MOVWF       FARG_Ow_Write_data_+0 
	CALL        _Ow_Write+0, 0
	MOVLW       79
	MOVWF       R13, 0
L_Read_Temperature12:
	DECFSZ      R13, 1, 1
	BRA         L_Read_Temperature12
	NOP
	NOP
	MOVLW       PORTE+0
	MOVWF       FARG_Ow_Reset_port+0 
	MOVLW       hi_addr(PORTE+0)
	MOVWF       FARG_Ow_Reset_port+1 
	MOVLW       2
	MOVWF       FARG_Ow_Reset_pin+0 
	CALL        _Ow_Reset+0, 0
	MOVLW       PORTE+0
	MOVWF       FARG_Ow_Write_port+0 
	MOVLW       hi_addr(PORTE+0)
	MOVWF       FARG_Ow_Write_port+1 
	MOVLW       2
	MOVWF       FARG_Ow_Write_pin+0 
	MOVLW       204
	MOVWF       FARG_Ow_Write_data_+0 
	CALL        _Ow_Write+0, 0
	MOVLW       PORTE+0
	MOVWF       FARG_Ow_Write_port+0 
	MOVLW       hi_addr(PORTE+0)
	MOVWF       FARG_Ow_Write_port+1 
	MOVLW       2
	MOVWF       FARG_Ow_Write_pin+0 
	MOVLW       190
	MOVWF       FARG_Ow_Write_data_+0 
	CALL        _Ow_Write+0, 0
	MOVLW       PORTE+0
	MOVWF       FARG_Ow_Read_port+0 
	MOVLW       hi_addr(PORTE+0)
	MOVWF       FARG_Ow_Read_port+1 
	MOVLW       2
	MOVWF       FARG_Ow_Read_pin+0 
	CALL        _Ow_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVLW       0
	MOVWF       _temp+1 
	MOVLW       PORTE+0
	MOVWF       FARG_Ow_Read_port+0 
	MOVLW       hi_addr(PORTE+0)
	MOVWF       FARG_Ow_Read_port+1 
	MOVLW       2
	MOVWF       FARG_Ow_Read_pin+0 
	CALL        _Ow_Read+0, 0
	MOVF        R0, 0 
	MOVWF       R2 
	CLRF        R1 
	MOVF        R1, 0 
	ADDWF       _temp+0, 1 
	MOVF        R2, 0 
	ADDWFC      _temp+1, 1 
L_end_Read_Temperature:
	RETURN      0
; end of _Read_Temperature

_Display_SerialNumber:

	MOVLW       17
	MOVWF       _colona+0 
	MOVLW       0
	MOVWF       _colona+1 
	CLRF        Display_SerialNumber_i_L0+0 
	CLRF        Display_SerialNumber_i_L0+1 
L_Display_SerialNumber13:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       Display_SerialNumber_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Display_SerialNumber49
	MOVF        Display_SerialNumber_i_L0+0, 0 
	SUBLW       7
L__Display_SerialNumber49:
	BTFSS       STATUS+0, 0 
	GOTO        L_Display_SerialNumber14
	MOVLW       2
	SUBWF       _colona+0, 1 
	MOVLW       0
	SUBWFB      _colona+1, 1 
	MOVLW       _sernum+0
	ADDWF       Display_SerialNumber_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_sernum+0)
	ADDWFC      Display_SerialNumber_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ByteToHex_input+0 
	MOVLW       _sernum_hex+0
	MOVWF       FARG_ByteToHex_output+0 
	MOVLW       hi_addr(_sernum_hex+0)
	MOVWF       FARG_ByteToHex_output+1 
	CALL        _ByteToHex+0, 0
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVF        _colona+0, 0 
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _sernum_hex+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_sernum_hex+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	INFSNZ      Display_SerialNumber_i_L0+0, 1 
	INCF        Display_SerialNumber_i_L0+1, 1 
	GOTO        L_Display_SerialNumber13
L_Display_SerialNumber14:
L_end_Display_SerialNumber:
	RETURN      0
; end of _Display_SerialNumber

_Display_Type:

	GOTO        L_Display_Type16
L_Display_Type18:
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_SensorTemperatura+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_SensorTemperatura+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_Display_Type17
L_Display_Type19:
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_SensorTemperatura+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_SensorTemperatura+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_SensorTemperatura+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_SensorTemperatura+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_Display_Type17
L_Display_Type20:
	MOVF        _family_code+0, 0 
	MOVWF       FARG_ByteToHex_input+0 
	MOVLW       _family_code_hex+0
	MOVWF       FARG_ByteToHex_output+0 
	MOVLW       hi_addr(_family_code_hex+0)
	MOVWF       FARG_ByteToHex_output+1 
	CALL        _ByteToHex+0, 0
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _family_code_hex+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_family_code_hex+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_Display_Type17
L_Display_Type16:
	MOVF        _family_code+0, 0 
	XORLW       40
	BTFSC       STATUS+0, 2 
	GOTO        L_Display_Type18
	MOVF        _family_code+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_Display_Type19
	GOTO        L_Display_Type20
L_Display_Type17:
L_end_Display_Type:
	RETURN      0
; end of _Display_Type

_Atingiu_Limite:

	MOVLW       1
	ADDWF       FARG_Atingiu_Limite_text+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Atingiu_Limite_text+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       50
	BTFSS       STATUS+0, 2 
	GOTO        L__Atingiu_Limite44
	MOVLW       2
	ADDWF       FARG_Atingiu_Limite_text+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Atingiu_Limite_text+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       49
	BTFSS       STATUS+0, 2 
	GOTO        L__Atingiu_Limite44
	GOTO        L__Atingiu_Limite43
L__Atingiu_Limite44:
	MOVLW       1
	ADDWF       FARG_Atingiu_Limite_text+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Atingiu_Limite_text+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L__Atingiu_Limite43
	MOVLW       1
	ADDWF       FARG_Atingiu_Limite_text+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Atingiu_Limite_text+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L__Atingiu_Limite43
	GOTO        L_Atingiu_Limite25
L__Atingiu_Limite43:
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_SensorTemperatura+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_SensorTemperatura+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_Atingiu_Limite25:
	MOVLW       1
	ADDWF       FARG_Atingiu_Limite_text+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Atingiu_Limite_text+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       50
	BTFSS       STATUS+0, 2 
	GOTO        L__Atingiu_Limite42
	MOVLW       2
	ADDWF       FARG_Atingiu_Limite_text+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Atingiu_Limite_text+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       57
	BTFSS       STATUS+0, 2 
	GOTO        L__Atingiu_Limite42
	GOTO        L__Atingiu_Limite41
L__Atingiu_Limite42:
	MOVLW       1
	ADDWF       FARG_Atingiu_Limite_text+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Atingiu_Limite_text+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       51
	BTFSC       STATUS+0, 2 
	GOTO        L__Atingiu_Limite41
	GOTO        L_Atingiu_Limite30
L__Atingiu_Limite41:
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_SensorTemperatura+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_SensorTemperatura+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_Atingiu_Limite30:
L_end_Atingiu_Limite:
	RETURN      0
; end of _Atingiu_Limite

_Display_Temperature:

	MOVLW       8
	SUBWF       _TEMP_RESOLUTION+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	MOVWF       Display_Temperature_RES_SHIFT_L0+0 
	MOVF        _temp+0, 0 
	MOVWF       Display_Temperature_temp2write_L0+0 
	MOVF        _temp+1, 0 
	MOVWF       Display_Temperature_temp2write_L0+1 
	BTFSS       _temp+1, 7 
	GOTO        L_Display_Temperature31
	MOVFF       _text+0, FSR1
	MOVFF       _text+1, FSR1H
	MOVLW       45
	MOVWF       POSTINC1+0 
	COMF        Display_Temperature_temp2write_L0+0, 1 
	COMF        Display_Temperature_temp2write_L0+1, 1 
	INFSNZ      Display_Temperature_temp2write_L0+0, 1 
	INCF        Display_Temperature_temp2write_L0+1, 1 
L_Display_Temperature31:
	MOVF        Display_Temperature_RES_SHIFT_L0+0, 0 
	MOVWF       R2 
	MOVF        Display_Temperature_temp2write_L0+0, 0 
	MOVWF       R0 
	MOVF        Display_Temperature_temp2write_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__Display_Temperature53:
	BZ          L__Display_Temperature54
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	ADDLW       255
	GOTO        L__Display_Temperature53
L__Display_Temperature54:
	MOVF        R0, 0 
	MOVWF       Display_Temperature_temp_whole_L0+0 
	MOVLW       100
	MOVWF       R4 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Display_Temperature32
	MOVFF       _text+0, FSR1
	MOVFF       _text+1, FSR1H
	MOVLW       32
	MOVWF       POSTINC1+0 
L_Display_Temperature32:
	MOVLW       1
	ADDWF       _text+0, 0 
	MOVWF       FLOC__Display_Temperature+0 
	MOVLW       0
	ADDWFC      _text+1, 0 
	MOVWF       FLOC__Display_Temperature+1 
	MOVLW       10
	MOVWF       R4 
	MOVF        Display_Temperature_temp_whole_L0+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__Display_Temperature+0, FSR1
	MOVFF       FLOC__Display_Temperature+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       2
	ADDWF       _text+0, 0 
	MOVWF       FLOC__Display_Temperature+0 
	MOVLW       0
	ADDWFC      _text+1, 0 
	MOVWF       FLOC__Display_Temperature+1 
	MOVLW       10
	MOVWF       R4 
	MOVF        Display_Temperature_temp_whole_L0+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__Display_Temperature+0, FSR1
	MOVFF       FLOC__Display_Temperature+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       3
	ADDWF       _text+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      _text+1, 0 
	MOVWF       FSR1H 
	MOVLW       46
	MOVWF       POSTINC1+0 
	MOVF        Display_Temperature_RES_SHIFT_L0+0, 0 
	SUBLW       4
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        Display_Temperature_temp2write_L0+0, 0 
	MOVWF       R0 
	MOVF        Display_Temperature_temp2write_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__Display_Temperature55:
	BZ          L__Display_Temperature56
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__Display_Temperature55
L__Display_Temperature56:
	MOVLW       15
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
	MOVLW       113
	MOVWF       R4 
	MOVLW       2
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       4
	ADDWF       _text+0, 0 
	MOVWF       FLOC__Display_Temperature+0 
	MOVLW       0
	ADDWFC      _text+1, 0 
	MOVWF       FLOC__Display_Temperature+1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__Display_Temperature+0, FSR1
	MOVFF       FLOC__Display_Temperature+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        _text+0, 0 
	MOVWF       FARG_Atingiu_Limite_text+0 
	MOVF        _text+1, 0 
	MOVWF       FARG_Atingiu_Limite_text+1 
	CALL        _Atingiu_Limite+0, 0
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _text+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _text+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	MOVLW       39
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
L_end_Display_Temperature:
	RETURN      0
; end of _Display_Temperature

_main:

	MOVLW       7
	IORWF       CMCON+0, 1 
	MOVLW       13
	MOVWF       ADCON1+0 
	CLRF        PORTA+0 
	CLRF        TRISD+0 
	MOVLW       3
	MOVWF       TRISA+0 
	BSF         TRISE+0, 2 
	CALL        _Lcd_Init+0, 0
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
L_main33:
	CALL        _Resolution+0, 0
	CALL        _Display_Type+0, 0
	GOTO        L_main36
L_main38:
	CALL        _Read_Temperature+0, 0
	CALL        _Display_Temperature+0, 0
	GOTO        L_main37
L_main39:
	GOTO        L_main37
L_main36:
	MOVF        _family_code+0, 0 
	XORLW       40
	BTFSC       STATUS+0, 2 
	GOTO        L_main38
	GOTO        L_main39
L_main37:
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main40:
	DECFSZ      R13, 1, 1
	BRA         L_main40
	DECFSZ      R12, 1, 1
	BRA         L_main40
	DECFSZ      R11, 1, 1
	BRA         L_main40
	NOP
	GOTO        L_main33
L_end_main:
	GOTO        $+0
; end of _main
