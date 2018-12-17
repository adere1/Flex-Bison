/*---------------------Assignment 1-------------------*/

1. Group Members
	1. Name:  Nehal Rajendra Pawar
   	   Email: npawar3@binghamton.edu

	2. Name:  Aditya Surendra Dere
   	   Email: adere1@binghamton.edu

2. Testing and vefrification on Bingsuns
   Result: - Tested & Working Fine

3. Execution guidelines
	1. make
	2. ./calc<input   -----------(where  'input' is file name that contains the code that needs to be given as input to program)

4. Alogritham & Explanation
   
   1. In the Assignment we have implemented symbol table using structure.
   2. Structure contains Two elemnets Operand1 & Value. Operand1 stores name of symbol and Value stores it's respective value. 
   3. We have also pushed "{" opening curly bracket in the symbol table for opening block and then maintained value for variable declared inside it. In the program whenever, 
      we get "}" closing bracket( closing bracket for block) we have poped the variables declared inside a block till we find "{" open brackets from the symbol table. We 
      have implemented for loops to find the value in the symbol table for print and assignment statements in CFG.
   4. We have called yyerror for undeclared variable for CFG x=y+z; if x or y or z not declared or any error occurs we terminate the execution on program. 
      To stop the execution of program we have used YYABORT and to print line number we are using yylineno.  
   



