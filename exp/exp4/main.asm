.686
.model flat, stdcall
 ExitProcess PROTO STDCALL :DWORD
 includelib  kernel32.lib
 includelib  libcmt.lib
 includelib  legacy_stdio_definitions.lib
 printf         PROTO C :VARARG
 scanf          PROTO C :VARARG
 cal proto
 print proto

.data
   lpSmt db "%s",0
   lpFmt db "%s",0
   user_name  db 'huqinxin',0
   str1  db 10 dup(0)
   str2  db 10 dup(0)
   str3  db 'wrong password!',0ah,0dh,0
   pw  db '1'xor'a'
       db '2'xor's'
       db '3'xor'm'
       db 0
   str4  db 'input user_name:',0
   str5  db 'input password:',0
   str6  db 'wrong time!',0ah,0dh,0
   str7  db 'exit!',0
   str8  db 'input order:',0
   str9  db 10 dup(0)

.STACK 200
.CODE

strcmp macro buf1, buf2
   local p
   local l
   local l1
   local l2
   local l3
   local exit
   mov esi, 0
   mov dh, 0
p: cmp esi, 3
   je exit
   mov al, buf1[esi]
   mov bl, buf2[esi]
   cmp esi, 0
   jne l1
   xor al, 'a'
l1:cmp esi, 1
   jne l2
   xor al, 's'
l2:cmp esi, 2
   jne l3
   xor al, 'm'
l3:cmp al, bl
   jne l
   inc esi
   jmp p
l :mov dh,1
exit:
   endm

main proc c
   invoke printf,offset lpFmt,offset str4
   invoke scanf,offset lpSmt,offset str1
   mov edi, 0
l1:cmp edi, 3
   je e1
   invoke printf,offset lpFmt,offset str5
   invoke scanf,offset lpSmt,offset str2
   strcmp str2, pw
   cmp dh, 0
   je e2
l2:invoke printf,offset lpFmt,offset str3
   inc edi
   jmp l1
e1:invoke printf,offset lpFmt,offset str7
   jmp e
e2:mov ebx, 0
lp:call cal
   cmp ecx, 0
   jne t
   add ebx, 25
   cmp ebx, 250
   jne lp
   call print
e3:invoke printf,offset lpFmt,offset str8
   invoke scanf,offset lpSmt,offset str9
   cmp str9[0], 82
   je e2
   cmp str9[0], 81
   je e
   jmp e3
t :invoke printf,offset lpFmt,offset str6
e :invoke ExitProcess, 0
main endp
end
