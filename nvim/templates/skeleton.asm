s_stack segment para stack 'stack'
dw 256 dup(?)
s_stack ends

s_data segment para public
buf db 256 dup(?)
s_data ends

s_code segment para public
assume ss:s_stack, ds:s_data, cs:s_code

begin:
	mov ax, s_data
	mov ds, ax
	mov ax, s_stack
	mov ss, ax

	push bp
	mov bp, sp

	mov sp, bp
	pop bp
	
	mov al, 0
	mov ah, 4ch
	int 21h

s_code ends
end begin
; vim:ft=masm
