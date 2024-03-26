%{
#include <stdio.h>
#include <string.h>
#include "sql.tab.h"
extern YYSTYPE yylval;
%}

%%
select          { return SELECT; }
from            { return FROM; }
where           { return WHERE; }
and             { return AND; }
or              { return OR; }
[*]             { return '*'; }
[,]             { return ','; }
[=]             { return '='; }
[<]             { return '<'; }
[>]             { return '>'; }
[']            { return '\''; }
[a-zA-Z][a-zA-Z0-9]* { yylval.str = strdup(yytext); return IDENTIFIER; }
[0-9]+          { yylval.num = atoi(yytext); return CONST; }
\n              { return NL; }
[ \t]+          /* ignore whitespace */
.               { fprintf(stderr, "Invalid character: %s\n", yytext); }
%%

int yywrap() {
    return 1;
}
