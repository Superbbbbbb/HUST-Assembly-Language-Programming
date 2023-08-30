.686
.model flat, stdcall
 GetTickCount Proto stdcall
 printf         PROTO C :VARARG
 public cal
 public print

.data
   lpFmt db "%s",0ah,0
   lpFFmt db "%d",20h,"%d",20h,"%d",20h,"%d",0ah,0dh,0
   startTime dd ?
   buf dd ?
   samples struct
   samid db 9 dup(0)
   sda dd ?
   sdb dd ?
   sdc dd ?
   sf dd ?
samples ends

   data samples <"s1",2568099999,-1023,1256,?>,
   <"s3",425,784,0,?>,
   <"s2",2540,0,0,?>,
   <"s4",2540,-74,987,?>,
   <"s5",2540,80765,-347,?>,
   <"s6",2540,6,-32224,?>,
   <"s7",1249,87,2358,?>,
   <"s8",2759,0,0,?>,
   <"s9",0,12700,0,?>,
   <"s10",23,-453,27,?>
   lowf samples 10 dup(<>)
   midf samples 10 dup(<>)
   highf samples 10 dup(<>)

.STACK 200
.CODE

print proc near
   mov ebx, 0
lp:cmp midf.samid[ebx], 0
   je e
   lea esi, midf.samid[ebx]
   invoke printf,offset lpFmt, esi
   invoke printf,offset lpFFmt,midf.sda[ebx],midf.sdb[ebx],midf.sdc[ebx],midf.sf[ebx]
e: add ebx, sizeof samples
   cmp ebx, 250
   jne lp
   ret
print endp

copy proc stdcall arg: dword
   lea esi, data.samid[ebx]
   cmp arg, 64h
   jl l
   je m
   lea edi, highf.samid[ebx]
   jmp cpy
l: lea edi, lowf.samid[ebx]
   jmp cpy
m: lea edi, midf.samid[ebx]
cpy:mov ecx, sizeof samples
   cld
   rep movsb
   ret
copy endp

cal proc near
   local x: dword
   invoke GetTickCount
   mov startTime,eax
   mov x, 05h
   jmp l1
l2:add eax, data.sdb[ebx]
   jmp l3
l1:mov eax, data.sda[ebx]
   mov edx,0
   imul eax, x
   mov buf, l2
   inc esi
   xor edi,edx
   jmp buf
l3:lea esi,data
   sub eax, data.sdc[ebx]
   cmp esi,edi
   je l4
l5:add eax, 64h
   dec ecx
   sar eax, 7
l4:mov data.sf[ebx], eax
   invoke copy, eax
   invoke GetTickCount
   sub eax,startTime
   mov ecx,eax
   ret
cal endp
end