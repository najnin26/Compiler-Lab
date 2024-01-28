%{
#include <stdio.h>
int v = 0;
int other=0;
%}
%option noyywrap
%%

"Am"|"Is"|"Are"|"Was"|"Were"|"Have"|"Has"|"Had" {
v++;
printf("Found 'to be' verb: %s\n", yytext);
}
[" "]"am"|"is"|"are"|"was"|"were"|"have"|"has"|"had" {
v++;
printf("Found 'to be' verb: %s\n", yytext);
}

. {other++;}
%%

int main() {
  FILE *file = fopen("sen.txt", "r");
  if (!file) {
    fprintf(stderr, "Error opening file\n");
    return 1;
  }

  yyin = file;
  yylex();

  fclose(file);

  printf("\nTotal verbs: %d\n", v);
  return 0;
}
