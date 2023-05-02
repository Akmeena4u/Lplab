write a program in yacc to translate the expression x=(a + b)* - c/d into (i) quadraple (ii) triple (iii) indirect triple

%{
#include <stdio.h>
#include <string.h>
int top=-1;
char stack[100][100];
void push(char *item)
{
    strcpy(stack[++top],item);
}
char *pop()
{
    return stack[top--];
}
void quadruple(char op[5])
{
    char op1[5],op2[5],res[5];
    strcpy(op2,pop());
    strcpy(op1,pop());
    sprintf(res,"t%d",top+1);
    printf("%s = %s %s %s\n",res,op1,op,op2);
    push(res);
}
void triple(char op[5])
{
    char op1[5],op2[5],res[5];
    strcpy(op2,pop());
    strcpy(op1,pop());
    sprintf(res,"( %s , %s , %s )",op,op1,op2);
    printf("t%d = %s\n",top+1,res);
    sprintf(res,"t%d",top+1);
    push(res);
}
void indirect_triple(char op[5])
{
    char op1[5],op2[5],res[5];
    strcpy(op2,pop());
    strcpy(op1,pop());
    sprintf(res,"( %s , %s , %s )",op,op1,op2);
    printf("%d = %s\n",top+1,res);
    sprintf(res,"(0,%d)",top+1);
    push(res);
}
%}
%token ID NUM
%%
S: E {printf("\nQuadruple:\n");quadruple("=");}
E: ID '=' E1 {push($3);push($1);}
E1: E2 '+' E3 {quadruple("+");}
E3: E4 '' E5 {quadruple("");}
E4: '-' E6 {quadruple("-");}
E6: ID '/' ID {push($3);push($1);quadruple("/");}
E2: ID | NUM
E5: ID | NUM
%%
int main()
{
    printf("Enter the expression:");
    yyparse();
    printf("\nTriple:\n");
    top=-1;
    yyparse();
    printf("\nIndirect Triple:\n");
    top=-1;
    yyparse();
}
int yyerror()
{
}
int yylex()
{
    int c;
    c=getchar();
    if(isalpha(c))
        return ID;
    else if(isdigit(c))
        return NUM;
    else
        return c;
}
