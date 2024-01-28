/*Program to recognize whether a given sentence is simple or compound.*/
%{
	#include<stdio.h>
	int flag = 0;
%}

%%
and |
or |
but |
because |
if |
then |
nevertheless  { flag = 1; }
which |
who |
whom |
whose |
that          { flag = 2; }
.  ;
\n  { return 0; }
%%

int main()
{
	printf("Enter the sentence:\n");
	yylex();
	if (flag == 0)
		printf("Simple sentence\n");
	else if (flag == 1)
		printf("Compound sentence\n");
	else if (flag == 2)
		printf("Complex sentence\n");

	return 0;
}

int yywrap()
{
	return 1;
}