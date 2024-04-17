package compilador;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;

public class Main {

	static BufferedReader scan = new BufferedReader(new InputStreamReader(System.in));
	static int numLinha = 1, count;
	static boolean erro = false;
	static String[] linha;

	public static void main(String[] args) throws IOException {
		HashMap<String, Tag> reserved = iniciarLista();

		do {
			linha = scan.readLine().split("[ \t]");

			for (count = 0; count < linha.length; count++) {
				String atual = linha[count];

				if (atual.isBlank())
					continue;

				if (reserved.containsKey(atual)) {
					System.out.println("Linha " + numLinha + ": " + reserved.get(atual));
				} else {
					erro = erroLexico(atual);
				}
			}

			numLinha++;
		} while (scan.ready() && !erro);

		scan.close();
	}

	private static boolean erroLexico(String atual) throws IOException {

		if (atual.matches("[0-9]+")) {
			System.out.println("Linha " + numLinha + ": " + Tag.T_NUMERO + " - '" + atual + "'");
			return false;
		}

		if (atual.matches("[a-zA-Z][a-zA-Z0-9]*")) {
			System.out.println("Linha " + numLinha + ": " + Tag.T_IDENTIF + " - " + atual);
			return false;
		}

		if (atual.matches("//.*")) {
			System.out.println("Linha " + numLinha + ": " + Tag.T_COMENTLINHA);
			count = linha.length;
			return false;
		}

		if (atual.matches("/\\*.*")) {

			int inicio = numLinha;

			while (!atual.matches("(/\\*)?([^\\*]|(\\*[^/]))*\\*/.*") && !erro) {

				if (count + 1 >= linha.length) {
					if (scan.ready()) {
						linha = scan.readLine().split("[ \t]");
						numLinha++;
						count = 0;
						if (linha.length != 0) {
							atual = linha[count];
						}
					} else
						erro = true;
				} else {
					atual = linha[++count];
				}

			}

			if (erro == false) {
				System.out.println("Linhas " + inicio + "-" + numLinha + ": " + Tag.T_COMENTARIO);
				linha[count--] = atual.substring(atual.indexOf("*/") + 2);
			} else {
				System.out.println("ERRO LEXICO");
			}

			return erro;

		}

		count = linha.length;
		System.out.println("ERRO LEXICO");
		return true;
	}

	private static HashMap<String, Tag> iniciarLista() {
		HashMap<String, Tag> l = new HashMap<String, Tag>();

		l.put("programa", Tag.T_PROGRAMA);
		l.put("inicio", Tag.T_INICIO);
		l.put("fimprograma", Tag.T_FIM);

		l.put("leia", Tag.T_LEIA);
		l.put("escreva", Tag.T_ESCREVA);

		l.put("se", Tag.T_SE);
		l.put("entao", Tag.T_ENTAO);
		l.put("senao", Tag.T_SENAO);
		l.put("fimse", Tag.T_FIMSE);

		l.put("enquanto", Tag.T_ENQTO);
		l.put("faca", Tag.T_FACA);
		l.put("fimenquanto", Tag.T_FIMENQTO);

		l.put("+", Tag.T_MAIS);
		l.put("-", Tag.T_MENOS);
		l.put("*", Tag.T_VEZES);
		l.put("div", Tag.T_DIV);

		l.put(">", Tag.T_MAIOR);
		l.put("<", Tag.T_MENOR);
		l.put("=", Tag.T_IGUAL);

		l.put("e", Tag.T_E);
		l.put("ou", Tag.T_OU);
		l.put("nao", Tag.T_NAO);

		l.put("<-", Tag.T_ATRIB);
		l.put("(", Tag.T_ABRE);
		l.put(")", Tag.T_FECHA);

		l.put("inteiro", Tag.T_INTEIRO);
		l.put("logico", Tag.T_LOGICO);
		l.put("V", Tag.T_V);
		l.put("F", Tag.T_F);

		return l;
	}

}
