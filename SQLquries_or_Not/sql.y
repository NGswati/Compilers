%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern void yyerror(const char *s);

%}

%union {
    char *str;
    int num;
}

%token <str> IDENTIFIER
%token <num> CONST
%token SELECT FROM WHERE AND OR '*' ',' '=' '<' '>'
%token NL

%type <str> query identifiers cond compare op

%%

query: SELECT identifiers FROM IDENTIFIER WHERE cond NL {
    printf("Valid SELECT query\n");
}
;

identifiers: '*' {
    $$ = "ALL";
}
| IDENTIFIER {
    $$ = $1;
}
| IDENTIFIER ',' identifiers {
    char *s = malloc(strlen($1) + strlen($3) + 2);
    strcpy(s, $1);
    strcat(s, " ");
    strcat(s, $3);
    $$ = s;
}
;

cond: IDENTIFIER op compare {
    printf("Valid condition\n");
}
| IDENTIFIER op compare AND cond {
    printf("Valid AND condition\n");
}
| IDENTIFIER op compare OR cond {
    printf("Valid OR condition\n");
}
;

compare: IDENTIFIER {
    printf("Valid comparison\n");
}
| CONST {
    printf("Valid comparison\n");
}
;

op: '<' {
    printf("Valid operator\n");
}
| '=' {
    printf("Valid operator\n");
}
| '>' {
    printf("Valid operator\n");
}
;

%%
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
