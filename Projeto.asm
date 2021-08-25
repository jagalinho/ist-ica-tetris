; *********************************************************************
; * Grupo:	13
; * 87700 - Ricardo Filipe Figueiredo Oliveira da Silva
; * 87667 - Joao Andre Galinho
; *	87707 - Tomas Henriques
; *********************************************************************
; * Constantes
; **********************************************************************
DISPLAYS				EQU	0A000H 	 	; endereco do porto dos DISPLAYS hexadecimais
BUFFER  				EQU 2000H		; endereco de memoria onde se guarda a tecla		
LINHA   				EQU 0008H		; posicao do bit correspondente a linha (4) a testar
POUT 					EQU 0C000H		; endereco do porto de Entrada do teclado
PIN 					EQU 0E000H		; endereco do porto de Saida do teclado
PXLSCREEN				EQU 8000H		; endereco do porto do ecra de pxl
LOWBYTE					EQU 00FFH		; mascara para isolar os 4 bits de menor peso	
HIGHBYTE				EQU 0FF00H		; mascara para isolar os bits 7 a 4
mask_1_0				EQU 0003H
nibble_2_0				EQU 0007H		; mascara para isolar os 3 ultimos bits
mask_3_0				EQU	000FH		; mascara para isolar os primeiros 4 bits
mask_7_4				EQU 00F0H
NUMERO_LINHAS_PXL		EQU 0020H		; Numero hexadecimal para 32 que corresponde ao numero de linhas do disp
NUMERO_COLUNAS_PXL		EQU 0004H		; Numero de colunas por linha no pixel screen
TETRA_COUNTER			EQU	0008H		; Numero de pixel por tetraminos
ACTIVO					EQU 0001H		
DESACTIVO				EQU 0000H		
CEM						EQU 00A0H
DEZ						EQU 000AH
DEZ_DEC					EQU 0010H
;Simbologia para as teclas do teclado
NOKEY					EQU 00FFH		; Simbolo para valor de nenhuma tecla pressa 
LEFT_KEY				EQU 0005H		; Tecla de mover para a esquerda
RIGHT_KEY				EQU 0006H		; Tecla de mover para a direita
ROTAE_KEY				EQU 0001H		; Tecla de rodar para a esquerda
ROTAD_KEY				EQU 0002H		; Tecla de rodar para a direita
DROP_KEY				EQU 0009H		; Tecla de fazer cair a tabela
TAMANHO_TABELA_ROT		EQU	0003H		; Valor do tamanho da tabelas de rotacoes
SIZE_TABELA_TETRA		EQU 0006H		; Valor para o tamanho da tabela de tetraminos possiveis
DROP_IT					EQU 0FF0H		; Valor simbolico para a queda rapida da peca
EMPTY_WORD				EQU 0000H		; Valor para as tabelas dar a entender que a word esta vazia

; Valores para o movimento dos tetraminos 
LEFT					EQU 0FFFFH		
RIGHT 					EQU 0001H
NEXTLINE				EQU	0100H

ENDLINE					EQU 807FH		; Valor para identificar o final do pixelscreen, alterar este para um valor mais pequeno fara com que a area vertical de jogo seja mais pequena
NEXTWORD				EQU 0002H		
NEXT2WORD				EQU 0004H		
VEZES2					EQU	0002H
COLUNA_PXLSCREEN		EQU	0008H
X_COLUNA_PXLSCR			EQU	000CH
COLUNA_CMPL				EQU	00F8H
POSICAO_INICIAL			EQU 0004H
CELULA_CMPL				EQU	00FFH
PREVIOUSLINE			EQU 0FFFCH
UMBYTE					EQU	0008H
PONTOS_APAGAR_LINHA 	EQU 0005H
PONTOS_APAGAR_MONSTRO	EQU 0002H 

FIM_PXLSCREEN			EQU 8080H
NL_PXLSCREEN			EQU 0004H

RESTO_POR_4				EQU	0002H
TAMANHO_MONSTRO			EQU	0003H
POS_INICIAL_MST			EQU 101AH
;trocar pecas
POS_TETRA_BCKP			EQU 0110H
;estados de jogo
GAME_OVER				EQU 0002H
GAME_PAUSE				EQU	0003H

PLACE 1000H
pilha:
	TABLE 200H
sp_iniciador:
tab_int:
	WORD activar_flag_descer_peca
	WORD activar_flag_monstro
LASTKDISP:	
	WORD	0H ;Valor da ultima tecla mostrada no ecra
LASTKREAD:	
	WORD	0H ;Valor da ultima tecla lida
LASTFUNCEXEC:	
	WORD	0H
TETRASTR:	;Tetra actual
	WORD	tetra_s_h
TETRATBL:	;Tabela de transformacao do tetra actual
	WORD	tetra_s
TETRASTR_BCKP:	;Tetra actual
	WORD	EMPTY_WORD
TETRATBL_BCKP:	;Tabela de transformacao do tetra actual
	WORD	EMPTY_WORD

TETRA_POS_MONSTRO:	;Posicao do monstro
	WORD	POS_INICIAL_MST
TETRA_POS_FINAL_MONSTRO:
	WORD	0H
phantom_point:
	WORD EMPTY_WORD
tabela_mask_x:			;Tabela para definir o pixel a ser pintado na coluna
	WORD 0080H
	WORD 0040H
	WORD 0020H
	WORD 0010H
	WORD 0008H
	WORD 0004H
	WORD 0002H
	WORD 0001H
tetra_z_h:
	WORD 0004H
	WORD 0000H
	WORD 0001H
	WORD 0100H
	WORD 0001H
	
tetra_z_v:
	WORD 0004H
	WORD 0001H
	WORD 01FFH
	WORD 0001H
	WORD 01FFH

tetra_t_c:
	WORD 0004H
	WORD 0001H
	WORD 01FFH
	WORD 0001H
	WORD 0001H
tetra_t_d:
	WORD 0004H
	WORD 0000H
	WORD 0100H
	WORD 0001H
	WORD 01FFH
tetra_t_b:
	WORD 0004H
	WORD 0000H
	WORD 0001H
	WORD 0001H
	WORD 01FFH
tetra_t_e:
	WORD 0004H
	WORD 0001H
	WORD 01FFH
	WORD 0001H
	WORD 0100H

tetra_s_h:
	WORD 0004H
	WORD 0001H
	WORD 0001H
	WORD 01FEH
	WORD 0001H
tetra_s_v:
	WORD 0004H
	WORD 0000H
	WORD 0100H
	WORD 0001H
	WORD 0100H

tetra_o_geral:
	WORD 0004H
	WORD 0000H
	WORD 0001H
	WORD 01FFH
	WORD 0001H

tetra_l_c:
	WORD 0004H
	WORD 0002H
	WORD 01FEH
	WORD 0001H
	WORD 0001H
tetra_l_d:
	WORD 0004H
	WORD 0000H
	WORD 0100H
	WORD 0100H
	WORD 0001H
tetra_l_b:
	WORD 0004H
	WORD 0000H
	WORD 0001H
	WORD 0001H
	WORD 01FEH
tetra_l_e:
	WORD 0004H
	WORD 0000H
	WORD 0001H
	WORD 0100H
	WORD 0100H
tetra_j_c:
	WORD 0004H
	WORD 0000H
	WORD 0100H
	WORD 0001H
	WORD 0001H
tetra_j_d:
	WORD 0004H
	WORD 0000H
	WORD 0001H
	WORD 01FFH
	WORD 0100H
tetra_j_b:
	WORD 0004H
	WORD 0000H
	WORD 0001H
	WORD 0001H
	WORD 0100H
tetra_j_e:
	WORD 0004H
	WORD 0001H
	WORD 0100H
	WORD 01FFH
	WORD 0001H

tetra_i_h:
	WORD 0004H
	WORD 0000H
	WORD 0001H
	WORD 0001H
	WORD 0001H
tetra_i_v:
	WORD 0004H
	WORD 0000H
	WORD 0100H
	WORD 0100H
	WORD 0100H

tetra_t:
	WORD tetra_t_c
	WORD tetra_t_e
	WORD tetra_t_b
	WORD tetra_t_d

tetra_s:
	WORD tetra_s_h
	WORD tetra_s_v
	WORD tetra_z_h
	WORD tetra_z_v

