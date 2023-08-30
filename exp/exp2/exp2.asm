.686
.model flat, stdcall
 ExitProcess PROTO STDCALL :DWORD
 printf  PROTO C :VARARG
 includelib  kernel32.lib
 includelib  libcmt.lib

.DATA
samples struct
   samid db 9 dup(0)
   sda dd ?
   sdb dd ?
   sdc dd ?
   sf dd ?
samples ends

   data samples <"1",2568099999,-1023,1256,?>,
   <"2",25400,5,-34467,?>,
   <"3",425,784,0,?>,
   <"4",2540,-74,987,?>,
   <"5",2540,80765,-347,?>,
   <"6",2540,6,-32224,?>,
   <"7",1249,87,2358,?>,
   <"8",2759,0,0,?>,
   <"9",40,7,0,?>,
   <"10",23,-453,27,?>
   lowf samples 10 dup(<>)
   midf samples 10 dup(<>)
   highf samples 10 dup(<>)

.STACK 200
.CODE
main proc c
   mov ebx, 0
lp:mov eax, data.sda[ebx]
   imul eax, 05h
   add eax, data.sdb[ebx]
   sub eax, data.sdc[ebx]
   add eax, 64h
   sar eax, 7
   mov data.sf[ebx], eax
   lea esi, data.samid[ebx]
   cmp eax, 64h
   jl l
   je m
   lea edi, highf.samid[ebx]
   jmp copy
l: lea edi, lowf.samid[ebx]
   jmp copy
m: lea edi, midf.samid[ebx]
   jmp copy
copy: mov ecx, sizeof samples
   add ebx, ecx
   cld
   rep movsb
   cmp ebx, 250
   jne lp
exit:invoke ExitProcess, 0
main endp
end
