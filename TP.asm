global main
extern puts
extern gets
extern printf
extern sscanf
extern strlen

section .data
    ; Uso General
    msj_separador db "_________________________________________________________________________________",0
    msj_ingreso db "Por favor, elija una de las opciones (1 o 2):",0
    nueva_linea db "",13,0
    linea_salida db "Una vez dentro, puede detener la ejecucion ingresando 'X'",0

    ; Exclusivo Menu Principal
    msj_explicacion_menu1 db "La primera opcion le permitira introducir un numero en formato IEEE754 de",0
    msj_explicacion_menu2 db "precision simple ya sea en su configuracion binaria o hexadecimal y",0
    msj_explicacion_menu3 db "obtener a cambio su forma en notacion cientifica normalizada en base 2.",0
    msj_explicacion_menu4 db "Por otro lado la segunda opcion le permitira introducir un numero en la forma",0
    msj_explicacion_menu5 db "de notacion cientifica normalizada en base 2 y obtener a cambio la configuracion",0
    msj_explicacion_menu6 db "binaria o hexadecimal de la misma en el formato IEEE754.",0
    msj_menu1 db "[1] Opcion 1",0
    msj_menu2 db "[2] Opcion 2",0

    ; Exclusivo Item 1
    msj_explicacion_submenu11 db "Si selecciona 1, debera ingresar un numero en formato IEEE754 en configuracion",0
    msj_explicacion_submenu12 db "binaria, (Se requieren 32 caracteres).",0
    msj_explicacion_submenu13 db "Por otro lado, si selecciona 2, debera ingresar un numero en formato IEEE754 en",0
    msj_explicacion_submenu14 db "configuracion hexadecimal, (Se requieren 8 caracteres).",0
    msj_submenu1_1 db "[1] Entrada en configuracion binaria.",0
    msj_submenu1_2 db "[2] Entrada en configuracion hexadecimal.",0
    msj_ingreso_bin db "Por favor, Ingrese la configuracion binaria correctamente:",0
    msj_ingreso_hex db "Por favor, Ingrese la configuracion hexadecimal correctamente:",0
    formato_bin_out db "Resultado: %s1,%sx10^%s%s",10,0

    ; Exclusivo Item 2
    msj_explicacion_submenu21 db "Si selecciona 1, se le devolvera un numero en formato IEEE754 en su configuracion",0
    msj_explicacion_submenu22 db "binaria.",0
    msj_explicacion_submenu23 db "Por otro lado, si selecciona 2 se le devolvera un numero en formato IEEE754 en.",0
    msj_explicacion_submenu24 db "configuracion hexadecimal.",0
    msj_explicacion_submenu25 db "(Atencion, se obvian los 0's al frente del IEEE754 debido a su pasaje a Hexa.)",0
    msj_submenu2_1 db "[1] Salida en configuracion binaria.",0
    msj_submenu2_2 db "[2] Salida en configuracion hexadecimal.",0
    formato_not db "%[^\1]1,%[^\x]x10^%s",0
    signo_menos db "-",0
    msj_ingreso_notacion db "Por favor, Ingrese la notacion cientifica normalizada en base 2 correctamente:",0
    formato_not_out db "Resultado: %s",0

    ; Exclusivo Binario a Decimal
    indice_bd dd 0
    format_input_bd db "%lli",0
    output_bd dq 0

    ; Exclusivo Decimal a Binario
    divisor_db dq 2
    indice_db dd 0
    resultado_tmp_db db "00000000",0
    string_cero_inicializado db "00000000",0
    caso_borde_exponente_cero db "N",0
    char_cero db "0",0

    ; Exclusivo Hexadecimal a Binario
    indice_hd dd 0
    format_input_hd db "%lli",0
    output_hd dq 0
    divisor_db_mod dq 2
    indice_db_mod dd 0
    resultado_tmp_db_mod db "00000000000000000000000000000000",0
    string_cero_inicializado_mod db "00000000000000000000000000000000",0

    ; Exclusivo Decimal a Hexadecimal
    divisor_dh dq 16
    indice_dh dd 0
    resultado_tmp_dh db "00000000",0
    string_cero_inicializado_dh db "00000000",0

    ; Miscelaneo
    format_input db	"%hi",0

