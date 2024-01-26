/*Lex program to identify operator of telephone number*/
/*Definition part*/
%{
	#include<stdio.h>
	int others = 0;
%}

/*Rules part*/
%%
"019"[0-9]+ {printf("%s is a banglalink number\n", yytext);}
"01"[7|3][0-9]+ {printf("%s is a grammen number\n", yytext);}
"018"[0-9]+ {printf("%s is an robi number\n", yytext);}
"016"[0-9]+ {printf("%s is an airtel number\n", yytext);}
[ \n\t] {others++;}
. {others++;}
%%
/*main part*/
int main()
{
	yyin=fopen("demo2.txt","r");
	yylex();
	return 0;
}
int yywrap()
{
	return 1;
}