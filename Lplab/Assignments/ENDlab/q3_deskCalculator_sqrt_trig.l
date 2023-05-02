Write a YACC Program to Implement a calculator that evaluates all arithmetic expressions and also evaluate other operations 
like SQRT, Sin(), Pi value, percentage operations using variables. [15M]



%{
#include <stdio.h>
#include <math.h>

double variables[26] = {0}; // 26 variables, initialized to 0

int yylex(void);
void yyerror(const char *);

%}

// Tokens
%token NUM
%token VAR
%token PLUS MINUS TIMES DIVIDE
%token LPAREN RPAREN
%token SQRT SIN PI PERCENT

// Precedence rules
%left PLUS MINUS
%left TIMES DIVIDE
%left UMINUS
%right SQRT SIN PERCENT
%nonassoc PI

// Grammar rules
%start input
%%

input:
    /* empty */
    | input line
    ;

line:
    expr '\n' { printf("%.2f\n", $1); }
    | VAR '=' expr '\n' { variables[$1 - 'a'] = $3; }
    | SQRT '(' expr ')' { $$ = sqrt($3); }
    | SIN '(' expr ')' { $$ = sin($3); }
    | PI { $$ = M_PI; }
    ;

expr:
    NUM { $$ = $1; }
    | VAR { $$ = variables[$1 - 'a']; }
    | expr PLUS expr { $$ = $1 + $3; }
    | expr MINUS expr { $$ = $1 - $3; }
    | expr TIMES expr { $$ = $1 * $3; }
    | expr DIVIDE expr { $$ = $1 / $3; }
    | MINUS expr %prec UMINUS { $$ = -$2; }
    | SQRT expr { $$ = sqrt($2); }
    | SIN expr { $$ = sin($2); }
    | expr PERCENT expr { $$ = $1 * ($2 / 100.0); }
    ;

%%

int main(void) {
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int yylex(void) {
    int c = getchar();

    if (c == EOF) {
        return 0;
    }

    if (c >= '0' && c <= '9') {
        ungetc(c, stdin);
        scanf("%lf", &yylval);
        return NUM;
    }

    if (c >= 'a' && c <= 'z') {
        yylval = c;
        return VAR;
    }

    switch (c) {
        case '+':
            return PLUS;
        case '-':
            return MINUS;
        case '*':
            return TIMES;
        case '/':
            return DIVIDE;
        case '(':
            return LPAREN;
        case ')':
            return RPAREN;
        case 's':
            if (getchar() == 'i' && getchar() == 'n' && getchar() == '(') {
                return SIN;
            }
            break;
        case 'p':
            if (getchar() == 'i') {
                return PI;
            }
            break;
        case '%':
            return PERCENT;
        default:
            break;
    }

    return 0;
}

The above YACC program defines several tokens for numeric values, variables, arithmetic operators,
parentheses, and various functions like sqrt(), sin(), pi, and percentage. It also defines rules 
for parsing the input and evaluating the expressions. The input can contain multiple lines, 
each of which can be either an expression to be evaluated or a variable assignment.

