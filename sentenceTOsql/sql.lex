%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "q.tab.h"
%}

%%
create { printf("Token: create\n"); return CREATE; }
drop { printf("Token: drop\n"); return DROP;}
table { printf("Token: table\n"); return TABLE; }
int { printf("Token: int\n"); return INT; }
float { printf("Token: float\n"); return FLOAT; }
char { printf("Token: char\n"); return CHAR; }
varchar { printf("Token: varchar\n"); return VARCHAR; }
students { printf("Token: students\n"); return STUDENTS; }
class { printf("Token: class\n"); return CLASS; }
give { printf("Token: select\n"); return SELECT; }
where { printf("Token: where\n"); return WHERE; }
equal {printf("Token: where\n"); return '=';}
greater {printf("Token: where\n"); return '>';}
lesser {printf("Token: where\n"); return '<';}
of { printf("Token: from\n"); return FROM; }
name|roll|cpi|class { printf("Token: id - %s\n", yytext); yylval.str = strdup(yytext); return ID; }
[0-9]+ { printf("Token: number - %s\n", yytext); yylval.str = strdup(yytext); return NUMBER; }
,|and { printf("Token: ','\n"); return ','; }
all { printf("Token: '*'\n"); return '*'; }                     
\n { printf("Token: '\\n'\n"); return '\n'; }
[ \t] ;
[a-zA-Z]+ ;
. { printf("Invalid character: %s\n", yytext); }
%%

void yyerror(char* msg){
    printf("Invalid\n");
}

int yywrap(){
    return 1;
}
