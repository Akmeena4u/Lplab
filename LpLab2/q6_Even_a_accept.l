%{
//Amit kumar meena 207206
// Write LEX Code that accepts the string having even number’s of ‘a’ over input alphabet {a, b}
int a_count = 0;
%}

%%
a { a_count++; }
b {}
\n {
    if (a_count % 2 == 0) {
        printf("Accepted\n");
    } else {
        printf("Rejected\n");
    }
    a_count = 0;
}
%%

int main() {
    yylex();
    return 0;
}
