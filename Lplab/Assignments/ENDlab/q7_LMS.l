 Write a Lex program to print details of book chosen by user stored in input file. Details include author name, 
 publication and Edition from given input file of having all book database in Library Management System
 
 
 %{
#include<stdio.h>
#include<string.h>
%}

%option noyywrap

%start input

%%
input: { printf("Enter book name: "); }
      name { printf("Author: %s\nPublication: %s\nEdition: %s\n", author, publication, edition); }
      input
      | { printf("\nEnd of file.\n"); }
      ;

name:   { author[0] = '\0'; publication[0] = '\0'; edition[0] = '\0'; }
        [A-Za-z][A-Za-z0-9 ]*   { strcpy(book, yytext); }
        {   /* Search the book in the database */
            FILE *fp = fopen("book_database.txt", "r");
            if (fp == NULL) {
                printf("Error: Could not open file.\n");
                return 1;
            }

            char line[256], *ptr;
            while (fgets(line, sizeof(line), fp)) {
                if ((ptr = strchr(line, '\n')) != NULL) {
                    *ptr = '\0';
                }

                if (strstr(line, book) != NULL) {
                    /* Found the book, extract details */
                    char *author_start = strstr(line, "Author: ") + strlen("Author: ");
                    char *publication_start = strstr(line, "Publication: ") + strlen("Publication: ");
                    char *edition_start = strstr(line, "Edition: ") + strlen("Edition: ");

                    strcpy(author, author_start);
                    strcpy(publication, publication_start);
                    strcpy(edition, edition_start);

                    break;
                }
            }

            fclose(fp);

            if (author[0] == '\0' && publication[0] == '\0' && edition[0] == '\0') {
                printf("Book not found.\n");
            }
        }
        ;

%%

int main() {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}

char book[256], author[256], publication[256], edition[256];



-----------------------------------------------------------------------------------------------------------------------------------------


make file

Title: <book_title>
Author: <book_author>
Publication: <book_publication>
Edition: <book_edition>
