%{
	#include "y.tab.h"

%}

identificador [a-zA-Z]([a-zA-Z0-9])*
numero [0-9]+
espaco [ \t]+
novalinha (\r\n)|\n

%%

programa printf("%s: T_PROGRAMA\n", yytext); return T_PROGRAMA;
inicio printf("%s: T_INICIO\n", yytext); return T_INICIO;
fimprograma printf("%s: T_FIM\n", yytext); return T_FIM;

leia printf("%s: T_LEIA\n", yytext); return T_LEIA;
escreva printf("%s: T_ESCREVA\n", yytext); return T_ESCREVA;

se printf("%s: T_SE\n", yytext); return T_SE;
entao printf("%s: T_ENTAO\n", yytext); return T_ENTAO;
senao printf("%s: T_SENAO\n", yytext); return T_SENAO;
fimse printf("%s: T_FIMSE\n", yytext); return T_FIMSE;

enquanto printf("%s: T_ENQTO\n", yytext); return T_ENQTO;
faca printf("%s: T_FACA\n", yytext); return T_FACA;
fimenquanto printf("%s: T_FIMENQTO\n", yytext); return T_FIMENQTO;

"+" printf("%s: T_MAIS\n", yytext); return T_MAIS;
"-" printf("%s: T_MENOS\n", yytext); return T_MENOS;
"*" printf("%s: T_VEZES\n", yytext); return T_VEZES;
div printf("%s: T_DIV\n", yytext); return T_DIV;

">" printf("%s: T_MAIOR\n", yytext); return T_MAIOR;
"<" printf("%s: T_MENOR\n", yytext); return T_MENOR;
"=" printf("%s: T_IGUAL\n", yytext); return T_IGUAL;

e printf("%s: T_E\n", yytext); return T_E;
ou printf("%s: T_OU\n", yytext); return T_OU;
nao printf("%s: T_NAO\n", yytext); return T_NAO;

"<-" printf("%s: T_ATRIB\n", yytext); return T_ATRIB;
"(" printf("%s: T_ABRE\n", yytext); return T_ABRE;
")" printf("%s: T_FECHA\n", yytext); return T_FECHA;

inteiro printf("%s: T_INTEIRO\n", yytext); return T_INTEIRO;
logico printf("%s: T_LOGICO\n", yytext); return T_LOGICO;
V printf("%s: T_V\n", yytext); return T_V;
F printf("%s: T_F\n", yytext); return T_F;

"//".* printf("%s: T_COMENTLINHA\n", yytext);
"/*"([^"*"]|("*"[^"/"]))*"*/" printf("%s: T_COMENTARIO\n", yytext);

{identificador} printf("%s: T_IDENTIF\n", yytext); return T_IDENTIF;
{numero} printf("%s: T_NUMERO\n", yytext); return T_NUMERO;
{espaco}
{novalinha}
. printf("%s: ERRO LEXICO\n", yytext);

%%

int yywrap(void) { return 1; }