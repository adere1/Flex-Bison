%option yylineno

%{
#include <stdio.h>
#include "calc.tab.h"
%}

digit	([0-9])
%%

"main" { return(TOK_MAIN);}

"print" { return(TOK_PRINTLN);}

"float"  { return(TOK_FLOAT); } 

{digit}+.{digit}+ {
			   sscanf(yytext, "%f", &(yylval.float_val));
			   return TOK_NUM;
		  }
"="	{ 	return(TOK_EQUALS);	}
";"	{	return(TOK_SEMICOLON);	}
"+"	{	return(TOK_ADD);	}
"-"	{	return(TOK_SUB);	}
"*"	{	return(TOK_MUL);	}
"/"	{	return(TOK_DIV);	}
"{"	{       return(TOK_BRACKETOPEN);}
"}"	{	return(TOK_BRACKETCLOSE);}
"(" 	{	return(TOK_OPENROUND);}
")"	{	return(TOK_CLOSEROUND);}

[ \t\n]* 

[a-z][a-zA-Z0-9]* { 
		    sscanf(yytext, "%s", &(yylval.tok_id));return(TOK_ID); 
		  }

. {
	printf("\nLexical analysis error: '%c'\n",yytext[0]);
	printf("Error on Line '%d'\n\n",yylineno	);
  }

%%