section .bss
    input_usuario resb 2
    input_valido resb 1
    input_num resw 1

    ; Uso General
    tipo_de_entrada_retorno resb 1
    signo resb 2
    exponente resb 10
    mantisa resb 24

    ; Exclusivo Item 1
    input_ieee_bin resb 33
    input_ieee_hex resb 9
    longitud_bin_hex resd 1
    signo_simbolo resb 2
    signo_exponente resb 2

    ; Exclusivo Item 2
    nuevo_exponente resb 9
    longitud_notacion resd 1
    input_notacion resb 40
    longitud_exp_not resq 1
    signo_numero resb 2
    exp_negativo_check resb 1
    longitud_mantisa resq 1
    output_ieee_bin resb 33
    longitud_signo resq 1
    longitud_exponente resq 1
    longitud_mantisa1 resq 1
    long_temp resq 1

    ; Exclusivo Binario a Decimal
    longitud_bd resq 1
    contador_bd resq 1
    tmp_bd resb 2
    input_num_bd resq 1
    potencia_bd resq 1

    ; Exclusivo Decimal a Binario
    resto_db resq 1
    caracter_db resb 1
    resultado_db resb 9
    longitud_db resq 1

    ; Exclusivo Hexadecimal a Binario
    longitud_hd resq 1
    contador_hd resq 1
    tmp_hd resb 2
    input_num_hd resq 1
    potencia_hd resq 1
    resto_db_mod resq 1
    caracter_db_mod resb 1
    resultado_db_mod resb 33
    longitud_db_mod resq 1

    ; Exclusivo Decimal a Hexadecimal
    resto_dh resq 1
    caracter_dh resb 1
    resultado_dh resb 33
    longitud_dh resq 1

section .text

main:
    call interfaz_menu
    call evaluar_input_menu
ret

interfaz_menu:
    mov rcx, msj_separador
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_explicacion_menu1
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_explicacion_menu2
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_explicacion_menu3
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, nueva_linea
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_explicacion_menu4
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_explicacion_menu5
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_explicacion_menu6
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, nueva_linea
    sub rsp, 32
    call puts
    add rsp, 32

interfaz_menu_:
    mov rcx, msj_menu1
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_menu2
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_ingreso
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, input_usuario
    sub rsp, 32
    call gets
    add rsp, 32

    mov rcx, msj_separador
    sub rsp, 32
    call puts
    add rsp, 32

    call val_input
    cmp byte[input_valido], 'N'
    je interfaz_menu_

ret

val_input:
	mov	rcx, input_usuario
	mov	rdx, format_input
	mov	r8, input_num
	sub	rsp, 32
	call sscanf
	add	rsp, 32

	cmp rax, 1
	jl input_invalido

    cmp	word[input_num], 1
	jl input_invalido
	cmp word[input_num], 2
	jg input_invalido

    mov	byte[input_valido], 'S'

ret

input_invalido:
	mov	byte[input_valido], 'N'

fin_validar:
ret

evaluar_input_menu:
    cmp	word[input_num], 1
	je interfaz_submenu_1
    cmp	word[input_num], 2
	je interfaz_submenu_2

interfaz_submenu_1:
    mov rcx, msj_explicacion_submenu11
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_explicacion_submenu12
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, nueva_linea
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_explicacion_submenu13
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_explicacion_submenu14
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, nueva_linea
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, linea_salida
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, nueva_linea
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_submenu1_1
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_submenu1_2
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_ingreso
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, input_usuario
    sub rsp, 32
    call gets
    add rsp, 32

    mov rcx, msj_separador
    sub rsp, 32
    call puts
    add rsp, 32

    call val_input
    cmp byte[input_valido], 'N'
    je interfaz_submenu_1

    call evaluar_input_submenu

interfaz_submenu_1_:
    call evaluar_input_item1

    cmp byte[tipo_de_entrada_retorno], 'B'
    je retorno_bin
    cmp byte[tipo_de_entrada_retorno], 'H'
    je retorno_hex
retorno_bin:
    cmp	byte[input_ieee_bin], 'X'
    je fin_interfaz_submenu_1_
    jmp sigo
