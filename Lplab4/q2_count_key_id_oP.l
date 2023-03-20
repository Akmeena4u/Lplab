//2. Write a lex program to specifying the scanner that recognises some of the keywords like begin, if, some of the operators, and
an identifier, which is defined as any string that starts with letter and followed by letters or digits, and counts the number of
identifiers, keywords, and operators encountered in the input given to the scanner.The action taken by the scanner is to
increment a counter named key when it recognizes a keyword, increment a counter op, when it encounters an operator, and
increment a counter id, when it encounters an identifier.

%{
#include <stdio.h>
int key = 0;  // counter for keywords
int op = 0;   // counter for operators
int id = 0;   // counter for identifiers
%}

%%

"begin"    { key++; printf("Keyword: begin\n"); }
"if"       { key++; printf("Keyword: if\n"); }
"+"        { op++; printf("Operator: +\n"); }
"-"        { op++; printf("Operator: -\n"); }
"*"        { op++; printf("Operator: *\n"); }
"/"        { op++; printf("Operator: /\n"); }
[[:alpha:]][[:alnum:]]*   { id++; printf("Identifier: %s\n", yytext); }

%%

int main()
{
    yylex();
    printf("Number of keywords: %d\n", key);
    printf("Number of operators: %d\n", op);
    printf("Number of identifiers: %d\n", id);
    return 0;
}
