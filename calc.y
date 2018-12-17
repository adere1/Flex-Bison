%{
#include <stdio.h>
#include<string.h>
#include<stdlib.h>

int counter = 0;

struct T
	{       
	   char operand1[10];		
	   float value;		
	}symbol_table[200];
%}

%token TOK_SEMICOLON TOK_ADD TOK_SUB TOK_MUL TOK_DIV TOK_NUM TOK_PRINTLN TOK_ID TOK_FLOAT TOK_EQUALS TOK_BRACKETOPEN TOK_BRACKETCLOSE TOK_OPENROUND TOK_CLOSEROUND TOK_MAIN TOK_NEWLINE


%union{       
	float float_val;
        char tok_id[10];
}

%type <float_val> expr TOK_NUM  
%type <tok_id> TOK_ID

%left TOK_ADD TOK_SUB
%left TOK_MUL TOK_DIV

%%

Prog: |TOK_MAIN TOK_OPENROUND TOK_CLOSEROUND TOK_BRACKETOPEN stmts TOK_BRACKETCLOSE        
;

stmts: 	|  stmt TOK_SEMICOLON  stmts | brcket1  stmts  brcket2 TOK_SEMICOLON stmts
;

brcket1 : TOK_BRACKETOPEN 
        	{	
			strcpy(symbol_table[counter].operand1,"{");
			symbol_table[counter].value = 0.00;
			counter++;			
        	}
;

brcket2: TOK_BRACKETCLOSE
        	{ 			
			int i;
			for(i=counter;i>=0;i--){			
				counter--;
				if(strcmp(symbol_table[i].operand1,"{")==0){				
					break;
				}
				strcpy(symbol_table[i].operand1,"");
				symbol_table[i].value = 0.00;				
   			}
			strcpy(symbol_table[i].operand1,"");
			symbol_table[i].value = 0.00;			
                     	counter++;			
        	}
;

stmt:   TOK_FLOAT  TOK_ID 
		{
			strcpy(symbol_table[counter].operand1,$2);
        		symbol_table[counter].value = 0.00;
        		counter++;
		}  
	|stmt2 	
;

stmt2: 	print | TOK_ID TOK_EQUALS expr 	 
		{
			int i;
			for(i=counter;i>=0;i--){
				if(strcmp(symbol_table[i].operand1,$1)==0){
	        			symbol_table[i].value = $3;        			
					break;
				}
                           	if(i==0){
                           		printf("\nVariable %s is not declared\n",$1);
					yyerror();
					YYABORT;

			   	}
			}	          
		}        
;

print:   TOK_PRINTLN TOK_ID 
		{                        
			int i; 
			for(i=counter;i>=0;i--){			     
				if(strcmp(symbol_table[i].operand1,$2)==0){
					printf("\n Value of %s is : %f \n", symbol_table[i].operand1, symbol_table[i].value);
					break;
				}
				if(i==0){
                           		printf("\nVariable %s is not declared\n",$2);
					yyerror();
					YYABORT;
			   	}
			}                                   
		}
;      

expr: 		
	 expr TOK_SUB expr
	  {
		$$ = $1 - $3;
	  }
	| expr TOK_MUL expr
	  {
		$$ = $1 * $3;
	  }
	| TOK_NUM 
	  { 	
		$$ = $1;
	  } 	
	| TOK_OPENROUND TOK_SUB expr TOK_CLOSEROUND
	 { 
		$$ = -$3; 
	 }
	| TOK_ID 
        { 	
		int i;
		for(i=counter-1;i>=0;i--){
			if(strcmp(symbol_table[i].operand1,$1)==0){					
				$$ =  symbol_table[i].value;
				break;
			}
			if(i==0){
                           	printf("\nVariable %s is not declared\n",$1);
				yyerror();
				YYABORT;				
			}
		}  
	  }
;

%%

int yyerror()
{
    extern int yylineno;
    
    printf("\nPrasing Error: line %d\n\n",yylineno);    
    return 0;
}


int main()
{
   yyparse();
   return 0;
}