retorno_hex:
    cmp	byte[input_ieee_hex], 'X'
    je fin_interfaz_submenu_1_
sigo:
    call input_hexa_a_bin

    call formatear_iee754str
    call evaluar_signo_ieee

    mov dword[indice_bd], 0
    mov qword[output_bd], 0
    call binario_a_decimal

    sub qword[output_bd], 127
    call comprobar_signo_exponente

    call limpiar_resultado_tmp
    mov dword[indice_db], 0
    call decimal_a_binario
    call evaluar_caso_borde_exponente_cero

    call imprimir_resultado_item1

    jmp interfaz_submenu_1_
fin_interfaz_submenu_1_:
ret

interfaz_submenu_2:
    mov rcx, msj_explicacion_submenu21
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_explicacion_submenu22
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, nueva_linea
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_explicacion_submenu23
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_explicacion_submenu24
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_explicacion_submenu25
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, nueva_linea
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, linea_salida
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, nueva_linea
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_submenu2_1
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_submenu2_2
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_ingreso
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, input_usuario
    sub rsp, 32
    call gets
    add rsp, 32

    mov rcx, msj_separador
    sub rsp, 32
    call puts
    add rsp, 32

    call val_input
    cmp byte[input_valido], 'N'
    je interfaz_submenu_2

    call evaluar_input_submenu

interfaz_submenu_2_:
    call input_notacion_cientifica
    cmp	byte[input_notacion], 'X'
    je fin_interfaz_submenu_2_

    call formatear_input_notacion
    call evaluar_exponente_negativo
    call evaluar_signo_notacion

    mov dword[indice_bd], 0
    mov qword[output_bd], 0
    call binario_a_decimal

    call exponente_negativo_aplicar
    add qword[output_bd], 127
    call es_exponente_cero

    call limpiar_resultado_tmp
    mov dword[indice_db], 0
    call decimal_a_binario
    call evaluar_caso_borde_exponente_cero

    call imprimir_resultado_item2

    jmp interfaz_submenu_2_
fin_interfaz_submenu_2_:
ret

evaluar_input_submenu:
    cmp	word[input_num], 1
	je es_binario
    cmp	word[input_num], 2
	je es_hexa

es_binario:
    mov	byte[tipo_de_entrada_retorno], 'B'
ret

es_hexa:
    mov	byte[tipo_de_entrada_retorno], 'H'
ret

evaluar_input_item1:
    cmp byte[tipo_de_entrada_retorno], 'B'
    je input_binario
    cmp byte[tipo_de_entrada_retorno], 'H'
    je input_hexa

input_binario:
    mov rcx, msj_ingreso_bin
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, input_ieee_bin
    sub rsp, 32
    call gets
    add rsp, 32

    cmp	byte[input_ieee_bin], 'X'
    je cancelar_loop

    call val_input_bin
    cmp byte[input_valido], 'N'
    je input_binario

    ;aca deberia añadir la validacion de los caracteres individuales
cancelar_loop:
ret

input_hexa:
    mov rcx, msj_ingreso_hex
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, input_ieee_hex
    sub rsp, 32
    call gets
    add rsp, 32

    cmp	byte[input_ieee_hex], 'X'
    je cancelar_loop

    call val_input_hexa
    cmp byte[input_valido], 'N'
    je input_hexa

    ;aca deberia añadir la validacion de los caracteres individuales
ret

val_input_bin:
    mov rcx, input_ieee_bin
    sub rsp, 32
    call strlen
    add rsp, 32
    mov [longitud_bin_hex], eax

    cmp dword[longitud_bin_hex], 32
	jl input_invalido
	cmp dword[longitud_bin_hex], 32
	jg input_invalido

    mov	byte[input_valido], 'S'

ret

val_input_hexa:
    mov rcx, input_ieee_hex
    sub rsp, 32
    call strlen
    add rsp, 32
    mov [longitud_bin_hex], eax

    cmp dword[longitud_bin_hex], 8
	jl input_invalido
	cmp dword[longitud_bin_hex], 8
	jg input_invalido

    mov	byte[input_valido], 'S'

ret

