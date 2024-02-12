%%

[a-z]+ {ECHO;
printf(" - Is a small letter\n");
}
. ;


%%

int main()
{

yylex();
return 0;

}