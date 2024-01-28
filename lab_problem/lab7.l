%{
#include <stdio.h>
int v = 0;
%}
%option noyywrap
%%
"am"|"Am"|"is"|"Is"|"are"|"Are"|"was"|"Was"|"were"|"Were"|"be"|"Be"|"being"|"Being"|"been"|"Been" {
    printf("Found 'to be' verb: %s\n", yytext);
    v++;
}
. ; // Ignore other characters
\n ; // Ignore newline characters

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