formatear_iee754str:
    mov rcx, 1
    lea rsi, [input_ieee_bin]
    lea rdi, [signo]
    rep movsb

    mov rcx, 8
    lea rsi, [input_ieee_bin + 1]
    lea rdi, [exponente]
    rep movsb

    mov rcx, 23
    lea rsi, [input_ieee_bin + 9]
    lea rdi, [mantisa]
    rep movsb

ret

evaluar_signo_ieee:
    cmp byte[signo], '0'
    je signo_positivo_ieee
    cmp byte[signo], '1'
    je signo_negativo_ieee

signo_positivo_ieee:
    mov	byte[signo_simbolo], '+'
ret

signo_negativo_ieee:
    mov	byte[signo_simbolo], '-'
ret

binario_a_decimal:
    mov rcx, exponente
    sub rsp, 32
    call strlen
    add rsp, 32
    mov [longitud_bd], rax
    mov rcx, [longitud_bd]
    sub rax, 1
    mov [potencia_bd], rax
binario_a_decimal_:
    mov	qword[contador_bd], rcx

    mov edx, [indice_bd]
    mov rcx, 1
    lea rsi, [exponente + edx]
    lea rdi, [tmp_bd]
    rep movsb

	mov	rcx, tmp_bd
	mov	rdx, format_input_bd
	mov	r8, input_num_bd
	sub	rsp, 32
	call sscanf
	add	rsp, 32

    call realizar_sumatoria

    mov	rcx, qword[contador_bd]
    add dword[indice_bd], 1
    loop binario_a_decimal_

ret

realizar_sumatoria:
    mov rcx, [potencia_bd]
    cmp rcx, 0
    je potencia_cero
    mov rax, 1
f_loop:
    imul rax, 2
    dec rcx
    cmp rcx, 0
    jg f_loop

    imul rax, qword[input_num_bd]
    add qword[output_bd], rax
    sub qword[potencia_bd], 1
ret
potencia_cero:
    mov rax, 1
    imul rax, qword[input_num_bd]
    add qword[output_bd], rax
ret

comprobar_signo_exponente:
    cmp qword[output_bd], 0
    je exponente_cero
    cmp qword[output_bd], 0
    jl exponente_negativo
    cmp qword[output_bd], 0
    jg exponente_positivo
exponente_negativo:
    mov	byte[signo_exponente], '-'
    neg qword[output_bd]
    mov	byte[caso_borde_exponente_cero], 'N'
ret
exponente_cero:
    mov	byte[signo_exponente], ''
    mov	byte[caso_borde_exponente_cero], 'S'
ret
exponente_positivo:
    mov	byte[signo_exponente], ''
    mov	byte[caso_borde_exponente_cero], 'N'
ret

decimal_a_binario:
    mov rax, [output_bd]
    cmp rax, [divisor_db]
    jl decimal_a_binario_
    xor rdx, rdx
    mov rbx, [divisor_db]
    idiv rbx
    mov qword[resto_db], rdx

    mov [output_bd], rax

    add qword[resto_db], 48
    mov al, [resto_db]
    mov [caracter_db], al

    mov edx, [indice_db]
    mov rcx, 1
    lea rsi, [caracter_db]
    lea rdi, [resultado_tmp_db + edx]
    rep movsb
    add dword[indice_db], 1

    mov rax, [output_bd]
    cmp rax, [divisor_db]
    jge decimal_a_binario
decimal_a_binario_:
    call agregar_uno_final
    call invertir_resultado

ret

agregar_uno_final:
    mov al, 49
    mov [caracter_db], al

    mov edx, [indice_db]
    mov rcx, 1
    lea rsi, [caracter_db]
    lea rdi, [resultado_tmp_db + edx]
    rep movsb

ret

invertir_resultado:
    mov rcx, resultado_tmp_db
    sub rsp, 32
    call strlen
    add rsp, 32
    mov [longitud_db], rax

    mov	rdi, 0
	mov	rsi, [longitud_db]
    ver_fin_copia:	
        cmp	rsi, 0
        je	fin_copia
        mov	al, [resultado_tmp_db + rsi - 1]
        mov	[resultado_db+rdi], al
        dec	rsi
        inc	rdi
        jmp	ver_fin_copia	
    fin_copia:
        mov	byte[resultado_db + rdi + 1], 0

