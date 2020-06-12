/*** Declaration ***/
%{
	#include<stdio.h>
	#include<string.h>
	#include<stdlib.h>
	#include "y.tab.h"
	char* p;
%}

DIGIT	[0-9]

/* Rules Section Starts */

/*  Prize for 2 kg of APPLE ?    */
%%

{DIGIT}+									{ 
												yylval.d = atof(yytext);
												return AMOUNT;
											}
											
Prize										{
												return PRIZE;
											}
											
for											{
												return FOR;
											}
											
kg 											{
												return KG;
											}											

of											{
												return OF;
											}

{DIGIT}*.{DIGIT}+							{ 
												yylval.d = atof(yytext); 
												return AMOUNT;
											}

[?]											{ 	return QUE;	}

APPLE|BANANA|CHERRY|MANGO|GRAPES|DATE|TOMATOES|ONION|WATERMELON		{   
												p=(char *)calloc(strlen(yytext)+1,sizeof(char));
												strcpy(p,yytext);
												yylval.c = p;
												return FRUIT;
											}

[ \t\b]										{ 	return SPACE;	}

[\n] 										{	return NEWLINE;	}

.											{ 	
												printf("Unrecognized : %s\n",yytext);
												yyerror("Invalid Command");
											}

%%

int yywrap() {
	return 1;
}

/*
int main(int argc, char **argv) {
	if(argc > 1) {
		yyin = fopen(argv[1],"r");
	}
	else {
		yyin = stdin;
	}
	yylex();
	return 0;
}
*/
