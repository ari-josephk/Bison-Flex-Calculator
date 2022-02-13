%{
#include <iostream>
#include <stdlib.h>
#include "calc1.tab.h"  /* We want the tokens defined in calc1.y. */
%}

%option noyywrap

%%

                        /* 'val' in 'yylval.val' is the field declared in
                           calc1.y with the %union directive. */
-?[0-9]+\.?[0-9]*|\.[0-9]+ { yylval.val = atof(yytext); return NUM; }
"+"                     { return PLUS; }
"-"                     { return MINUS; }
"*"                     { return MUL; }
"/"                     { return DIV; }
"("                     { return LPAREN; }
")"                     { return RPAREN; }
"="                     { return EQUALS; }
"pow"                   { return POW; }
"mod"                   { return MOD; }
"floor"                 { return FLOOR; }
"ceil"                  { return CEIL; }
"abs"                   { return ABS; }
"sin"                   { return SIN; }
"cos"                   { return COS; }
"tan"                   { return TAN; }
"log2"                  { return LOG2; }
"log10"                 { return LOG10; }
"gbp_to_usd"            { return GBP_TO_USD; }
"usd_to_gbp"            { return USD_TO_GBP; }
"gbp_to_euro"           { return GBP_TO_EURO; }
"euro_to_gbp"           { return EURO_TO_GBP; }
"usd_to_euro"           { return USD_TO_EURO; }
"euro_to_usd"           { return EURO_TO_USD; }
"cel_to_fah"            { return CEL_TO_FAH; }
"fah_to_cel"            { return FAH_TO_CEL; }
"mi_to_km"              { return MI_TO_KM; }
"km_to_mi"              { return KM_TO_MI; }
"pi"                    { return PI;}
"var"                   { return VAR_KEYWORD; }
[A-Za-z][][A-Za-z0-9.]* { return VARIABLE; }
(\n|\r\n)               { return EOL;}     

[ \t]+              { /* Ignore white characters. */ }
.                       { std::cerr << "Invalid token" << std::endl; exit(1); }

%%
