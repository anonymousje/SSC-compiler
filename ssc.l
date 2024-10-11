%{
	#include "ssc.tab.h"
	#include <stdlib.h>
	#include <stdio.h>
	#include <string>
	extern void yyerror(const char *msg);
	
	#define DEBUGSSC
	// This code is for producing debug output.
	#ifdef DEBUGSSC
		#define debugFlex(a) (printf("\n%d: Token=<ID, lexeme>=<%d, %s>\n",yylineno, a, yytext))
	#else
		#define debugFlex(a)
	#endif
%}

%option yylineno 
%option noyywrap

%%

"printd"                        {debugFlex(tok_printd); return tok_printd;}
"prints"                        {debugFlex(tok_prints); return tok_prints;}
"for"                           {debugFlex(tok_for); return tok_for;}
"while"                         {debugFlex(tok_while); return tok_while;}
"++"                            {debugFlex(tok_increment); return tok_increment;}
"--"                            {debugFlex(tok_decrement); return tok_decrement;}
[a-zA-Z][a-zA-Z0-9_]*           {debugFlex(tok_identifier); yylval.identifier=strdup(yytext); return tok_identifier;}
[0-9]+(\.[0-9]+)?               {debugFlex(tok_double_literal); yylval.double_literal=atof(yytext); return tok_double_literal;}
\"[^"]*\"                       {debugFlex(tok_string_literal); yylval.string_literal=strdup(yytext); return tok_string_literal;}
\/\/.*                          {;}
[ \n\r\t]                       {;}
"<="|">="|"<"|">"|"+"|"-"|"*"|"\/"|"="|";"|"{"|"}"|"("|")" {debugFlex(yytext[0]); return yytext[0];} 
.                                {debugFlex(-1); yyerror("this is an illegal lexeme"); exit(EXIT_FAILURE);}
%%




int main(int argc, char** argv) {
	if (argc > 1) {
		FILE *fp = fopen(argv[1], "r");
		yyin = fp; //read from file when its name is provided.
	} 
	if (yyin == NULL) { 
		yyin = stdin; //otherwise read from terminal
	}

	int token = yylex();
	while (token)
	{
		token = yylex();
	}

	return EXIT_SUCCESS;
}