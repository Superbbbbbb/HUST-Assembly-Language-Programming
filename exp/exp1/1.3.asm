.686
.model flat, stdcall
 ExitProcess PROTO STDCALL :DWORD
 includelib  kernel32.lib
 printf         PROTO C :VARARG
 scanf          PROTO C :VARARG
 includelib  libcmt.lib
 includelib  legacy_stdio_definitions.lib

.DATA
lpFmt	db	"%s",0
lpSmt	db	"%s",0
   buf1 db 'Incorrect Password£¡',0
   buf2 db 'OK!',0
   buf3 db 'Please input the password:',0 
   buf db 11 dup(0)
   pw db '12345678',0

.STACK 200
.CODE

main proc c
   invoke printf,offset lpFmt,OFFSET buf3
   invoke scanf,offset lpSmt,OFFSET buf
   mov  eax,0
   mov  ebx,0
lp:cmp eax,9
   jg exit
   movsx ecx, byte ptr pw[eax]
   movsx edx, byte ptr buf[eax]
   cmp ecx, edx
   jne L1
   inc eax
   jmp lp
L1:mov ebx,1
   jmp exit
exit:cmp ebx,0
   je L3
   invoke printf,offset lpFmt,OFFSET buf1
   jmp e
L3:invoke printf,offset lpFmt,OFFSET buf2
e: invoke ExitProcess, 0
main endp
end
