      org 100h 
	  
	  section .text 
  
  
	mov bx, 0x00
	
	
	call cls

	
	mov bx, 0x00
	
	mov  dx, inputtext
	mov	ah,9
	int	21h
	
	call ln
	
	mov  dx, loadfile
	mov	ah,9
	int	21h
	
	call ln
	
	mov  dx, inputparameter
	mov	ah,9
	int	21h
	
	call ln
	call ln
	
	
	mov  dx, number
	mov	ah,9
	int	21h
	
	
	
	
	
	mov ah, 1
	int 21h
	
	cmp al, 0x31
	JNC textfield
	cmp al, 0x32
	JNC fileload
	
	
	
	mov	ah,4Ch
	int	21h
	
	
	


	
;textfield:	

;	call cls
	
;	mov  dx, starttext
;	mov	ah,9
;	int	21h
	
;	call ln

;start:

;	mov	ah,01h
;	int	21h
;
;	CMP al, 0x0D	
;;	JE save
;	CMP al, 8
;	JE space
;	mov [input+bx], al
;	inc bx
;	JMP start
	
;space:
;	dec bx
;	JMP start
;	
;save:
;	mov [input+bx], BYTE '$'
;
;	call ln
	
;	call ln
	
;	mov bx, 0x00
	
;	JMP conv
	
fileload:

	mov ah, 3dh
	mov al, 0
	mov dx, pfad
	int 21h

	mov ah, 3fh
	mov bx, 5
	mov cx, 32
	mov dx, input
	int 21h
	
	mov bx, ax
	mov [input+bx], BYTE '$'
	

	mov ah, 3Eh
	mov bx, 5
	int 21h
	
	mov bx, 0x00
	
	JMP print
	
	mov	ah,4Ch
	int	21h
	
conv:
	mov al, [input+bx]
	
	CMP al, 0x6E		
	JNC minus		
	CMP al, 0x61		
	JNC plus		
	CMP al, 0x4E		
	JNC minus		
	CMP al, 0x41		
	JNC plus
	CMP al, '$'		
	JNC print
	mov [input+bx], al
	inc bx
	JMP conv

	
minus:
	SUB al, 0x0D		; Substract 13 from 'A'
	mov [input+bx], al
	inc bx
	JMP conv

plus:
	ADD al, 0x0D		; Substract 13 from 'A'
	mov [input+bx], al
	inc bx
	JMP conv
	
print:

	call cls
	
	mov  dx, endtext
	mov	ah,9
	int	21h
	call ln
	
	mov [input+bx], BYTE '$'
	
	mov DX, filename
	mov CX,0x00
	mov ah,3Ch
	int 21h
	
	MOV CX, BX
	MOV BX, 5
	MOV DX, input
	mov ah,40h
	int 21h
	
	
	mov dX,input
	mov	ah,9
	int	21h

	mov	ah,4Ch
	int	21h

	cls:
	
  pusha
  mov ah, 0x00
  mov al, 0x03  ; text mode 80x25 16 colours
  int 0x10
  popa
  ret
	
	
ln: mov  dx, Newline
	mov	ah,9
	int	21h
	ret
	
	cus: mov  dx, custom
	mov	ah,9
	int	21h
	ret

section .data 

	filename: db "output.txt", 0
	pfad: db "input.txt", 0
	
	inputtext: db '[1] Input thought textfield',0x0d, 0x0a, '$'
	loadfile: db '[2] Load .txt file',0x0d, 0x0a, '$'
	inputparameter: db '[3] Input thought parameter',0x0d, 0x0a, '$'
	custom: db 'LOADED',0x0d, 0x0a, '$'
	number: db 'Choose: ', 0
	
	Newline: db 0x0d, 0x0a, '$'
	starttext: db 'Gib ein Text ein:',0x0d, 0x0a, '$'
	endtext: db 'Dein Text konvertiert:',0x0d, 0x0a, '$'
	input: db '',13,10,'$'

	buffer: db '', 13, 10, '$'
        ; put data items here 

section .bss 

        ; put uninitialized data here