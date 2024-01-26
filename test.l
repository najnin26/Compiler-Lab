%{
#undef yywrap
#define yywrap() 1
#include<stdio.h>
  int statements = 0;
  int ids = 0;
  int assign = 0;
  int rel = 0;
  int keywords = 0;
  int integers = 0; 
%}
DIGIT [0-9]
LETTER [A-Za-z]
TYPE int|char|bool|float|void|for|do|while|if|else|return|void|conio.h|stdio.h|include|main|printf|scanf
%option yylineno
%option noyywrap

%%
\n {statements++;}
{TYPE} {/*printf("%s\n",yytext);*/keywords++;}
(<|>|<=|>=|==) {rel++;}
'#'/[a-zA-Z0-9]*    {;}
[a-zA-Z]+[a-zA-Z0-9]* {printf("%s\n",yytext);ids++;}
= {assign++;}
[0-9]+ {integers++;}
.      {;}

%%
int main() {
    yyin=fopen("input.c","r");
    yylex();
    printf("\nTotal keywords: %d\n",keywords);
    printf("Total identifiers: %d\n", ids);
    return 0;
}