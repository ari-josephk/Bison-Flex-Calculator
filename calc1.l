%{
#include <iostream>
#include <stdlib.h>
#include <string.h>
#include "calc1.tab.h"  /* We want the tokens defined in calc1.y. */
%}

%option noyywrap

%%

                        /* 'val' in 'yylval.val' is the field declared in
                           calc1.y with the %union directive. */
[0-9]+\.?[0-9]*|\.[0-9]+ { yylval.val = atof(yytext); return NUM; }
"+"                     { return PLUS; }
"-"                     { return MINUS; }
"*"                     { return MUL; }
"/"                     { return DIV; }
"("                     { return LPAREN; }
")"                     { return RPAREN; }
"="                     { return EQUALS; }
pow|POW                 { return POW; }
mod|MOD                 { return MOD; }
floor|FLOOR             { return FLOOR; }
ceil|CEIL               { return CEIL; }
sqrt|SQRT               { return SQRT; }
abs|ABS                 { return ABS; }
sin|SIN                 { return SIN; }
cos|COS                 { return COS; }
tan|TAN                 { return TAN; }
log2|LOG2               { return LOG2; }
log10|log10             { return LOG10; }
factorial|FACTORIAL     { return FACTORIAL; }
gbp_to_usd|GBP_TO_USD   { return GBP_TO_USD; }
usd_to_gbp|USD_TO_GBP   { return USD_TO_GBP; }
gbp_to_euro|GBP_TO_USD  { return GBP_TO_EURO; }
euro_to_gbp|EURO_TO_GBP { return EURO_TO_GBP; }
usd_to_euro|USD_TO_GBP  { return USD_TO_EURO; }
euro_to_usd|EURO_TO_USD { return EURO_TO_USD; }
cel_to_fah|CEL_TO_FAH   { return CEL_TO_FAH; }
fah_to_cel|FAH_TO_CEL   { return FAH_TO_CEL; }
mi_to_km|MI_TO_KM       { return MI_TO_KM; }
km_to_mi|KM_TO_MI       { return KM_TO_MI; }
pi|PI                   { return PI; }
var|VAR                 { return VAR_KEYWORD; }
[A-Za-z][][A-Za-z0-9.]* { strcpy(yylval.id, yytext); return VARIABLE; }
(\n|\r\n)               { return EOL;}     

[ \r\t]+                { /* Ignore white characters. */ }
.                       { std::cerr << "Invalid token" << std::endl; exit(1); }

%%