tetra_o:
	WORD tetra_o_geral
	WORD tetra_o_geral
	WORD tetra_o_geral
	WORD tetra_o_geral

tetra_l:
	WORD tetra_l_c
	WORD tetra_l_e
	WORD tetra_l_b
	WORD tetra_l_d

tetra_j:
	WORD tetra_j_c
	WORD tetra_j_e
	WORD tetra_j_b
	WORD tetra_j_d

tetra_i:
	WORD tetra_i_h
	WORD tetra_i_v
	WORD tetra_i_h
	WORD tetra_i_v

tetra:		;Tabela que contem todos os tetraminos possiveis	
	WORD tetra_t
	WORD tetra_s
	WORD tetra_o
	WORD tetra_l
	WORD tetra_j
	WORD tetra_i
monstro:
	WORD 0005H
	WORD 0000H
	WORD 0002H
	WORD 01FFH
	WORD 01FFH
	WORD 0002H
pos_monstro:
	WORD 2218H

teclado_func: ;Isto sera lido de 2 a 2 words onde a primeira simboliza a funcao e a segunda o parametro para essa funcao
	WORD activar_flag			;0 Func
	WORD inicio_jogo			;0 Param
	WORD mov_tetramino			;1 Func
	WORD LEFT					;1 Param
	WORD mov_tetramino			;2 Func
	WORD RIGHT					;2 Param
	WORD mov_tetramino			;3 Func
	WORD DROP_IT				;3 Param
	WORD EMPTY_WORD				;4 Func
	WORD EMPTY_WORD				;4 Param
	WORD rot_tetramino			;5 Func
	WORD LEFT					;5 Param
	WORD rot_tetramino			;6 Func
	WORD RIGHT					;6 Param
	WORD mov_tetramino			;7 Func
	WORD NEXTLINE				;7 Param
	WORD EMPTY_WORD				;8 Func
	WORD EMPTY_WORD				;8 Param
	WORD EMPTY_WORD				;9 Func
	WORD EMPTY_WORD				;9 Param
	WORD activar_flag			;A Func  - Para debug do jogo, forcar activacao do monstro
	WORD flag_monstro_activo	;A Param - Basta subtituir por empty_word para desabilitar
	WORD EMPTY_WORD				;B Func
	WORD EMPTY_WORD				;B Param
	WORD flip_tetra				;C Func
	WORD EMPTY_WORD				;C Param
	WORD EMPTY_WORD				;D Func
	WORD EMPTY_WORD				;D Param
	WORD pausa_jogo				;E Func
	WORD EMPTY_WORD				;E Param
	WORD EMPTY_WORD				;F Func
	WORD EMPTY_WORD				;F Param
interrupt_func:
	WORD mov_tetramino		;0 Func
	WORD NEXTLINE			;0 Param
	WORD mov_monstro		;0 Func
	WORD EMPTY_WORD			;0 Param
	
game_start:
	STRING 0H,0H,0H,0H
	STRING 0H,0H,0H,0H
	STRING 0H,0H,0H,0H
	STRING 0H,0H,0H,0H
	STRING 3FH,3CH,0C6H,0FCH
	STRING 7FH,7EH,0EEH,0FCH
	STRING 60H,66H,0FEH,0C0H
	STRING 67H,66H,0D6H,0FCH
	STRING 67H,7EH,0C6H,0FCH
	STRING 63H,7EH,0C6H,0C0H
	STRING 63H,66H,0C6H,0C0H
	STRING 7FH,66H,0C6H,0FCH
	STRING 3EH,66H,0C6H,0FCH
	STRING 0H,0H,0H,0H
	STRING 0H,0H,0H,0H
	STRING 0FBH,0F3H,0CFH,3FH
	STRING 0FBH,0F7H,0EFH,0BFH
	STRING 0C0H,0C6H,6DH,8CH
	STRING 0F8H,0C6H,6FH,8CH
	STRING 0F8H,0C7H,0EFH,0CH
	STRING 018H,0C7H,0EDH,8CH
	STRING 0F8H,0C6H,6DH,8CH
	STRING 0F8H,0C6H,6DH,8CH
	STRING 0H,0H,0H,0H
	STRING 0H,0H,0H,0H
	STRING 0H,0H,0H,0H
	STRING 0H,0H,0H,0H
	STRING 0H,0H,0H,0H
	STRING 0H,0H,0H,0H
	STRING 0H,0H,0H,0H
	STRING 0H,0H,0H,0H
	STRING 0H,0H,0H,0H

game_over:
	STRING 0H,0H,0H,0H
	STRING 0H,0H,0H,0H
	STRING 0H,0H,0H,0H
	STRING 0H,0H,0H,0H
	STRING 3FH,3CH,0C6H,0FCH
	STRING 7FH,7EH,0EEH,0FCH
	STRING 60H,66H,0FEH,0C0H
	STRING 67H,66H,0D6H,0FCH
	STRING 67H,7EH,0C6H,0FCH
	STRING 63H,7EH,0C6H,0C0H
	STRING 63H,66H,0C6H,0C0H
	STRING 7FH,66H,0C6H,0FCH
	STRING 3EH,66H,0C6H,0FCH
	STRING 0H,0H,0H,0H
	STRING 0H,0H,0H,0H
	STRING 3EH,66H,0FEH,0F8H
	STRING 7FH,66H,0FEH,0FCH
	STRING 63H,66H,0C0H,0CCH
	STRING 63H,66H,0FEH,0CCH
	STRING 63H,66H,0FEH,0F8H
	STRING 63H,66H,0C0H,0FCH
	STRING 63H,66H,0C0H,0CCH
	STRING 7FH,3CH,0FEH,0CCH
	STRING 3EH,18H,0FEH,0CCH
	STRING 0H,0H,0H,0H
	STRING 0H,0H,0H,0H
	STRING 0H,0H,0H,0H
	STRING 0H,0H,0H,0H
	STRING 0H,0H,0H,0H
	STRING 0H,0H,0H,0H
	STRING 0H,0H,0H,0H
	STRING 0H,0H,0H,0H

flag_paint_clear:	
	STRING	1H	;Flag para decidir se e para pintar ou limpar
flag_phantom_paint:	
	STRING	0H	;Flag que diz a funcao paintxy para activar a flag_phantom_found 
flag_phantom_found:	
	STRING	0H	;caso esteja alguma coluna pintada
flag_descer_peca:	
	STRING	0H	;Flag que desce a peca
flag_monstro:		
	STRING	0H	;Flag para o monstro
flag_limpar_repor_coluna:
	STRING 0H	;Flag para limpar e repor a coluna
flag_monstro_activo:
	STRING 0H	;Flag para ativar o monstro
flag_pertence:
	STRING 0H	
flag_colisao_monstro:
	STRING 0H	;Flag para verificar a colisao de um tetramino com o monstro
TETRAROT:			
	STRING	0H	;Valor que indica o indice actual da tabela de rotacoes
TETRAROT_BCKP:			
	STRING	0H	;Valor que indica o indice actual da tabela de rotacoes
contador:			
	STRING	0H	;contador para gerar pecas
inicio_jogo:		
	STRING	0H	;Flag que indica se e para iniciar o jogo
criar_peca:			
	STRING	0H	;Flag que indica se e para criar nova peca
flag_rodar_peca:			
	STRING	0H	;Flag que indica se e para rodar a peca
fim_linha:			
	STRING 	0H
TETRA_PECA_COUNTER:
	STRING	0H	;Contador das pecas
clear_screen_line:	
	STRING	0H, COLUNA_PXLSCREEN,0H,0H

pontos_screen_decimal:
	STRING 0H
; **********************************************************************
; * Codigo
; **********************************************************************

PLACE		0
MOV SP, sp_iniciador
MOV BTE, tab_int
inicio:
; inicializacoes gerais
EI0
EI1
EI
;CALL clear_pixel_screen	
;MOV R8, 0FFFFH
;CALL rotate_tetra		
;
;MOV R10, 0004H
;;MOV R0, 0FFFFH
;;ADD R10, R0
;; co1rpo principal do programa
;
;CALL paint_tetramino
;MOV R0, TETRASTR
;MOV R1, tetra_z_v
;MOV [R0], R1
;MOV R10, 0214H
;CALL paint_tetramino
;CALL paintxy
;MOV R8, flag_paint_clear
;CALL activar_flag
;
;CALL repoe_coluna
CALL clean_points
MOV R8, game_start
CAll pinta_ecra
MOV R0, inicio_jogo
MOV R1, 5
MOVB [R0], R1
main:
	CALL gerador		;Rotina de criar pecas
	CALL keyboardcheck	;Rotina de leitura do teclado
	CALL keyboardfunc	;Rotina de execucao da tecla
	CALL interrupt_exec_func	;Rotina que verifica se ocorreu interrupcoes
	JMP main

