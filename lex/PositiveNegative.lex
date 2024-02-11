%%
[+]*[0-9]+ {printf("You have Entered a positive Integer");}
[-][0-9]+ {printf("You have Entered a negative Integer");}
%%

int main()
{
yylex();
}
