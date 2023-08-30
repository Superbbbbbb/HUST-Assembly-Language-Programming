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
   pw  db '12345678',0
   str1  db 10 dup(0)
   str2  db 10 dup(0)
   str3  db 'wrong user name!',0ah,0dh,0
   str4  db 'wrong password!',0ah,0dh,0
   str5  db 'input user name:',0
   str6  db 'input password:',0
   str7  db 'exit!',0
   str8  db 'input order:',0
   str9  db 10 dup(0)

.STACK 200
.CODE

strcmp macro buf1, buf2
   local p
   local l
   local exit
   mov esi, 0
   mov dh, 0
p: cmp esi, 9
   je exit
   mov al, buf1[esi]
   mov bl, buf2[esi]
   cmp al, bl
   jne l
   inc esi
   jmp p
l :mov dh,1
exit:
   endm

main proc c
   mov edi, 0
l1:cmp edi, 3
   je e1
   invoke printf,offset lpFmt,offset str5
   invoke scanf,offset lpSmt,offset str1
   invoke printf,offset lpFmt,offset str6
   invoke scanf,offset lpSmt,offset str2
   mov dl, 0
   strcmp str1, user_name
   cmp dh, 0
   jne l2
l4:strcmp str2, pw
   cmp dh, 0
   jne l3
l5:cmp dl,0
   je e2
   inc edi
   jmp l1
l2:invoke printf,offset lpFmt,offset str3
   mov dl, 1
   jmp l4
l3:invoke printf,offset lpFmt,offset str4
   mov dl, 1
   jmp l5
e1:invoke printf,offset lpFmt,offset str7
   jmp e
e2:mov ebx, 0
lp:call cal
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
e :invoke ExitProcess, 0
main endp
end
