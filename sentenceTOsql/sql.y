%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "q.tab.h"
int yylex(void);
void yyerror(char *);
%}

%union {
    char* str;
}

%type <str> S attr condition value
%token <str> STUDENTS CLASS CREATE TABLE DROP INT FLOAT CHAR VARCHAR SELECT WHERE FROM ID NUMBER '=' '>' '<' ',' '*'
%token '\n'

%%


LINE: S '\n' {return 0;}
S:CREATE TABLE STUDENTS attr { printf("create table students ( %s);\n", $4); }
  |DROP TABLE STUDENTS {printf("drop table students;\n");}
  |DROP TABLE CLASS {printf("drop table class;\n");}
  |SELECT attr FROM STUDENTS WHERE condition  {printf("select %s from students where %s;\n", $2,$6);}
  | SELECT '*' FROM STUDENTS WHERE condition  {printf("select * from students where %s;\n",  $6);}
  | SELECT attr FROM STUDENTS {printf("select %s from students;\n", $2);}
  | SELECT '*' FROM STUDENTS  {printf("select * from students;\n");}
;

attr: ID
    |ID INT {$$ = strcat($1, " int");}
    |ID FLOAT  {$$ = strcat($1, " float");}
    |ID CHAR  {$$ = strcat($1, " char");}
    |ID VARCHAR  {$$ = strcat($1, " varchar");}
    | attr ',' ID INT  { $$ = strcat($1, ", "); $$ = strcat($$, $3); $$=strcat($$, " int");}
    | attr ',' ID FLOAT  { $$ = strcat($1, ", "); $$ = strcat($$, $3); $$=strcat($$, " float");}
    | attr ',' ID VARCHAR  { $$ = strcat($1, ", "); $$ = strcat($$, $3); $$=strcat($$, " char");}
    | attr ',' ID CHAR  { $$ = strcat($1, ", "); $$ = strcat($$, $3); $$=strcat($$, " varchar");}
    | '*' { $$ = strdup("*"); }
    | attr ',' ID { $$ = strcat($1, ", "); $$ = strcat($$, $3); }
;

condition: ID '=' value { $$ = strdup($1); $$ = strcat($$, " = "); $$ = strcat($$, $3); }
         | ID '>' value { $$ = strdup($1); $$ = strcat($$, " > "); $$ = strcat($$, $3); }
         | ID '<' value { $$ = strdup($1); $$ = strcat($$, " < "); $$ = strcat($$, $3);}
;

value: ID { $$ = strdup($1); }
     | NUMBER { $$ = strdup($1); }
;

%%

int main() {
    printf("Enter string:");
    yyparse();
    return 1;
}
