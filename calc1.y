%{
#include <iostream>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include "util.h"

typedef struct var { char name[64]; float val; struct var *next; } var;

var var_table_tail = {"Test", 0, NULL};
var *var_table = &var_table_tail;

var *get_var(char *name){
     for (var *p = var_table; p != &var_table_tail; p = p->next){
          std::cout << "test" << std::endl;
          if (strcmp (p->name, name) == 0)
               return p;
     }
     return NULL;
}

void put_var(char *name, float val){
     var *put = (var *)malloc(sizeof(var));
     char put_name[64];
     strcopy(put_name, name);
     put->name = put_name;
     std::cout << "test1" << std::endl;
     put->val = val;
     put->next = var_table;
     var_table = put;
}

int yylex(); // A function that is to be generated and provided by flex,
             // which returns a next token when called repeatedly.
int yyerror(const char *p) { std::cerr << "error: " << p << std::endl; };
%}

%union {
    float val;
    char* id;
    /* You may include additional fields as you want. */
    /* char op; */
};

%start prog

%token LPAREN RPAREN
%token PLUS MINUS MUL DIV POW EQUALS
%token SIN COS TAN
%token MOD FLOOR CEIL ABS
%token LOG2 LOG10
%token PI
%token GBP_TO_USD USD_TO_GBP GBP_TO_EURO EURO_TO_GBP USD_TO_EURO EURO_TO_USD CEL_TO_FAH FAH_TO_CEL MI_TO_KM KM_TO_MI
%token VAR_KEYWORD 
%token <val> NUM
%token <char*> VARIABLE
%token EOL

%type <val> expr term power factor trig_function standard_function log_function conversion

%%

prog : calcs EOL                        { YYACCEPT; }
     | EOL                              { YYACCEPT; }
     ;

calcs: calc
     | calcs calc
     ;

calc: expr EOL                          { std::cout << $1 << std::endl; }
     | assignment EOL
     ;

expr : expr PLUS term                   { $$ = $1 + $3; }
     | expr MINUS term                  { $$ = $1 - $3; }
     | term                             /* default action: { $$ = $1; } */
     | trig_function
     | standard_function
     | log_function
     | conversion
     | VARIABLE                         {
                                             var *a = get_var(yylval.id);
                                             if(a) $$ = a->val;
                                             else {
                                                  std::cout << yylval.id << " not defined!" << std::endl;
                                                  YYABORT;
                                             }
                                        }
     ;

term : term MUL factor                  { $$ = $1 * $3; }
     | term DIV factor                  { $$ = $1 / $3; }
     | power                           /* default action: { $$ = $1; } */
     ;

power : factor POW factor               { $$ = pow($1, $3); }
     | factor
     ;

factor : NUM                            /* default action: { $$ = $1; } */
     | PI                               { $$ = 3.14; }
     | LPAREN expr RPAREN               { $$ = $2; }
     ; 


trig_function : COS factor              { $$ = cos($2); }
     | SIN factor                       { $$ = sin($2); }
     | TAN factor                       { $$ = tan($2); }
     ;

standard_function : expr MOD factor     { $$ = modulo($1, $3); }
     | FLOOR factor                     { $$ = floor($2); }
     | CEIL factor                      { $$ = ceil($2); }
     | ABS factor                       { $$ = fabs($2); }
     ;

log_function : LOG2 factor              { $$ = log2($2); }
     | LOG10 factor                     { $$ = log10($2); }  
     ;

conversion : expr GBP_TO_USD            { $$ = gbp_to_usd($1); }
     | expr USD_TO_GBP                  { $$ = usd_to_gbp($1); } 
     | expr GBP_TO_EURO                 { $$ = gbp_to_euro($1); }
     | expr EURO_TO_GBP                 { $$ = euro_to_gbp($1); }
     | expr USD_TO_EURO                 { $$ = usd_to_gbp($1); }
     | expr EURO_TO_USD                 { $$ = euro_to_gbp($1); }
     | expr CEL_TO_FAH                  { $$ = cel_to_fah($1); }
     | expr FAH_TO_CEL                  { $$ = fah_to_cel($1); }
     | expr MI_TO_KM                    { $$ = m_to_km($1); }
     | expr KM_TO_MI                    { $$ = km_to_m($1); }

assignment : VAR_KEYWORD VARIABLE EQUALS expr { 
                                             char name[64];
                                             strcpy(name, yylval.id);
                                             put_var(name, $4); 
                                        }
%%

int main()
{
    yyparse(); // A parsing function that will be generated by Bison.
    return 0;
}