; *********************************************************************
; *	
; * Funcao:   Keyboardcheck
; * Descricao: Processo que faz varrimento do teclado
; *  
; *
; *	Paramateros: *
; *	Destroy: R1, R3, R10, R8, R9
; * Devolve: R9 (Ultima tecla pressa)
; **********************************************************************
keyboardcheck: 				;Funcao que verifica todos os botoes
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R8
	PUSH R9
	PUSH R7
	MOV R1, 	LINHA
	MOV R8, 	0
	MOV R7, 	0
nextline: 						;Cico para correr todas as linhas 		
	MOV R2, POUT
	MOVB [R2], R1				;Envia codigo R1 para as linhas do teclado
	MOV R2, PIN
	MOVB R3, [R2]				;R3 recebe resposta do teclado que varia entre 8H a 1H
	MOV R2, mask_3_0			;Mascara que isola os bits de 0 a 3
	AND R3, R2
	AND R3, R3
	JZ no_column
	CALL button_conversion		;Funcao que devolve o valor da tecla para R9
	
no_column:
	SHR R1, 1					;Proxima linha do teclado
	JNZ nextline				;R6 tem valor unico do teclado

	CALL wrdisp

	POP R7
	POP R9
	POP R8
	POP R3
	POP R2
	POP R1
	RET
  
; *********************************************************************
; *
; * Funcao:   button_conversion
; * Descricao: De acordo com o input do teclado em 
; *  devolve o valor correspondente
; *
; *	Paramateros: R1,R3
; *	Destroy: R8, R5
; * 	Devolve: R9
; **********************************************************************
	
button_conversion:				;4*(Os zeros da linha) + log2C 
	PUSH R1						;R1 LINHA - Para poder continuar o varrimento quando volta da funcao
	PUSH R5
proccess_lines:					;Adiciona 4 por cada zero no valor Binario de R1
	ADD R8, 4					;
	SHR R1, 1					;Sendo R1 o valor das linhas	EX: 1000 -> 4*3 = C 
	JNZ proccess_lines			;
	
proccess_columns:				;Adiciona 1 por cada zero no valor binario de R1 
	ADD R8, 1					;
	SHR R3, 1					;Sendo R1 o valor das colunas EX: 0100 -> 2+C = E
	JNZ proccess_columns		;
	SUB R8, 5					;Menos 5 porque sabemos que fizemos 1 contagem a mais nos ciclos de proccess_columns(-1) e proccess_lines(-4)
;Fim de calculo da linha 
	MOV R7, 1
;Actualizacao das variaveis
	MOV R9, LASTKREAD			;Vai a memoria ver qual o ultimo a ultima tecla pressa
	MOVB R1, [R9]				
	CMP R8, R1					;Se for igual salta e passa para a proxima linha
	JZ nao_actualizar			;Flag do fim da funcao
	MOV R5, BUFFER
	MOVB [R5], R8				;Grava novo valor na memoria para debug
	MOVB [R9], R8				;Guarda o novo valor para tecla mais recente

nao_actualizar:
	POP R5
	POP R1
	RET
; *********************************************************************
; *
; * Funcao:   wrdisp
; * Descricao: Escreve no ecra o valor de R8
; *
; *	Paramateros: R8
; *	Destroy: *
; * Devolve: *
; **********************************************************************

wrdisp:
	PUSH R0
	PUSH R1
	PUSH R5
	AND R7,R7					;Verifica se alguma tecla foi pressa
	JNZ zero_keyboardcheck		;Se a tecla nao e zero entao passa logo para a verificacao se ja foi mostrada
	MOV R8, NOKEY				;se for zero entao R8 = FFH e e o que mostra no ecra

zero_keyboardcheck:
	MOV R0, LASTKDISP			;Verificacao de qual a ultima tecla displayada
	MOVB R1, [R0]
	CMP R8, R1					;Compara se o valor ja foi mostrado no ecra
	JZ fim_display				;Se ja foi mostrado entao passa para o fim da funcao
	MOVB [R0], R8				;Senao, entao actualiza a variavel de ultima tecla mostrada
	MOV R0, LASTKREAD
	MOVB [R0], R8
	;MOV R5, 	
	;MOVB [R5], R8				;E escreve para onde os displays estao a ler.

fim_display:
	POP R5
	POP R1
	POP R0
	RET

	
	
; *********************************************************************
; *
; * Funcao:   keyboardfunc
; * Descricao: Funcoes do teclado
; *
; *	Paramateros: * Vindo da memoria executa o valor em (STRING)LASTKDISP *
; *	Destroy: -
; * Devolve: -
; **********************************************************************
keyboardfunc:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R8
	PUSH R9

	MOV R0, LASTKDISP
	MOVB R9, [R0]
	MOV R0, LASTFUNCEXEC
	MOVB R1, [R0]
	CMP R1, R9
	JZ no_key_keyboardfunc
	MOVB [R0], R9
	
	MOV R2, NOKEY
	CMP R9, R2
	JZ no_key_keyboardfunc
	
	MOV R0, teclado_func
	MOV R2, 4
	MUL R9, R2
	ADD R0, R9
	
	MOV R1, [R0]
	AND R1,R1
	JZ no_key_keyboardfunc
	
	ADD R0, 2
	MOV R8, [R0] 
	CALL R1
	
no_key_keyboardfunc:
	POP R9
	POP R8
	POP R2
	POP R1
	POP R0
	RET

	
; *********************************************************************
; *
; * Funcao:   flip_flag
; * Descricao: troca o sinal de uma flag no registo
; *
; *	Paramateros: R8
; *	Destroy: -
; * Devolve: -
; **********************************************************************	
flip_flag:
	PUSH R0
	PUSH R1
	PUSH R2
	
	MOV R0, R8
	MOVB R1, [R0]
	
	MOV R2, 0H
	CMP R1, R2
	JZ flip_one
	MOV R1, 0H
	JMP flip_fim
flip_one:
	MOV R1, 1H
flip_fim:
	MOVB [R0], R1
	
	POP R2
	POP R1
	POP R0
	RET
activar_flag:			; ativa a flag em R8
	PUSH R0
	PUSH R1
	MOV R0, R8
	MOV R1, ACTIVO
	MOVB [R0], R1
	POP R1
	POP R0
	RET
	
desactivar_flag:		; desativa a flag em R8
	PUSH R0
	PUSH R1
	MOV R0, R8
	MOV R1, DESACTIVO
	MOVB [R0], R1
	POP R1
	POP R0
	RET
	
clear_word:				; limpa o valor correspondente a WORD em R8
	PUSH R0
	PUSH R1
	
	MOV R0, R8
	MOV R1, EMPTY_WORD
	MOV [R0], R1
	
	POP R1
	POP R0
	RET 
; *********************************************************************
; *
; * Funcao:   clear_pixel_screen
; * Descricao: Faz reset ao ecra e pinta a coluna
; *
; *	Paramateros: -
; *	Destroy: -
; * Devolve: -
; **********************************************************************
clear_pixel_screen:					
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	
	MOV R0, NUMERO_LINHAS_PXL		; Numero de repeticoes por linha
	MOV R2, PXLSCREEN				; Para aceder a memoria do PXLSCREEN

pintar_linha:
	MOV R1, 0						;Reset do contador do numero de vezes por coluna
pintar_coluna:
	MOV R4, clear_screen_line		;String com o valor de cada coluna
	ADD R4, R1						;vamos mover 1 word aseguir
	MOVB R3, [R4]					;receber o valor da string 
	MOVB [R2], R3					;escrever o valor da string na coluna
	ADD R2, 1						;mover o ponteiro no ecra

	ADD R1, 1						;incrementar contador de colunas
	CMP R1, NUMERO_COLUNAS_PXL		;verificar se ja completou a linha
	JNZ pintar_coluna
	
	SUB R0, 1						;subtrair ao contador de linhas 
	JNZ pintar_linha				;quando for 0 quer dizer que ja pintamos o ecra todo
	
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET 
	
	
	