ret

limpiar_resultado_tmp:
    mov rcx, 8
    lea rsi, [string_cero_inicializado]
    lea rdi, [resultado_tmp_db]
    rep movsb
ret

evaluar_caso_borde_exponente_cero:
    cmp	byte[caso_borde_exponente_cero], 'S'
    je evaluar_caso_borde_exponente_cero_
ret
evaluar_caso_borde_exponente_cero_:
    mov rcx, 1
    lea rsi, [char_cero]
    lea rdi, [resultado_db + 7]
    rep movsb
ret

imprimir_resultado_item1:
    mov rcx, nueva_linea
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, formato_bin_out
    mov rdx, signo_simbolo
    mov r8, mantisa
    mov r9, signo_exponente
    push resultado_db
    sub rsp, 32
    call printf
    add rsp, 32
    pop rcx
    xor rcx, rcx

    mov rcx, msj_separador
    sub rsp, 32
    call puts
    add rsp, 32

ret

input_notacion_cientifica:
    mov rcx, msj_ingreso_notacion
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, input_notacion
    sub rsp, 32
    call gets
    add rsp, 32

    cmp	byte[input_notacion], 'X'
    je cancelar_loop

    call val_input_notacion_cientifica
    cmp byte[input_valido], 'N'
    je input_notacion_cientifica

ret

val_input_notacion_cientifica:
    mov rcx, input_notacion
    sub rsp, 32
    call strlen
    add rsp, 32
    mov [longitud_notacion], eax

    cmp dword[longitud_notacion], 9
	jl input_invalido
	cmp dword[longitud_notacion], 39
	jg input_invalido

    mov	byte[input_valido], 'S'

ret

formatear_input_notacion:
    mov rcx, input_notacion
    mov rdx, formato_not
    mov r8, signo
    mov r9, mantisa
    push exponente
    sub rsp, 32
    call sscanf
    add rsp, 32
    pop rcx
    xor rcx, rcx

ret

evaluar_exponente_negativo:
    mov rcx, 1
    mov rsi, exponente
    mov rdi, signo_menos
    repe cmpsb
    je hay_exponente_negativo
    mov	byte[exp_negativo_check], 'N'
ret
hay_exponente_negativo:
    mov rcx, exponente
    sub rsp, 32
    call strlen
    add rsp, 32
    mov [longitud_exp_not], rax

    sub qword[longitud_exp_not], 1

    mov rcx, [longitud_exp_not]
    lea rsi, [exponente + 1]
    lea rdi, [nuevo_exponente]
    rep movsb

    mov rcx, [longitud_exp_not]
    lea rsi, [nuevo_exponente]
    lea rdi, [exponente]
    rep movsb
    mov rax, [longitud_exp_not]
    mov	byte[exponente + rax], 0

    mov	byte[exp_negativo_check], 'S'

ret

evaluar_signo_notacion:
    cmp byte[signo], '+'
    je signo_positivo_notacion
    cmp byte[signo], '-'
    je signo_negativo_notacion

signo_positivo_notacion:
    mov	byte[signo_numero], '0'
ret

signo_negativo_notacion:
    mov	byte[signo_numero], '1'
ret

exponente_negativo_aplicar:
    cmp byte[exp_negativo_check], 'S'
    je exp_es_negativo
ret
exp_es_negativo:
    neg qword[output_bd]
ret

es_exponente_cero:
    cmp qword[output_bd], 0
    je exponente_es_cero
    mov	byte[caso_borde_exponente_cero], 'N'
ret
exponente_es_cero:
    mov	byte[caso_borde_exponente_cero], 'S'
ret

imprimir_resultado_item2:
    mov rcx, nueva_linea
    sub rsp, 32
    call puts
    add rsp, 32

    call imprimir_conf_bin_hex

    mov rcx, nueva_linea
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, msj_separador
    sub rsp, 32
    call puts
    add rsp, 32
ret

hexa_a_decimal:
    mov rcx, input_ieee_hex
    sub rsp, 32
    call strlen
    add rsp, 32
    mov [longitud_hd], rax
    mov rcx, [longitud_hd]
    sub rax, 1
    mov [potencia_hd], rax
