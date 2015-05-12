%{
  #include <stdio.h>
%}

%token END 
%token COMMON
%token DATA
%token INTEGER
%token REAL
%token COMPLEX
%token LOGICAL
%token CHARACTER
%token T_STRING
%token COMMA
%token LPAREN
%token RPAREN
%token LIST
%token ICONST
%token OROP
%token DIVOP
%token ADDOP
%token MULOP
%token RCONST 
%token LCONST 
%token CCONST 
%token SCONST
%token COLON
%token LISTFUNC
%token LENGTH
%token NEW
%token ANDOP
%token NOTOP
%token POWEROP
%token RELOP
%token LBRACK
%token RBRACK
%token GOTO
%token CONTINUE 
%token RETURN 
%token STOP
%token IF 
%token THEN
%token ELSE
%token ENDIF
%token READ
%token WRITE
%token ASSIGN
%token SUBROUTINE
%token FUNCTION
%token DO
%token ENDDO
%token CALL
%token ID

%left	OROP
%left	ANDOP
%nonassoc	RELOP 
%right	NOTOP /*den dieukrinizete*/
%left	ADDOP
%left	MULOP	DIVOP 
%right	POWEROP

%{
   void yyerror (const char * msg);
%}

%%
program : body END subprograms 
;
body : declarations statements 
;
declarations : declarations type vars
 | declarations COMMON cblock_list 
 | declarations DATA vals 
 |
;
type : INTEGER
 | REAL
 | COMPLEX
 | LOGICAL
 | CHARACTER
 | T_STRING 
;


vars : vars COMMA undef_variable 
 | undef_variable
 | error COMMA  {yyerrok;}
;
undef_variable : listspec ID LPAREN dims RPAREN 
 | listspec ID 
;
listspec : LIST 
 |
;
dims : dims COMMA dim 
 | dim
 | error COMMA  {yyerrok;}
;
dim : ICONST
 | ID 
;
cblock_list : cblock_list cblock
 | cblock 
;
cblock : DIVOP ID DIVOP id_list 
;
id_list : id_list COMMA ID 
 | ID
 | error COMMA  {yyerrok;}
; 
vals : vals COMMA ID value_list 
 | ID value_list 
;
value_list : DIVOP values DIVOP
;
values : values COMMA value 
 | value
 | error COMMA   {yyerrok;}
;
value : repeat sign constant 
 | ADDOP constant 
 | constant 
;
repeat : ICONST MULOP 
 | MULOP 
;
sign : ADDOP
 |
;
constant : simple_constant 
 | complex_constant 
;
simple_constant : ICONST
 | RCONST
 | LCONST
 | CCONST
 | SCONST 
;
complex_constant : LPAREN RCONST COLON sign RCONST RPAREN 
;
statements : statements labeled_statement 
 | labeled_statement
; 
labeled_statement : label statement 
 | statement 
;
label : ICONST 
;
statement : simple_statement 
 | compound_statement 
;
simple_statement : assignment 
 | goto_statement 
 | if_statement 
 | subroutine_call 
 | io_statement 
 | CONTINUE 
 | RETURN 
 | STOP 
;
assignment : variable ASSIGN expression 
;
variable : ID LPAREN expressions RPAREN
 | LISTFUNC LPAREN expression RPAREN 
 | ID 
;
expressions : expressions COMMA expression 
 | expression
 | error COMMA   {yyerrok;}
;
expression : expression OROP expression 
 | expression ANDOP expression 
 | expression RELOP expression 
 | expression ADDOP expression 
 | expression MULOP expression 
 | expression DIVOP expression 
 | expression POWEROP expression 
 | NOTOP expression 
 | ADDOP expression 
 | variable 
 | simple_constant 
 | LENGTH LPAREN expression RPAREN 
 | NEW LPAREN expression RPAREN 
 | LPAREN expression RPAREN 
 | LPAREN expression COLON expression RPAREN 
 | listexpression 
;
listexpression : LBRACK expressions RBRACK 
 | LBRACK RBRACK 
;
goto_statement : GOTO label 
 | GOTO ID COMMA LPAREN labels RPAREN
; 
labels : labels COMMA label 
 | label 
;
if_statement : IF LPAREN expression RPAREN label COMMA label COMMA label 
 | IF LPAREN expression RPAREN simple_statement 
;
subroutine_call : CALL variable 
;
io_statement : READ read_list 
 | WRITE write_list 
;
read_list : read_list COMMA read_item 
 | read_item 
;
read_item : variable 
 | LPAREN read_list COMMA ID ASSIGN iter_space RPAREN 
;
iter_space : expression COMMA expression step 
;
step : COMMA expression
 |
;
write_list : write_list COMMA write_item 
 | write_item 
;
write_item : expression 
 | LPAREN write_list COMMA ID ASSIGN iter_space RPAREN
; 
compound_statement : branch_statement 
 | loop_statement 
;
branch_statement : IF LPAREN expression RPAREN THEN body tail 
;
tail : ELSE body ENDIF 
 | ENDIF 
;
loop_statement : DO ID ASSIGN iter_space body ENDDO
;
subprograms : subprograms subprogram 
 |
;
subprogram : header body END 
;
header : type listspec FUNCTION ID LPAREN formal_parameters RPAREN 
 | SUBROUTINE ID LPAREN formal_parameters RPAREN 
 | SUBROUTINE ID 
;
formal_parameters : type vars COMMA formal_parameters 
 | type vars 
;
%%

# include "lex.yy.c"

void yyerror (const char * msg)
{
  	printf("Line %d: Error: '%s' at '%s'\n", yylineno, msg, yytext);

}

int main ()
{
   int result = yyparse();

   if (result == 0)
      printf("Syntax Success!\n");
   else
      printf("Syntax Failure!\n");
   return result;
}