; *********************************************************************
; *
; * Funcao:   paintxy
; * Descricao: pinta no pixel screen nas coordenadas de R10
; *
; *	Paramateros: R10
; *	Destroy: *
; * Devolve: *
; **********************************************************************

paintxy:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	;PUSH R5
	;MOV R5, R10
	CALL calcxy		;calculo das coordenadas
	;Devolve R0 como posicao correcta no display
;****************************************************************	
	MOV R4, flag_phantom_paint	; Flag para verificar se e para pintar ou nao
	MOVB R2, [R4]
	CMP R2, ACTIVO				; Verifica se esta activa 
	JNZ paintxy_check
	
	MOVB R2, [R0]				;Ler celula
	MOV R1, ENDLINE
	MOV R4, R0
	SUB R4, R1
	JNN activar_phantom
	
	AND R2, R3					;Verifica se esta vazia
	JZ paintxy_fim				;Se nao entao passamos para o fim sem executar qualquer alteracao
activar_phantom:	
	MOV R4, flag_phantom_found
	MOV R2, ACTIVO
	MOVB [R4], R2
	MOV R4, phantom_point
	MOV [R4], R10
	JMP paintxy_fim
;****************************************************************	
paintxy_check:	
	MOV R4, flag_paint_clear
	MOVB R2, [R4]	;Como e uma string tera que ser lida com movb
	CMP R2, ACTIVO
	JNZ pintar_off
	

	MOVB R2, [R0]	; Vamos buscar o valor que la tem na coluna
	OR R3, R2		; Adicionamos o pixel que queremos adicionar
	MOVB [R0],R3	; Vamos escrever na coluna com o pixel adicionado	
	JMP paintxy_fim
pintar_off:
	NOT R3			; Vamos inverter ficando por exemplo (0010) (1101)
	MOVB R2, [R0]	; Vamos ler o que esta escrito 
	AND R2, R3		; e por exemplo temos (0011) e fazendo o AND so vamos negar o que queremos apagar: (1101) and (0011) = (0001)
	MOVB [R0],R2	; e vamos escrever esse valor na coluna

paintxy_fim:
	;POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET 

; *********************************************************************
; **
; * Funcao:   calcxy
; * Descricao: pinta no pixel screen nas coordenadas de R0
; *
; *	Paramateros: R10
; *	Destroy: *
; * Devolve: R0, R3, R2
; **********************************************************************
	
calcxy:
	PUSH R1
	
	MOV R1, R10
	MOV R0, R1
	;Criacao das coordenadas
	
	MOV R2, LOWBYTE
	AND R1, R2		;Torna-se a variavel x
	MOV R2, HIGHBYTE
	AND R0, R2		;Torna-se a variavel y
	
	
	;Calculo da linha
	SHR R0, 8		
	MOV R2, 4		;Como as linhas sao contadas 4 a 4 
	MUL R0, R2		;teremos de multiplicar o valor de y por 4
	
	MOV R3, PXLSCREEN
	ADD R0, R3		;E adicionamos o valor do endereco para ficar na linha certa
					;EX: linha:4 = 4*4 + 8000 = 8016
	
	;Calculo da coluna - como cada linha do pixel screen corresponde a 4 bits
	MOV R2, R1		;	estamos a calcular em que coluna vamos escrever 
	SHR R2, 3
	ADD R0, R2


calculo_celula:
	MOV R3, nibble_2_0		;vamos isolar os 3 ultimos bits
	AND R1, R3				;que esses vao nos dizer qual a celula na coluna
	MOV R3, 2				;multiplicacao por 2 porque a tabela
	MUL R1, R3				;esta por words
	MOV R2, tabela_mask_x	; cada coluna tem 8 celulas por isso temos uma tabela
	MOV R3, [R2+R1]			; para calcular consoante as unidades qual a celula a pintar	

	POP R1
	RET

; *********************************************************************
; *
; * Funcao: paint_tetramino
; * Descricao: Funcao que vai pintar o tetramino na posicao do cursor
; *
; *	Paramateros: R10
; *	Destroy: -
; * Devolve: -
; **********************************************************************

paint_tetramino:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R10
	
	MOV R1, TETRASTR	;Receber em memoria o tetramino a ser pintado
	MOV R2, [R1]		;passagem do endereco na memoria onde ele se encontra
						;R2 sera pontador na tabela
						;A tabela e composta pelas transformacoes a ser feitas ao ponteiro
	MOV R6, [R2]
	ADD R2, NEXTWORD

	MOV R4, 0			;inicio da contagem  sera sempre 4 blocos a ser pintados
proximo_pixel:
	MOV R0, R10			;Ter em R0 a copia de R10
	SHR R0, 8			;Cortar o bits de menor peso
	MOV R3, LOWBYTE
	AND R10, R3			;cortar os bits de maior peso
	MOV R1, [R2]		;R1 agora tem o valor da primeira posicao da tabela da peca
	ADD R2, NEXTWORD
	MOV R5, R1			;Ter copia do valor de R1 para separar em X e Y por vamos aplicar transformacoes
	SHR R1, 8
	ADD R0, R1
	SHL R0, 8
	
	MOV R3, LOWBYTE
	AND R5, R3
	ADD R10, R5
	AND R10, R3
	
	ADD R10, R0
	CALL paintxy
	
	ADD R4, 01H
	CMP R4, R6	;Compara basicamente com 4 para ver se ja foram pintados todos
	JNZ proximo_pixel
	
	POP R10
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET

; *********************************************************************
; *
; * Funcao:   rotate_tetra
; * Descricao: actualiza a word que representa a peca actual
; *		actualiza TETRASTR com o valor da tabela e o TETRAROT com o R8
; *	Paramateros: R8
; *	Destroy: -
; * Devolve: -
; **********************************************************************	
rotate_tetra:
	PUSH R0
	PUSH R1
	PUSH R2
	
	MOV R0, TETRAROT	;Buscar o indice da tabela de rotacoes
	MOVB R1, [R0]		;colocar o valor em R1
	
	
	CMP R8, 1				;verificacao se nao estamos no fim da tabela e reciniacilizar para o proximo elemento
	JNZ rotate_tetra_check_negative
	CMP R1, TAMANHO_TABELA_ROT
	JNZ rotate_tetra_check_negative
	MOV R1, 0
	JMP rotate_tetra_noadd
	
rotate_tetra_check_negative:
	MOV R0, 0FFFFH			;Verificacao se
	CMP R8, R0				;nao estamos no primeiro 
	JNZ rotate_tetra_add	;indice da tabela
	CMP R1, 0				;para passar para o ultimo elemento
	JNZ rotate_tetra_add	
	MOV R1, TAMANHO_TABELA_ROT	;Colocar o indice no fim da tabela
	JMP rotate_tetra_noadd
	
rotate_tetra_add:
	ADD R1, R8			;aplicar a transformacao de R8
rotate_tetra_noadd:
	MOV R0, TETRAROT
	MOVB [R0], R1
	MOV R0, 2			;como e por words  
	MUL R1, R0			;teremos de multiplicar o indice por 2
	MOV R0, TETRATBL	;word onde esta guardada a tabela de rot
	MOV R2, [R0]		;buscar a tabela de rotacoes actual
	MOV R0, R2
	ADD R0, R1			;Aplicar o indice
	MOV R1, [R0]
	MOV R2, TETRASTR
	MOV [R2], R1
	
	POP R2
	POP R1
	POP R0
	RET
; *********************************************************************
; *
; * Funcao:   gerador
; * Descricao: Funcao que cria o tetramino e se certa flag activa limpa o jogo
; *		
; *	Paramateros: R8
; *	Destroy: -
; * Devolve: -
; **********************************************************************	
gerador:
	PUSH R0
	PUSH R1
	PUSH R2
	
	MOV R0, contador		;processo de incrementar o contador
	MOVB R1, [R0]			;que ira sempre correr 
	ADD R1, 1
	MOVB [R0], R1
	
	MOV R0, inicio_jogo		;Verificacao da flag 
	MOVB R1, [R0]
	CMP R1, ACTIVO
	JNZ game_over_gerador
inicio_jogo_gerador:
	CALL clear_pixel_screen
	MOV R8, criar_peca
	CALL activar_flag
	MOV R8, inicio_jogo
	CALL flip_flag

