#include<stdio.h>

long fun(long x){
_asm{
mov eax, x
cdq
cmp edx, eax
xchg eax, edx
adc al,0
}}


int main(){
int x = 0;
x = fun(x);
printf("%d", x);

return 0;
}