hexa_a_decimal_:
    mov	qword[contador_hd], rcx

    mov	qword[tmp_hd], 0

    mov edx, [indice_hd]
    mov rcx, 1
    lea rsi, [input_ieee_hex + edx]
    lea rdi, [tmp_hd]
    rep movsb

    call capturar_caracter_hexa

	mov	rcx, tmp_hd
	mov	rdx, format_input_hd
	mov	r8, input_num_hd
	sub	rsp, 32
	call sscanf
	add	rsp, 32

    call realizar_sumatoria_hd

    mov	rcx, qword[contador_hd]
    add dword[indice_hd], 1
    loop hexa_a_decimal_

ret

realizar_sumatoria_hd:
    mov rcx, [potencia_hd]
    cmp rcx, 0
    je potencia_cero_hd
    mov rax, 1
f_loop_hd:
    imul rax, 16
    dec rcx
    cmp rcx, 0
    jg f_loop_hd

    imul rax, qword[input_num_hd]
    add qword[output_hd], rax
    sub qword[potencia_hd], 1
ret
potencia_cero_hd:
    mov rax, 1
    imul rax, qword[input_num_hd]
    add qword[output_hd], rax
ret

capturar_caracter_hexa:
    cmp qword[tmp_hd], 'A'
    je caso_a
    cmp qword[tmp_hd], 'a'
    je caso_a
    cmp qword[tmp_hd], 'B'
    je caso_b
    cmp qword[tmp_hd], 'b'
    je caso_b
    cmp qword[tmp_hd], 'C'
    je caso_c
    cmp qword[tmp_hd], 'c'
    je caso_c
    cmp qword[tmp_hd], 'D'
    je caso_d
    cmp qword[tmp_hd], 'd'
    je caso_d
    cmp qword[tmp_hd], 'E'
    je caso_e
    cmp qword[tmp_hd], 'e'
    je caso_e
    cmp qword[tmp_hd], 'F'
    je caso_f
    cmp qword[tmp_hd], 'f'
    je caso_f
ret
caso_a:
    mov qword[tmp_hd], '10'
ret
caso_b:
    mov qword[tmp_hd], '11'
ret
caso_c:
    mov qword[tmp_hd], '12'
ret
caso_d:
    mov qword[tmp_hd], '13'
ret
caso_e:
    mov qword[tmp_hd], '14'
ret
caso_f:
    mov qword[tmp_hd], '15'
ret

input_hexa_a_bin:
    cmp byte[tipo_de_entrada_retorno], 'H'
    je input_hexa_a_bin_
ret
input_hexa_a_bin_:
    mov dword[indice_hd], 0
    mov qword[output_hd], 0
    call hexa_a_decimal

    call limpiar_resultado_tmp_mod
    mov dword[indice_db_mod], 0
    call decimal_a_binario_mod

    mov rcx, 32
    lea rsi, [resultado_db_mod]
    lea rdi, [input_ieee_bin]
    rep movsb

ret

decimal_a_binario_mod:
    ; Tuve que modificar el codigo existente ya que el anterior estaba diseñado
    ; para el exponente el cual es de 8 digitos de largo, y al utilizarlo para
    ; el hexa a decimal a binario se introducian resudios en los resultados.
    mov rax, [output_hd] 
    cmp rax, [divisor_db_mod]
    jl decimal_a_binario_mod_
    xor rdx, rdx 
    mov rbx, [divisor_db_mod]
    idiv rbx
    mov qword[resto_db_mod], rdx 

    mov [output_hd], rax

    add qword[resto_db_mod], 48
    mov al, [resto_db_mod]
    mov [caracter_db_mod], al

    mov edx, [indice_db_mod]
    mov rcx, 1
    lea rsi, [caracter_db_mod]
    lea rdi, [resultado_tmp_db_mod + edx]
    rep movsb
    add dword[indice_db_mod], 1

    mov rax, [output_hd]
    cmp rax, [divisor_db_mod]
    jge decimal_a_binario_mod
decimal_a_binario_mod_:
    call agregar_uno_final_mod
    call invertir_resultado_mod

