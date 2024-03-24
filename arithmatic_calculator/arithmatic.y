%{
    #include <stdio.h>
    int yylex(void);
    void yyerror(const char *s);
    int yywrap(void);
%}

%token NUMBER ID
%left '+' '-'
%left '*' '/'

%% 
E : T	 {
				printf("Answer = %d\n", $$);
				return 0;
			}

T : 
	T '+' T { $$ = $1 + $3; }
	| T '-' T { $$ = $1 - $3; }
	| T '*' T { $$ = $1 * $3; }
	| T '/' T { $$ = $1 / $3; }
	| '-' NUMBER { $$ = -$2; }
	| '-' ID { $$ = -$2; }
	| '(' T ')' { $$ = $2; }
	| NUMBER { $$ = $1; }
	| ID { $$ = $1; };
%%

int main(){
	printf("Enter the expression :");
	yyparse();
    return 0;
}

void yyerror(const char *s) {
	printf("\nExpression is invalid\n");
}

int yywrap()
{
    return 1;
}
