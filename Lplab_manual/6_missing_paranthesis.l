%{
         int flag=0,ln=1;
%}
%%
“(“ {
          flag++;
       }
“)” {
          flag--;
      }

[\n] {
           if(flag= =0)
                       printf(”\n the statement in the line %d has no parenthesis is missing\n”,ln);
           else
                        printf(“\n Error…..in the line:%d”,ln);
           if(flag < 0)
                       printf(”\n It has missed ( parenthesis or extra ) parenthesis \n”);
           else if(flag > 0)
                        printf(”\n It has missed ) parenthesis or extra ( parenthesis \n”);
           flag=0; ln++;
 %%

main()
{
   Char filename[20];
   printf(“\n Enter the file name:”\n);
   scanf(“%s”, filename)
   yyin=fopen(filename,”r+”);
   yylex();
}        
 