ret

agregar_uno_final_mod:
    mov al, 49
    mov [caracter_db_mod], al

    mov edx, [indice_db_mod]
    mov rcx, 1
    lea rsi, [caracter_db_mod]
    lea rdi, [resultado_tmp_db_mod + edx]
    rep movsb

ret

invertir_resultado_mod:
    mov rcx, resultado_tmp_db_mod
    sub rsp, 32
    call strlen
    add rsp, 32
    mov [longitud_db_mod], rax

    mov	rdi, 0
	mov	rsi, [longitud_db_mod]
    ver_fin_copia_mod:	
        cmp	rsi, 0
        je	fin_copia_mod
        mov	al, [resultado_tmp_db_mod + rsi - 1]
        mov	[resultado_db_mod+rdi], al
        dec	rsi
        inc	rdi
        jmp	ver_fin_copia_mod	
    fin_copia_mod:
        mov	byte[resultado_db_mod + rdi + 1], 0

ret

limpiar_resultado_tmp_mod:
    mov rcx, 32
    lea rsi, [string_cero_inicializado_mod]
    lea rdi, [resultado_tmp_db_mod]
    rep movsb
ret

decimal_a_hexa:
    mov rax, [output_bd]
    cmp rax, [divisor_dh]
    jl caso_borde_dh
    xor rdx, rdx
    mov rbx, [divisor_dh]
    idiv rbx
    mov qword[resto_dh], rdx

    mov [output_bd], rax

    add qword[resto_dh], 48
    call capturar_caracter_decimal
    mov al, [resto_dh]
    mov [caracter_dh], al

    mov edx, [indice_dh]
    mov rcx, 1
    lea rsi, [caracter_dh]
    lea rdi, [resultado_tmp_dh + edx]
    rep movsb
    add dword[indice_dh], 1

    mov rax, [output_bd]
    cmp rax, [divisor_dh]
    jge decimal_a_hexa
    mov [resto_dh], rax
    add qword[resto_dh], 48
decimal_a_hexa_:
    call agregar_uno_final_dh
    call invertir_resultado_dh
ret

agregar_uno_final_dh:
    call capturar_caracter_decimal
    mov al, [resto_dh]
    mov [caracter_dh], al

    mov edx, [indice_dh]
    mov rcx, 1
    lea rsi, [caracter_dh]
    lea rdi, [resultado_tmp_dh + edx]
    rep movsb
ret

invertir_resultado_dh:
    mov rcx, resultado_tmp_dh
    sub rsp, 32
    call strlen
    add rsp, 32
    mov [longitud_dh], rax

    mov	rdi, 0
	mov	rsi, [longitud_dh]
    ver_fin_copia_dh:	
        cmp	rsi, 0
        je	fin_copia_dh
        mov	al, [resultado_tmp_dh + rsi - 1]
        mov	[resultado_dh+rdi], al
        dec	rsi
        inc	rdi
        jmp	ver_fin_copia_dh	
    fin_copia_dh:
        mov	byte[resultado_dh + rdi + 1], 0

ret

limpiar_resultado_tmp_dh:
    mov rcx, 8
    lea rsi, [string_cero_inicializado_dh]
    lea rdi, [resultado_tmp_dh]
    rep movsb
ret

capturar_caracter_decimal:
    cmp qword[resto_dh], 58
    je caso_a_
    cmp qword[resto_dh], 59
    je caso_b_
    cmp qword[resto_dh], 60
    je caso_c_
    cmp qword[resto_dh], 61
    je caso_d_
    cmp qword[resto_dh], 62
    je caso_e_
    cmp qword[resto_dh], 63
    je caso_f_
ret
caso_a_:
    mov qword[resto_dh], 65
ret
caso_b_:
    mov qword[resto_dh], 66
ret
caso_c_:
    mov qword[resto_dh], 67
ret
caso_d_:
    mov qword[resto_dh], 68
ret
caso_e_:
    mov qword[resto_dh], 69
ret
caso_f_:
    mov qword[resto_dh], 70
ret

caso_borde_dh:
    mov rax, [exponente]
    mov [resto_dh], rax
    add qword[resto_dh], 48
    jmp decimal_a_hexa_