game_over_gerador:
	CMP R1, GAME_OVER
	JZ nao_criar_peca

criacao_peca:
	MOV R0, criar_peca
	MOVB R1, [R0]
	CMP R1, ACTIVO
	JNZ nao_criar_peca
	
	CALL check_clear_lines
	

	
	MOV R10, POSICAO_INICIAL
	CALL set_peca
	MOV R8, flag_phantom_paint
	CALL activar_flag
	CALL paint_tetramino
	MOV R0, flag_phantom_found
	MOVB R1, [R0]
	MOV R8, flag_phantom_paint
	CALL desactivar_flag
	MOV R8, flag_phantom_found
	CALL desactivar_flag
	CMP R1, ACTIVO
	JNZ nao_game_over
	
	MOV R8, game_over
	CALL pinta_ecra
	MOV R0, inicio_jogo
	MOV R1, GAME_OVER
	MOVB [R0], R1
	CALL clean_points
	JMP nao_criar_peca

nao_game_over:
	MOV R8, flag_paint_clear
	CALL activar_flag
	CALL paint_tetramino
	MOV R8, criar_peca
	CALl flip_flag
	CALL one_more_peca
nao_criar_peca:
	POP R2
	POP R1
	POP R0
	RET

one_more_peca:
	PUSH R0
	PUSH R1
	PUSH R2
	
	MOV R0, TETRA_PECA_COUNTER
	MOVB R1, [R0]
	ADD R1, 1
	MOVB [R0], R1
	MOV R0, contador
	MOVB R2, [R0]
	MOV R0,1
	AND R2,R0
	
	MOV R0, mask_1_0
	AND R1, R0
	CMP R1, DESACTIVO
	JNZ fim_om_peca
	CMP R2, ACTIVO
	JNZ fim_om_peca
	
	MOV R8, flag_monstro_activo
	CALL activar_flag
	
fim_om_peca:	
	POP R2
	POP R1
	POP R0
	RET

; *********************************************************************
; *
; * Funcao:   Set Peca
; * Descricao: Funcao que cria o tetramino e se certa flag activa limpa o jogo
; *		
; *	Paramateros: R8
; *	Destroy: -
; * Devolve: -
; **********************************************************************		
set_peca:
	PUSH R0
	PUSH R1
	PUSH R2
	
	MOV R0, contador			;Vamos buscar ao contador
	MOVB R1, [R0]				;o indice da tabela mestre de
	MOV R2, nibble_2_0
	AND R1, R2
	MOV R0, tetra				;tetraminos, como temos 8 combinacoes
	MOV R2, R1					;diferente para 3 bits 
	SUB R2, SIZE_TABELA_TETRA	;caso o valor seja superior a 6
	JN set_peca_negativo		;vamos aproveitar o seu bit de menor peso
	SHR R1, 2
set_peca_negativo:
	MOV R2, 2					;Como e por words
	MUL R1, R2					;vamos multiplicar o R1 para ter indice par
	ADD R0, R1					;aplicacao de indice
	MOV R1, [R0]
	
	MOV R0, TETRATBL			;Indicador da tabela da peca actual
	MOV [R0], R1				
	MOV R2, [R1]				;Vamos buscar a posicao inicial
	MOV R0, TETRASTR
	MOV [R0],R2 				;e vamos preencher essa peca
	
	MOV R0, TETRAROT
	MOV R1, 0
	MOVB [R0], R1


	POP R2
	POP R1
	POP R0
	RET
; *********************************************************************
; *
; * Funcao:   Move Tetramino
; * Descricao: Funcao que dicta qual o movimento do tetramino
; *		Inclui verificacoes de movimentos possiveis e dicta quando nova peca e criada
; *	Paramateros: R8
; *	Destroy: -
; * Devolve: -
; **********************************************************************	
mov_tetramino:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	
	MOV R0, inicio_jogo			; qualquer situacao anormal no jogo
	MOVB R1, [R0]				; desabilita a funcao
	CMP R1, DESACTIVO			; (pausar, fim do jogo)
	JNZ ret_mov_tetramino		;
	
	MOV R4, R8					
	MOV R0, DROP_IT				
	CMP R4, R0					; Verifica se vai ser efetuado o DROP
	JNZ ini_mov_tetra			; executa o DROP do tetramino se a flag estiver ativa

mov_tetra_drop_it:				; DROP tetramino
	MOV R8, NEXTLINE			; move o tetramino para a linha abaixo
ini_mov_tetra:	
	MOV R0, flag_rodar_peca			; verifica se a peca vai ser rodada
	MOVB R1, [R0]				
	MOV R3, R8					; guarda o valor de R8 em R3
	
	MOV R8, flag_paint_clear	;instrucoes que vao limpar
	CALL desactivar_flag		;a peca na posicao
	CALL paint_tetramino		;actual, como flag_paint_clear e 0, paint_tetramino limpa a peca
	MOV R8, flag_phantom_paint	;Activar o processo de verificar de movimento da peca
	CALL activar_flag			
	CMP R1, ACTIVO				; verifica se a flag_phantom_paint esta ativa
	JNZ mover_peca				; se estiver ativa, move a peca
	MOV R8, R3					; busca o valor antigo de R8
	CALL rotate_tetra			; chama a funcao que trata da rotacao da peca
	JMP mov_tetra_paint			; salta para a funcao que pinta o tetramino na nova posicao

mover_peca:
	MOV R0, R10					; MOV as coordenadas xy da peca para R0
	MOV R2, LOWBYTE				; mascara para isolar o primeiro byte
	AND R0, R2					; isola a coordenada x					
	JNZ mov_tetra_parede		; se x != 0 salta para mov_tetra_parede, se x = 0 continua na rotina
	MOV R2, LEFT				; 
	CMP R3, R2					; verifica se a instrucao dada e LEFT
	JZ fim_mov_tetramino		; se for salta para o fim, a peca chegou ao fim do movimento

mov_tetra_parede:
	ADD R10, R3					; move a peca para a esquerda
mov_tetra_paint:				; verificar se pode pintar
	CALL paint_tetramino		; ativa flag_phantom_found se nao puder pintar 
	MOV R2, flag_phantom_found	; coloca o valor da flag_phantom_found em R2
	MOVB R0, [R2]				; le o valor de flag_phantom_found para R0
	MOV R8, flag_phantom_found	; move a flag para R8
	CALL desactivar_flag		; desativa a flag
	CMP R0, ACTIVO				; verifica se pode pintar
	JNZ fim_mov_tetramino		; 
	NEG R3						; nega o movimento, reverte o cursor para a posicao anterior
	CMP R1, ACTIVO				; verifica se se pretende rodar a peca
	JNZ revert_peca				; se nao se pretender rodar salta para revert_peca
	MOV R8, R3					; 
	CALL rotate_tetra			; chama rotate_tetra com o argumento negativo rotacao
	JMP mov_tetra_flip_phatom	;
revert_peca:					; move a peca
	ADD R10, R3
mov_tetra_flip_phatom:	
	MOV R8, flag_phantom_found	; passa a etiqueta para o parametro R8
	CALL desactivar_flag		; desativa a flag_phantom_found
	MOV R2, NEXTLINE			; 
	NEG R3						;
	CMP R3, R2					; verifica se o movimento impossivel era para baixo
	JNZ fim_mov_tetramino		; se nao, move para fim_mov_tetramino, se sim, segue na rotina
	
	MOV R8, criar_peca			; 
	CALL activar_flag			; se sim, activando criar_peca cria a nova peca no topo
	MOV R4, 0					; R4 = 0 para o ciclo do DROP 
	CALL verifica_colisao		; chama a funcao que verifica a colisao com o monstro
	CMP R8, ACTIVO				; se o parametro estiver ATIVO ( = 1), houve colisao com o monstro, logo a peca e o monstro desaparecem 
	JZ ret_mov_tetramino		; 

fim_mov_tetramino:				; funcao que determina o fim do movimento da peca e pinta a nova peca no topo
	
	MOV R8, flag_phantom_paint	; 	
	CALL desactivar_flag		; desativa a flag_phantom_paint
	
	MOV R8, flag_paint_clear
	CALL activar_flag			; activa a flag_paint_clear para pintar
	
	CALL paint_tetramino		; chama a funcao para pintar o tetramino
	
	MOV R8, phantom_point		; phantom_point - guarda o ultimo ponto de colisao em phantom_paint
	CALL clear_word				; limpa a informacao do ponto de colisao
	
	MOV R0, DROP_IT				;  
	CMP R4, R0					; verifica se se esta a fazer o drop da peca
	JZ 	mov_tetra_drop_it		; se sim continua o ciclo do DROP
	
