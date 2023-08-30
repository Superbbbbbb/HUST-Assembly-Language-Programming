#include<stdio.h>
#include<string.h>

struct samples {
    char samid[9];
    int sda, sdb, sdc, sf;
};

struct samples data[10] = { {"s1", 2568099, -1023, 1256,0},
{"s2",2540,0,0,0},
{"s3",425,784,0,0 },
{"s4",2540,-74,987,0},
{"s5",2540,80765,-347,0 },
{"s6",2540,6,-32224,0},
{"s7",1249,87,2358 ,0},
{"s8",2759,0,0,0},
{"s9",0,12700,0,0 },
{"s10",23,-453,27 ,0} };

struct samples lowf[10], midf[10], highf[10];

int main() {
    char password[20], username[20];
    char rightName[20] = "huqinxin";
    char rightPassword[20] = "12345678";
    int i;
    for (i = 0; i < 3; i++) {
        printf_s("input username:");
        scanf_s("%s", username, 20);
        printf_s("input password:");
        scanf_s("%s", password, 20);
        int a = strcmp(password, rightPassword);    //比较字符串
        int b = strcmp(username, rightName);
        if (a) printf_s("wrong password\n");
        if (b) printf_s("wrong username\n");
        if (!a && !b) break;
    }
    if (i == 3) return 0;
r:
    __asm {    ;计算和复制
        mov ebx, 0
        lp:
        mov eax, data.sda[ebx]
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
            l :
        lea edi, lowf.samid[ebx]
            jmp copy
            m :
        lea edi, midf.samid[ebx]
            jmp copy
            copy :
        mov ecx, 28
            cld
            rep movsb
            add ebx, 28
            cmp ebx, 280
            je e
            jne lp
    }
e:for (i = 0; i < 10; i++) {
    if (midf[i].samid[0]) {     //打印midf区内存
        printf_s("%s, %d, %d, %d, %d\n", midf[i].samid, midf[i].sda, midf[i].sdb, midf[i].sdc, midf[i].sf);
    }
}
    char c;
    while (1) {
        printf_s("\ninput order:");
        getchar();
        scanf_s("%c", &c,1);
        if (c == '\n') continue;
        if (c == 'R')       //重做
            goto r;
        else if (c == 'M') {    //覆盖第一组数据
            printf_s("请输入新的数据，依次输入a,b,c\n");
            scanf_s("%d %d %d", &data[0].sda, &data[0].sdb, &data[0].sdc);
            data[0].sf = (5 * data[0].sda + data[0].sdb - data[0].sdc + 100) / 128;
        }
        else if (c == 'Q')      //退出
            break;
    }
    return 0;
}
