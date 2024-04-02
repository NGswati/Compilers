%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
int yyerror(char *s);
%}

%token NUMBER

%%

input: NUMBER NUMBER '\n' {printf("Intermediate Code:\n");
     printf("t1 = %d\nt2 = %d\nt3 = t1 / t2\nt4 = %d\nt5 = t3 * t4\nt5 = %.0d\n", 2 , $1 , $2,($1 * $2)/2);
     printf("Triangle Area: %d\n",  ($1 * $2)/2); }
     ;

%%

int main() {
        printf("Enter Base and Height: ");
    yyparse();
    return 0;
}



int yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return 1;
}
