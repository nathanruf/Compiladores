%{
	#include <stdio.h>
	int yylex(void);
	void yyerror(char *);
%}

%token T_PROGRAMA T_LOGICO T_INTEIRO T_LEIA T_ESCREVA T_IDENTIF T_INICIO		
T_FIM T_ENQTO T_FACA T_FIMENQTO T_SE T_SENAO T_FIMSE T_ENTAO T_ATRIB
T_VEZES T_DIV T_MAIS T_MENOS T_MAIOR T_MENOR T_IGUAL T_OU T_E T_NUMERO
T_V T_F T_NAO T_ABRE T_FECHA

%%
programa : cabecalho variaveis T_INICIO lista_comandos T_FIM
cabecalho : T_PROGRAMA T_IDENTIF
variaveis : ;
	|	declaracao_variaveis
declaracao_variaveis : tipos	lista_variaveis	declaracao_variaveis
	|	tipos	lista_variaveis
tipos : T_LOGICO
	|	T_INTEIRO
lista_variaveis : T_IDENTIF lista_variaveis
	|	T_IDENTIF
lista_comandos : comando lista_comandos
	|	;
comando : entrada_saida
	|	repeticao
	|	selecao
	|	atribuicao
entrada_saida : leitura | escrita
leitura : T_LEIA	T_IDENTIF
escrita : T_ESCREVA expressao
repeticao : T_ENQTO expressao T_FACA
	lista_comandos	T_FIMENQTO
selecao : T_SE expressao T_ENTAO lista_comandos
	T_SENAO	lista_comandos	T_FIMSE
atribuicao : T_IDENTIF T_ATRIB expressao
expressao : expressao T_VEZES expressao
	|	expressao T_DIV expressao
	|	expressao T_MAIS expressao
	|	expressao T_MENOS expressao
	|	expressao T_MAIOR expressao
	|	expressao T_MENOR expressao
	|	expressao T_IGUAL expressao
	|	expressao T_E expressao
	|	expressao T_OU expressao
	|	termo
termo : T_IDENTIF
	|	T_NUMERO
	|	T_V
	|	T_F
	|	T_NAO termo
	|	T_ABRE expressao T_FECHA
%%

extern int yylex();
extern int yyparse();
extern FILE *yyin;

void yyerror(char *s){
	printf("\033[0;31m%s\n", s);
}

int main(int argc, char *argv[]) {
	FILE *aux = fopen(argv[1], "r");
	yyin = aux;
	do{
		yyparse();
	}while(!feof(yyin));
	fclose(yyin);
	return 0;
}