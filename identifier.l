%{
#include<stdio.h>
int id = 0;
int key = 0;
int ot=0;
%}

%%
"int"|"float"|"double"|"char"|"if"|"for"|"printf"|"scanf"|"do"|"while"|"main"|"return"|"include"|"stdio.h"{
    key++;
    printf("%s is a keyword\n", yytext);
}
[a-zA-Z-_][a-zA-Z0-9_]* {
    id++;
    printf("%s is an identifier\n", yytext);
}
.{ot++;}
%%

int main()
 {
    yyin=fopen("input.c","r");
    yylex();
    printf("\nTotal keywords: %d\n", key);
    printf("Total identifiers: %d\n", id);
    return 0;
}
int yywrap()
{
return 1;
}
