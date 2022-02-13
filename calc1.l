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
"pow"                   { return POW; }
"mod"                   { return MOD; }
"floor"                 { return FLOOR; }
"ceil"                  { return CEIL; }
"abs"                   { return ABS; }
"sin"                   { return SIN; }
"cos"                   { return COS; }
"tan"                   { return TAN; }
[ \t\r\n]+              { /* Ignore white characters. */ }
.                       { std::cerr << "Invalid token" << std::endl; exit(1); }

%%