ret_mov_tetramino:				; retorna
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET

; *********************************************************************
; *
; * Funcao:   verifica colisao
; * Descricao: Funcao que vai verificar se acertamos no monstro
; *		Esta rotina e chamada em mov_tetramino quando o movimento e vertical para baixo
; *	Paramateros: R8
; *	Destroy: -
; * Devolve: -
; **********************************************************************		
verifica_colisao:	
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R10
	
	MOV R8, DESACTIVO
	MOV R0, phantom_point
	MOV R1, [R0]
	AND R1, R1
	JZ ret_verifica_colisao
	
	MOV R8, phantom_point
	CALL clear_word
	
	MOV R4, monstro
	MOV R0, TETRASTR
	MOV R2, [R0]
	MOV [R0], R4
	
	
	MOV R0, TETRA_POS_MONSTRO
	MOV R10, [R0]
	MOV R3, [R0]
	
	MOV R8, R1
	CALL pertence_ponto
	
	MOV R0, flag_pertence
	MOVB R1, [R0]
	
	CMP R1, ACTIVO
	JNZ fim_verifica_colisao
	MOV R8, flag_pertence
	CALL desactivar_flag
	MOV R8, flag_colisao_monstro
	CALL activar_flag
	MOV R8, ACTIVO

fim_verifica_colisao:
	MOV R0, TETRASTR
	MOV [R0], R2	
ret_verifica_colisao:	
	POP R10
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET
; *********************************************************************
; *
; * Funcao:   rot
; * Descricao: Funcao que cria o tetramino e se certa flag activa limpa o jogo
; *	
; *	Paramateros: R8
; *	Destroy: -
; * Devolve: -
; **********************************************************************	
rot_tetramino:
	PUSH R0
	MOV R0, R8
	
	MOV R8, flag_rodar_peca
	CALL activar_flag
	
	MOV R8, R0
	CALL mov_tetramino
	
	MOV R8, flag_rodar_peca
	CALL desactivar_flag
	
	POP R0
	RET
; *********************************************************************
; *
; * Funcao:   activar_flag_monstro
; * Descricao: Interrupcao que caso a flag_monstro_activo esteja activa
; *		Que e activada de forma random, apartir do gerador em one_more_peca
; *	Paramateros: - 
; *	Destroy: -
; * Devolve: -
; **********************************************************************	
activar_flag_monstro:	
	PUSH R0
	PUSH R1
	
	MOV R0, flag_monstro_activo
	MOVB R1, [R0]
	CMP R1, ACTIVO
	JNZ fim_activar_monstro
	MOV R0, flag_monstro
	MOV R1, ACTIVO
	MOVB [R0],  R1
fim_activar_monstro:	
	POP R1
	POP R0
	RFE
activar_flag_descer_peca:
	PUSH R0
	PUSH R1
	
	MOV R0, flag_descer_peca
	MOV R1, ACTIVO
	MOVB [R0],  R1
	
	POP R1
	POP R0
	RFE
; *********************************************************************
; *
; * Funcao:   interrupt_exec_func
; * Descricao: Funcao que verifica se alguma das flags de interrupcoes foi activada
; *		E se sim activa uma funcao existente na tabela interrupt_func
;		* Possivel adicionar * 
;			As flags de interrupcoes serem guardadas numa tabela
;			E a rotina iria assignar ordenadamente essas flags.
; *	Paramateros: -
; *	Destroy: -
; * Devolve: -
; **********************************************************************	
	
interrupt_exec_func:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	
	MOV R0, inicio_jogo
	MOVB R1, [R0]
	CMP R1, DESACTIVO
	JNZ fim_interrupt_exec_func
		
int_0:	
	MOV R0, flag_descer_peca
	MOVB R1, [R0]
	CMP R1, DESACTIVO
	JZ int_1
	MOV R0, interrupt_func
	;ADD R0, R1
	MOV R2, [R0]
	ADD R0, NEXTWORD
	MOV R8, [R0]
	CALL R2
	MOV R8, flag_descer_peca
	CALL desactivar_flag
int_1:
	MOV R0, flag_monstro
	MOVB R1, [R0]
	CMP R1, 0
	JZ fim_interrupt_exec_func
	MOV R0, interrupt_func
	MOV R1, NEXT2WORD
	ADD R0, R1
	MOV R2, [R0]
	ADD R0, NEXTWORD
	MOV R8, [R0]
	CALL R2
	MOV R8, flag_monstro
	CALL desactivar_flag
fim_interrupt_exec_func:
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET
; *********************************************************************
; *
; * Funcao:   check_clear_lines
; * Descricao: Ciclo que vai verificar linha a linha se esta completa 
; *		e apaga essa linha caso completa
;		Usa 2 funcoes auxiliares, 
;			a check_full_line que e que indica se a linha esta cheia
;			a drop_line que apaga essa linha 
; *	Paramateros: R8
; *	Destroy: -
; * Devolve: -
; **********************************************************************	
check_clear_lines:
	PUSH R0
	PUSH R1
	
	MOV R0, PXLSCREEN			
	
next_line:
	MOV R8, R0
	CALL check_full_line		; Verifica se a linha esta cheia, ativando a flag em R8 se sim
	CMP R8, ACTIVO				; Verifica se a flag em R8 esta ativa
	JNZ calc_next_line			; Se a linha nao estiver cheia, verifica a proxima linha
	MOV R8, R0					
	CALL drop_line				; Faz descer todas as linhas
	MOV R8, PONTOS_APAGAR_LINHA 
	CALL add_points				; Adiciona PONTOS_APAGAR_LINHA a pontuacao
calc_next_line:
	MOV R1, NL_PXLSCREEN		
	ADD R0, R1					; Faz com que seja a linha de cima a ser verificada da proxima vez
	MOV R1, FIM_PXLSCREEN
	CMP R0, R1					; Verifica se chegamos ao fim do pixelscreen
	JNZ next_line				; Se nao, volta a verificar
	
	
	POP R1
	POP R0
	RET
; *********************************************************************
; *
; * Funcao:   check_full_line
; * Descricao: Funcao que cria o tetramino e se certa flag activa limpa o jogo
; *		
; *	Paramateros: R8
; *	Destroy: -
; * Devolve: -
; **********************************************************************	
check_full_line:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	MOV R0, R8
	MOV R8, DESACTIVO
	MOVB R1, [R0]
	MOV R2, CELULA_CMPL
	CMP R1, R2
	JNZ fim_check_full_line
	ADD R0, 1
	MOVB R1, [R0]
	MOV R2, COLUNA_CMPL
	CMP R1, R2
	JNZ fim_check_full_line
	MOV R8, ACTIVO

fim_check_full_line:
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET
; *********************************************************************
; *
; * Funcao:   drop_line
; * Descricao: Funcao que apaga a linha recebida por paramtero
; *		O apagar funciona  por escada, ou seja, recebe o valor na linha em cima e escreve na actual
;*		repetindo este ciclo ate chegarmos ao inicio do pixelscreen e insere uma linha vazia ao inicio	
; *	Paramateros: R8
; *	Destroy: -
; * Devolve: -
; **********************************************************************	
drop_line:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	
	MOV R0, R8 				;R8 tem o valor da linha actual