ret

imprimir_conf_bin_hex:
    mov rcx, nueva_linea
    sub rsp, 32
    call puts
    add rsp, 32
    
    mov rcx, signo_numero
    sub rsp, 32
    call strlen
    add rsp, 32
    mov [longitud_signo], rax

    mov rcx, resultado_db
    sub rsp, 32
    call strlen
    add rsp, 32
    mov [longitud_exponente], rax

    mov rcx, mantisa
    sub rsp, 32
    call strlen
    add rsp, 32
    mov [longitud_mantisa1], rax    

    mov rcx, [longitud_signo]
    lea rsi, [signo_numero]
    lea rdi, [output_ieee_bin]
    rep movsb

    mov rbx, [longitud_signo]

    mov rcx, [longitud_exponente]
    lea rsi, [resultado_db]
    lea rdi, [output_ieee_bin + rbx]
    rep movsb

    add rbx, [longitud_exponente]

    mov rcx, [longitud_mantisa1]
    lea rsi, [mantisa]
    lea rdi, [output_ieee_bin + rbx]
    rep movsb

    add rbx, [longitud_mantisa1]
    mov	byte[output_ieee_bin + rbx], 0

    call agregar_ceros_faltantes

    cmp byte[tipo_de_entrada_retorno], 'B'
    je imprimir_conf_bin
    cmp byte[tipo_de_entrada_retorno], 'H'
    je imprimir_conf_hex

imprimir_conf_bin:
    mov rcx, formato_not_out
    mov rdx, output_ieee_bin
    sub rsp, 32
    call printf
    add rsp, 32
    jmp imprimir_conf_bin_hex_

imprimir_conf_hex:
    mov dword[indice_bd], 0
    mov qword[output_bd], 0
    call binario_a_decimal2

    call limpiar_resultado_tmp_dh
    mov dword[indice_dh], 0
    call decimal_a_hexa

    mov rcx, formato_not_out
    mov rdx, resultado_dh
    sub rsp, 32
    call printf
    add rsp, 32

imprimir_conf_bin_hex_:
ret

agregar_ceros_faltantes:
    mov rcx, output_ieee_bin
    sub rsp, 32
    call strlen
    add rsp, 32
    mov [long_temp], rax

    cmp qword[long_temp], 32
    jl agregar_ceros_faltantes_
ret
agregar_ceros_faltantes_:
    xor rdx, rdx
    mov rdx, 32
    sub rdx, [long_temp]
agregar_ceros_faltantes__:

    mov rbx, [long_temp]
    mov rcx, 1
    lea rsi, [char_cero]
    lea rdi, [output_ieee_bin + rbx]
    rep movsb
    add rbx, 1
    mov [long_temp], rbx

    sub rdx, 1
    cmp rdx, 0
    jnz agregar_ceros_faltantes__
ret

binario_a_decimal2:
    mov rcx, output_ieee_bin
    sub rsp, 32
    call strlen
    add rsp, 32
    mov [longitud_bd], rax
    mov rcx, [longitud_bd]
    sub rax, 1
    mov [potencia_bd], rax
binario_a_decimal_2:
    mov	qword[contador_bd], rcx

    mov edx, [indice_bd]
    mov rcx, 1
    lea rsi, [output_ieee_bin + edx]
    lea rdi, [tmp_bd]
    rep movsb

	mov	rcx, tmp_bd
	mov	rdx, format_input_bd
	mov	r8, input_num_bd
	sub	rsp, 32
	call sscanf
	add	rsp, 32

    call realizar_sumatoria2

    mov	rcx, qword[contador_bd]
    add dword[indice_bd], 1
    loop binario_a_decimal_2

ret

realizar_sumatoria2:
    mov rcx, [potencia_bd]
    cmp rcx, 0
    je potencia_cero2
    mov rax, 1
f_loop2:
    imul rax, 2
    dec rcx
    cmp rcx, 0
    jg f_loop2

    imul rax, qword[input_num_bd]
    add qword[output_bd], rax
    sub qword[potencia_bd], 1
ret
potencia_cero2:
    mov rax, 1
    imul rax, qword[input_num_bd]
    add qword[output_bd], rax
ret