%{
#include <stdio.h>
%}

%%
am|Am|is|Is|are|Are|was|Was|were|Were|be|Be|being|Being|been|Been {
    printf("Found 'to be' verb: %s\n", yytext);
}
. ; // Ignore other characters
\n ; // Ignore newline characters

%%

int main() {
    printf("Enter the sentence:\n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
