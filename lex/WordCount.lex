%{
int chars = 0;
int words = 0;
int lines = 0;
int spaces = 0;
%}
%%
[a-zA-Z]+ { words++; chars += strlen(yytext); }
\n { chars++; lines++; }
[ ] { chars++; spaces++; }
. { chars++; }
%%

int main()
{
 yylex();
 printf("Chars:%8d, Words:%8d, Spaces:%8d, Lines:%8d, \n", chars, words ,spaces, lines );
 
}