inicio_drop_line:	
	MOV R1, R0 				;Vamos receber o valor de 
	MOV R2, PREVIOUSLINE	; -4
	ADD R1, R2				;Vamos para a linha anterior
	MOV R3, [R1]			;Receber o valor dessa linha
	MOV [R0], R3
	ADD R0, R2
	MOV R2, PXLSCREEN
	CMP R0, R2
	JNZ inicio_drop_line
	
	MOV R4, COLUNA_PXLSCREEN
	MOV [R0], R4
	
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET
; *********************************************************************
; *
; * Funcao:   mov_monstro
; * Descricao: Funcao que movimenta o monstro e valida se ouve colisao com pecas
; *	
; *	Paramateros: R8
; *	Destroy: -
; * Devolve: -
; **********************************************************************		
mov_monstro:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R10
	;
	MOV R0, TETRA_POS_MONSTRO
	MOV R10, [R0]
	
	MOV R1, monstro
	MOV R0, TETRASTR
	MOV R4, [R0]
	MOV [R0], R1
	;Validacao de esquerda do ecra
	MOV R1, R10
	MOV R0, LOWBYTE
	AND R1, R0
	CMP R1, 0
	JNZ nao_fim_jogo_monstro
	;
	MOV R8, flag_phantom_paint
	CALL desactivar_flag
	;
	MOV R8, flag_paint_clear
	CALL desactivar_flag
	CALL paint_tetramino
	MOV R8, R10
	CALL reset_monstro
	;*************************************************
	;	INSERIR CODIGO DE FIM DE JOGO
	MOV R8, game_over
	CALL pinta_ecra
	MOV R0, inicio_jogo
	MOV R1, GAME_OVER
	MOVB [R0], R1
	CALL clean_points
	;*************************************************
	;
	JMP fim_mov_monstro
	
nao_fim_jogo_monstro:	
	MOV R0, flag_colisao_monstro
	MOVB R5, [R0]
	CMP R5, ACTIVO
	JNZ naocolisao_mov_monstro
	MOV R8, flag_phantom_paint
	CALL desactivar_flag
	
	MOV R8, PONTOS_APAGAR_MONSTRO
	CALL add_points
	
	MOV R8, flag_paint_clear
	CALL desactivar_flag
	CALL paint_tetramino
	CALL reset_monstro
	MOV R8, flag_colisao_monstro
	CALL desactivar_flag
	JMP fim_mov_monstro
	
naocolisao_mov_monstro:
	MOV R8, LEFT
	CALL mov_tetramino
	MOV R0, TETRA_POS_FINAL_MONSTRO
	MOV R2,[R0]
	CMP R10, R2
	JNZ nao_limpar_coluna
	;Primeira tentative calha sempre na coluna
	MOV R8, R10
	CALL limpar_coluna
	MOV R8, LEFT
	CALL mov_tetramino
	;Segunda tentativa sera numa peca nossa ou no "monte"
	CMP R10, R2
	JNZ nao_limpar_coluna
	;
	MOV R8, flag_paint_clear
	CALL desactivar_flag
	CALL paint_tetramino
	MOV R8, R10
	CALL reset_monstro
	;*************************************************
	;	INSERIR CODIGO DE FIM DE JOGO
	MOV R8, game_over
	CALL pinta_ecra
	MOV R0, inicio_jogo
	MOV R1, GAME_OVER
	MOVB [R0], R1
	CALL clean_points
	;*************************************************
	JMP fim_mov_monstro
	;
nao_limpar_coluna:
	;
	MOV R0, TETRA_POS_FINAL_MONSTRO
	MOV [R0], R10
	MOV R0, TETRA_POS_MONSTRO
	MOV [R0], R10
	;
fim_mov_monstro:	
	MOV R0, TETRASTR
	MOV [R0], R4
	
	POP R10
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0	
	RET
; *********************************************************************
; *
; * Funcao:   limpar_coluna
; * Descricao: Funcao que limpa a coluna dada linha e apaga o numero de blocos que estiver 
; *				na constante TAMANHO_MONSTRO
; *	Paramateros: R8
; *	Destroy: -
; * Devolve: -
; **********************************************************************	
	
limpar_coluna:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	
	
	MOV R0, R8
	SHR R0, UMBYTE
	SHL R0, VEZES2
	MOV R1,PXLSCREEN
	
	MOV R4, COLUNA_PXLSCREEN
	ADD R1, R0
	ADD R1, 1					;Para selecionar a coluna 
	MOV R2, TAMANHO_MONSTRO
	NOT R4
ciclo_limpar_coluna:	
	MOVB R3, [R1]
	AND R3, R4
	MOVB [R1], R3
	ADD R1, NL_PXLSCREEN
	SUB R2, 1
	JNZ ciclo_limpar_coluna
	JMP fim_limpar_coluna

fim_limpar_coluna:
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET
	
; *********************************************************************
; *
; * Funcao:   repoe_coluna
; * Descricao: Usa a funcao paintxy e pinta uma coluna dado X na constante X_COLUNA_PXLSCR
;
; *	Paramateros: R8
; *	Destroy: -
; * Devolve: -
; *********************************************************************
repoe_coluna:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R10
	
	MOV R0, X_COLUNA_PXLSCR
	MOV R10, 0
	ADD R10, R0
	MOV R1, NUMERO_LINHAS_PXL
	MOV R2, NEXTLINE
	
	MOV R8, flag_phantom_paint
	CALL desactivar_flag
	
	MOV R8, flag_paint_clear
	CALL activar_flag
	
	
ciclo_repoe_coluna:
	CALL paintxy
	
	ADD R10, R2
	
	SUB R1, 1
	JNZ ciclo_repoe_coluna
	
	POP R10
	POP R2
	POP R1
	POP R0
	RET
	
; *********************************************************************
; *
; * Funcao:   reset_monstro
; * Descricao: Funcao que repoe os vaores do monstro ao iniciais.
; *	Paramateros: R8
; *	Destroy: -
; * Devolve: -
; *********************************************************************
reset_monstro:
	PUSH R0
	PUSH R1
	PUSH R2

	MOV R2, R8
	MOV R0, TETRA_POS_MONSTRO
	MOV R1, POS_INICIAL_MST
	MOV [R0], R1
	MOV R0, TETRA_POS_FINAL_MONSTRO
	MOV R1, 0
	MOV [R0], R1
	
	
	CALL repoe_coluna
	
	MOV R8, flag_limpar_repor_coluna
	CALL desactivar_flag
	MOV R8, flag_monstro_activo
	CALL desactivar_flag
	
	POP R2
	POP R1
	POP R0
	RET
	
; *********************************************************************
; *
; * Funcao:   Pertence ponto
; * Descricao: funcao que recebe dada coordenada e valida se pertence ao objecto
; *	 			na constante TETRASTR	
; *	Paramateros: R8
; *	Destroy: -
; * Devolve: -
; **********************************************************************	
pertence_ponto:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R10
	
	MOV R1, TETRASTR	;Receber em memoria o tetramino a ser pintado
	MOV R2, [R1]		;passagem do endereco na memoria onde ele se encontra
						;R2 sera pontador na tabela
						;A tabela e composta pelas transformacoes a ser feitas ao ponteiro
	MOV R6, [R2]
	ADD R2, NEXTWORD

	MOV R4, 0			;inicio da contagem  sera sempre 4 blocos a ser pintados
proximo_pixel_pertence:
	MOV R0, R10			;Ter em R0 a copia de R10
	SHR R0, 8			;Cortar o bits de menor peso
	MOV R3, LOWBYTE
	AND R10, R3			;cortar os bits de maior peso
	MOV R1, [R2]		;R1 agora tem o valor da primeira posicao da tabela da peca
	ADD R2, NEXTWORD
	MOV R5, R1			;Ter copia do valor de R1 para separar em X e Y por vamos aplicar transformacoes
	SHR R1, 8
	ADD R0, R1
	SHL R0, 8
	
	MOV R3, LOWBYTE
	AND R5, R3
	ADD R10, R5
	AND R10, R3
	
	ADD R10, R0
	CMP R10, R8
	JZ encontrado_pertence

	;CALL paintxy
next_pertence:	
	ADD R4, 01H
	CMP R4, R6	;Compara basicamente com 4 para ver se ja foram pintados todos
	JNZ proximo_pixel_pertence
	JMP ret_pertence
encontrado_pertence:
	MOV R8, flag_pertence
	CALL activar_flag
ret_pertence:	
	POP R10
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET
	
; *********************************************************************
; *
; * Funcao:   pinta_ecra
; * Descricao: Funcao que percorre um conjunto de 128 STRINGS dada etiqueta inicializacoes
;				E preenche o pixelscreen com o seus valores
; *	Paramateros: R8
; *	Destroy: -
; * Devolve: -
; *********************************************************************
pinta_ecra:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	
	MOV R0, PXLSCREEN
	MOV R1, R8
	MOV R2, FIM_PXLSCREEN
	
