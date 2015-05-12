%option case-insensitive
%option yylineno
%{   
#include <math.h>
#include "syntax.tab.h"
void string_function(char *s);
static char array[1000];
static int i=0;
int line=1;
int commline=1;
%}
%x STRING
%x INIT  
%%  
 {BEGIN(INIT);}
<INIT>
{
"0"             								{printf("decimal ICONST: %s \n", yytext);return ICONST;}
[1-9]+[0-9]*   		        				{printf("decimal ICONST: %s \n", yytext);return ICONST;}
"0B"[1]+[0-1]*                  				{printf("binary ICONST:  %s \n", yytext);return ICONST;}
"0O"[1-7]+[0-7]*                				{printf("octal ICONST: %s \n", yytext);return ICONST;}
"0X"[1-9A-F]+[0-9A-F]*	       			{printf("Hex ICONST:  %s \n",  yytext);return ICONST;}

"."[1-9]+                       					{printf("decimal RCONST : %s \n", yytext);return RCONST;}
"."[0-9]*[1-9]+[0-9]*           				{printf("decimal RCONST : %s \n", yytext);return RCONST;}
"0""."[1-9]*                    					{printf("decimal RCONST : %s \n", yytext);return RCONST;}
"0""."[0-9]*[1-9]+[0-9]*        			{printf("decimal RCONST : %s \n", yytext);return RCONST;}
[1-9]+[0-9]*"."[1-9]*          				{printf("decimal RCONST : %s \n", yytext);return RCONST;}
[1-9]+[0-9]*"."[0-9]*[1-9]+[0-9]*		{printf("decimal RCONST : %s \n", yytext);return RCONST;}

"."[1-9]*[Ee][+-][1-9]+[0-9]*                      				{printf("decimal RCONST : %s \n", yytext);return RCONST;}
"."[0-9]*[1-9]+[0-9]*[Ee][+-][1-9]+[0-9]*           			{printf("decimal RCONST : %s \n", yytext);return RCONST;}
"0""."[1-9]*[Ee][+-][1-9]+[0-9]*                    				{printf("decimal RCONST : %s \n", yytext);return RCONST;}
"0""."[0-9]*[1-9]+[0-9]*[Ee][+-][1-9]+[0-9]*        		{printf("decimal RCONST : %s \n", yytext);return RCONST;}
[1-9]+[0-9]*"."[1-9]*[Ee][+-][1-9]+[0-9]*          			{printf("decimal RCONST : %s \n", yytext);return RCONST;}
[1-9]+[0-9]*"."[0-9]*[1-9]+[0-9]*[Ee][+-][1-9]+[0-9]*	{printf("decimal RCONST : %s \n", yytext);return RCONST;}

"."[1-9]*[Ee][1-9]+[0-9]*                       				{printf("decimal RCONST : %s \n", yytext);return RCONST;}
"."[0-9]*[1-9]+[0-9]*[Ee][1-9]+[0-9]*           			{printf("decimal RCONST : %s \n", yytext);return RCONST;}
"0""."[1-9]*[Ee][1-9]+[0-9]*                   				{printf("decimal RCONST : %s \n", yytext);return RCONST;}
"0""."[0-9]*[1-9]+[0-9]*[Ee][1-9]+[0-9]*       		{printf("decimal RCONST : %s \n", yytext);return RCONST;}
[1-9]+[0-9]*"."[1-9]*[Ee][1-9]+[0-9]*          			{printf("decimal RCONST : %s \n", yytext);return RCONST;}
[1-9]+[0-9]*"."[0-9]*[1-9]+[0-9]*[Ee][1-9]+[0-9]*	{printf("decimal RCONST : %s \n", yytext);return RCONST;}

[1-9]+[0-9]*[Ee][+-][1-9]+[0-9]*			{printf("decimal RCONST : %s \n", yytext);return RCONST;}
[1-9]+[0-9]*[Ee][1-9]+[0-9]*				{printf("decimal RCONST : %s \n", yytext);return RCONST;}

"0B""."[0-1]*[1]+[0-1]*                 		{printf("binary RCONST : %s \n", yytext);return RCONST;}
"0B""."[1]*                     					{printf("binary RCONST : %s \n", yytext);return RCONST;}
"0B""0""."[0-1]*[1]+[0-1]*           		{printf("binary RCONST : %s \n", yytext);return RCONST;}
"0B""0""."[1]*                  				{printf("binary RCONST : %s \n", yytext);return RCONST;}
"0B"[1]+[0-1]*"."[0-1]*[1]+[0-1]*    	{printf("binary RCONST : %s \n", yytext);return RCONST;}
"0B"[1]+[0-1]*"."[1]*           				{printf("binary RCONST : %s \n", yytext);return RCONST;}

"0X""."[0-9A-Fa-f]*[1-9A-Fa-f]+[0-9A-Fa-f]*                     				{printf("hex RCONST : %s \n", yytext);return RCONST;}
"0X""."[1-9A-Fa-f]*                                        		 						{printf("hex RCONST : %s \n", yytext);return RCONST;}
"0X""0""."[0-9A-Fa-f]*[1-9A-Fa-f]+[0-9A-Fa-f]*                  	 			{printf("hex RCONST : %s \n", yytext);return RCONST;}
"0X""0""."[1-9A-Fa-f]*                                     		 						{printf("hex RCONST : %s \n", yytext);return RCONST;}
"0X"[1-9A-F]+[0-9A-Fa-f]*"."[0-9A-Fa-f]*[1-9A-Fa-f]+[0-9A-Fa-f]*   	{printf("hex RCONST : %s \n", yytext);return RCONST;}
"0X"[1-9A-Fa-f]+[0-9A-Fa-f]*"."[1-9A-Fa-f]*                      	 			{printf("hex RCONST : %s \n", yytext);return RCONST;}

"0O""."[1-7]*                            	  			{printf("oct RCONST : %s \n", yytext);return RCONST;}
"0O""."[0-7]*[1-7]+[0-7]*               	 		{printf("oct RCONST : %s \n", yytext);return RCONST;}
"0O""0""."[1-7]*                        			 	{printf("oct RCONST : %s \n", yytext);return RCONST;}
"0O""0""."[0-7]*[1-7]+[0-7]*        	     		{printf("oct RCONST : %s \n", yytext);return RCONST;}
"0O"[1-7]+[0-7]*"."[1-7]*                			{printf("oct RCONST : %s \n", yytext);return RCONST;}
"0O"[1-7]+[0-7]*"."[0-7]*[1-7]+[0-7]*    	{printf("oct RCONST : %s \n", yytext);return RCONST;}

".TRUE." 	   {printf("LCONST: %s\n",yytext);return LCONST;}
".FALSE." 	   {printf("LCONST: %s\n",yytext);return LCONST;}

"'"[!-~]"'"        		{printf("Cconst : %s\n",yytext);return CCONST;}
\'\\n\'	   			{printf("Cconst: Line feed\n");return CCONST;}
\'\\f\'	   			{printf("Cconst: Form feed\n");return CCONST;}
\'\\t\'	   			{printf("Cconst: Horizontal Tab\n");return CCONST;}
\'\\r\'	   			{printf("Cconst: Carriage return\n");return CCONST;}
\'\\b\'	   			{printf("Cconst: Back Space\n");return CCONST;}
\'\\v\'	   			{printf("Cconst: Vertical Tab\n");return CCONST;}


".OR."										{printf("OROP: %s\n",yytext);return OROP;}
".AND."									{printf("ANDOP: %s\n",yytext);return ANDOP;}
".NOT."									{printf("NOTOP: %s\n",yytext);return NOTOP;}
".GT."|".GE."|".LT."|".LE."|".EQ."|".NE."	{printf("RELOP: %s\n",yytext);return RELOP;}
"+"|"-"										{printf("ADDOP: %s\n",yytext);return ADDOP;}
"*"											{printf("MULOP: %s\n",yytext);return MULOP;}
"/"											{printf("DIVOP: %s\n",yytext);return DIVOP;}
"**"										{printf("POWEROP: %s\n",yytext);return POWEROP;}


"C"[D]+"R"					{printf("LISTFUNC: %s\n",yytext);return LISTFUNC;}
"C"[D]*[A][D]*"R"			{printf("LISTFUNC: %s\n",yytext);return LISTFUNC;}

"("				{printf("LPAREN: %s\n",yytext);return LPAREN;}
")"				{printf("RPAREN: %s\n",yytext);return RPAREN;}
","				{printf("COMMA: %s\n",yytext);return COMMA;}
"="				{printf("ASSIGN: %s\n",yytext);return ASSIGN;}
":"       			{printf("COLON: %s\n",yytext);return COLON;}
"["				{printf("LBRACK: %s\n",yytext);return LBRACK;}
"]"				{printf("RBRACK: %s\n",yytext);return RBRACK;}

"FUNCTION"				{printf("FUNCTION keyword\n"); return FUNCTION;}
"SUBROUTINE" 			{printf("SUBROUTINE keyword\n"); return SUBROUTINE;}
"END"						{printf("END keyword\n"); return END;}
"COMMON"				{printf("COMMON keyword\n"); return COMMON;}
"INTEGER"					{printf("INTEGER keyword\n");return INTEGER;}
"REAL"						{printf("REAL keyword\n"); return REAL;}
"COMPLEX"				{printf("COMPLEX keyword\n"); return COMPLEX;}
"LOGICAL"					{printf("LOGICAL keyword\n"); return LOGICAL;}
"CHARACTER"				{printf("CHARACTER keyword\n"); return CHARACTER;}
"STRING"					{printf("STRING keyword\n"); return T_STRING;}
"LIST"						{printf("LIST keyword\n"); return LIST;}
"DATA"					{printf("DATA keyword\n"); return DATA;}	
"CONTINUE"				{printf("CONTINUE keyword\n"); return CONTINUE;}
"GOTO"					{printf("GOTO keyword\n"); return GOTO;}
"CALL"						{printf("CALL keyword\n"); return CALL;}
"READ"					{printf("READ keyword\n"); return READ;}
"WRITE"					{printf("WRITE keyword\n"); return WRITE;}
"LENGTH"					{printf("LENGTH keyword\n"); return LENGTH;}
"IF"						{printf("IF keyword\n"); return IF;}
"THEN"					{printf("THEN keyword\n"); return THEN;}
"ELSE"						{printf("ELSE keyword\n"); return ELSE;}
"ENDIF"					{printf("ENDIF keyword\n"); return ENDIF;}
"DO"						{printf("DO keyword\n"); return  DO;}
"ENDDO"					{printf("ENDDO keyword\n"); return ENDDO;}
"STOP"					{printf("STOP keyword\n"); return STOP;}
"RETURN"					{printf("RETURN keyword\n"); return RETURN;}

[a-zA-Z]+[a-zA-Z0-9]*								{printf("ID: %s\n",yytext); return ID;}
[a-zA-Z]+([a-zA-Z0-9]*[_][a-zA-Z0-9]*)*[_]      		{printf("ID: %s\n",yytext); return ID;}


\"                               {printf("String found : ");BEGIN(STRING);}


"$".+"$"			  {printf("COMMENT: %s\n",yytext);commline=line;}
"$".+\n                          {printf("COMMENT: %s\n",yytext);line++;}


[ /t]                            {printf("WHITESPACE\n");}
.                                {printf("Lexical error at : '%s' in line %d\n",yytext,line);return 0;}
\n                               {line++;}

<<EOF>>                          {printf("End of file reached no lexical errors encountered\n"); return 0;}
}
<STRING>
{

\"			{ printf("\nEND OF STRING\n"); array[i] = '\0';BEGIN(INIT); return SCONST;}

\\n			{string_function(yytext);}
\\b			{string_function(yytext);}
\\t			{string_function(yytext);}
\\r			{string_function(yytext);}
\\f			{string_function(yytext);}
\\v			{string_function(yytext);}
\\\			{string_function(yytext);}
.			{string_function(yytext);}
}
%%
             
void string_function(char* s){
  
    if(strcmp(s,"\\n")==0){
      array[i]='\n';
      i++;
    }
    else if(strcmp(s,"\\b")==0){
      array[i]='\b';
      i++;
    }
    else if(strcmp(s,"\\t")==0){
      array[i]='\t';
      i++;
    }
    else if(strcmp(s,"\\r")==0){
      array[i]='\r';
      i++;
    }
    else if(strcmp(s,"\\f")==0){
      array[i]='\f';
      i++;
    }
    else if(strcmp(s,"\\v")==0){
      array[i]='\v';
      i++;
    }
    else if(strcmp(s,"\\")==0){
      array[i]='\\';
      i++;
	}
	else if (strcmp(s,"\"")==0){
		array[i]='"';
		i++;
    }
    else{
      printf("%s",s);
      array[i]=s[0];
      i++;
    }

}
