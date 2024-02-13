%%
[ ](a|an|the)[ ] { 
printf("You entered: %s \n",yytext);
printf("It is an article \n");
}
. ;
%%

int main()
{

yylex();
return 0;

}