ciclo_pinta_ecra:
	MOVB R3, [R1]
	ADD R1, 1
	MOVB [R0],R3 
	ADD R0, 1
	
	CMP R0, R2
	JNZ ciclo_pinta_ecra
	
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET
	
; *********************************************************************
; *
; * Funcao:   pausa_jogo
; * Descricao: Funcao que coloca a flag inicio_jogo != 0 e troca as cores do ecra
; *		
; *	Paramateros: -
; *	Destroy: -
; * Devolve: -
; **********************************************************************	 	
pausa_jogo:
	PUSH R0
	PUSH R1
	PUSH R2
	
	MOV R0, inicio_jogo
	MOVB R1, [R0]
	CMP R1, GAME_PAUSE
	JZ continuar_jogo
	MOV R1, GAME_PAUSE
	MOVB [R0], R1
	CALL flip_screen
	JMP fim_pausa_jogo
continuar_jogo:
	CALL flip_screen
	MOV R1, DESACTIVO
	MOVB [R0], R1
fim_pausa_jogo:	
	POP R2
	POP R1
	POP R0
	RET

flip_screen:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	
	MOV R0, PXLSCREEN
	MOV R2, FIM_PXLSCREEN
	
ciclo_flip_ecra:
	MOVB R3, [R0]
	NOT R3
	MOVB [R0], R3 
	ADD R0, 1
	
	CMP R0, R2
	JNZ ciclo_flip_ecra
	
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET
	
; *********************************************************************
; *
; * Funcao:   Add points
; * Descricao: Funcao qeue vai escrever pontos no display
; *		
; *	Paramateros: R8 - Numero de pontos a adicionar ao valor no display
; *	Destroy: -
; * Devolve: -
; **********************************************************************	 
add_points:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	
	
	MOV R0, pontos_screen_decimal
	MOVB R1, [R0]
	ADD R8, R1
	CALL convert_hx_to_dec
	CALL writedisplay
	
	MOV R0, pontos_screen_decimal
	MOVB [R0], R8
	
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET
; *********************************************************************
; *
; * Funcao:   convert_hx_to_dec
; * Descricao: Converte dado Hexadecimal, tamanho maximo 1 byte num valor simbolico de decimal
; *				
; *	Paramateros: R8 - Valor em hexadecimal
; *	Destroy: -
; * Devolve: R8 - Valor simbolico em Decimal
; *********************************************************************
convert_hx_to_dec:					
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	
	MOV R0, R8						
	MOV R1, R0
	
	MOV R2, mask_3_0
	AND R0, R2
	MOV R2, DEZ
	CMP R0, R2
	JN negativo_chxdec
	
	SUB R0, R2
	MOV R2, DEZ_DEC
	ADD R1, R2
	
negativo_chxdec:
	;ADD R1, R0
	MOV R2, mask_7_4
	AND R1, R2 
	MOV R2, CEM
	CMP R1, R2
	JN nao_cem
	MOV R1, 0
nao_cem:	
	ADD R1, R0

	MOV R8, R1
	
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET
; *********************************************************************
; *
; * Funcao:   writedisplay
; * Descricao: Escreve byte menor peso dado em R8 nos displays
; *				
; *	Paramateros: R8
; *	Destroy: -
; * Devolve: -
; *********************************************************************
writedisplay:
	PUSH R0
	MOV R0, DISPLAYS
	MOVB [R0], R8
	POP R0
	RET
; *********************************************************************
; *
; * Funcao:   paint_monstro
; * Descricao: Funcao que dado valor em R8 ( ACTIVO, DESACTIVO) pinta ou limpa o monstro
; *				Esta rotina e usada em limpar linhas do ecra para que o monstro nao seja
; *			movido
; *	Paramateros: R8
; *	Destroy: -
; * Devolve: -
; *********************************************************************
paint_monstro:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R10
	
	MOV R0, flag_monstro_activo
	MOVB R1, [R0]
	CMP R1, ACTIVO
	JNZ ret_paint_monstro
	
	MOV R5, R8
	MOV R0, TETRA_POS_MONSTRO
	MOV R10, [R0]
	
	MOV R1, monstro
	MOV R0, TETRASTR
	MOV R4, [R0]
	MOV [R0], R1
	;
	MOV R8, flag_phantom_found
	CALL desactivar_flag
	
	CMP R5, ACTIVO
	JNZ limpar_monstro
	
	
	MOV R8, flag_paint_clear
	CALL activar_flag
	JMP pintar_monstro
limpar_monstro:

	MOV R8, flag_paint_clear
	CALL activar_flag

pintar_monstro:
	CALL paint_tetramino	

	
	;
	MOV R0, TETRA_POS_FINAL_MONSTRO
	MOV [R0], R10
	MOV R0, TETRA_POS_MONSTRO
	MOV [R0], R10
	
fim_paint_monstro:	
	MOV R0, TETRASTR
	MOV [R0], R4
ret_paint_monstro:	
	POP R10
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0	
	RET
; *********************************************************************
; *
; * Funcao:   clean_points
; * Descricao: Funcao que poe pontos a zero
; *		
; *	Paramateros: -
; *	Destroy: -
; * Devolve: -
; **********************************************************************	 
clean_points:
	PUSH R0
	PUSH R1
	
	MOV R0, pontos_screen_decimal
	MOV R1, 0
	MOVB [R0], R1
	MOV R0, DISPLAYS
	MOVB [R0], R1
	
	POP R1
	POP R0
	RET
	
; *********************************************************************
; *
; * Funcao:   flip tetra
; * Descricao: rotina que troca a peca actual com uma em backup 
; * 	e activa a flag de criar uma nova peca, caso seja a primeira vez, senao troca pecas
; *	
; *	Paramateros: -
; *	Destroy: -
; * Devolve: -
; **********************************************************************	 
flip_tetra:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	;
	MOV R8, flag_phantom_paint
	CALL desactivar_flag
	MOV R8, flag_paint_clear 
	CALL desactivar_flag
	CALL paint_tetramino
	
	MOV R0, TETRASTR_BCKP
	MOV R1, [R0]
	
	CMP R1, EMPTY_WORD
	JNZ nao_gerar_nova_peca
	
	;Situacao da primeira troca
	;Pintar peca a ser feito backup
	MOV R8, flag_paint_clear 
	CALL activar_flag
	MOV R10, POS_TETRA_BCKP
	CALL paint_tetramino
	;
	MOV R0, TETRASTR
	MOV R1, [R0]
	MOV R0, TETRASTR_BCKP
	MOV [R0], R1
	;
	MOV R0, TETRATBL
	MOV R1, [R0]
	MOV R0, TETRATBL_BCKP
	MOV [R0], R1
	;
	MOV R0, TETRAROT
	MOVB R1, [R0]
	MOV R0, TETRAROT_BCKP
	MOVB [R0], R1
	;
	MOV R8, criar_peca
	CALL activar_flag
	JMP ret_flip_tetra
	;
nao_gerar_nova_peca:
	;
	MOV R8, flag_paint_clear 
	CALL desactivar_flag
	CALL paint_tetramino
	MOV R5, R10
	
	;
	MOV R0, TETRASTR
	MOV R2, [R0]
	MOV R0, TETRATBL
	MOV R3, [R0]
	MOV R0, TETRAROT
	MOVB R4, [R0]
	;
	MOV R0, TETRASTR_BCKP
	MOV R1, [R0]
	MOV R0, TETRASTR
	MOV [R0], R1
	;
	MOV R10, POS_TETRA_BCKP
	CALL paint_tetramino
	MOV R0, TETRASTR
	MOV [R0], R2
	MOV R8, flag_paint_clear
	CALL activar_flag
	CALL paint_tetramino
	;
	MOV R0, TETRASTR_BCKP
	MOV R1, [R0]
	MOV [R0], R2
	MOV R0, TETRASTR
	MOV [R0], R1
	;
	MOV R0, TETRATBL_BCKP
	MOV R1, [R0]
	MOV [R0], R3
	MOV R0, TETRATBL
	MOV [R0], R1
	
	MOV R0, TETRAROT_BCKP
	MOVB R1, [R0]
	MOVB [R0], R4
	MOV R0, TETRAROT
	MOVB [R0], R1
	
	MOV R10, POSICAO_INICIAL
	MOV R8, flag_paint_clear
	CALL activar_flag
	CALL paint_tetramino
	
	
ret_flip_tetra:
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET