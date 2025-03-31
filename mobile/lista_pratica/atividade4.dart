/*4) Implemente uma função de soma que receba 
4 argumentos nomeados. Os argumentos nomeados 
devem ser obrigatórios. Teste trocar a ordem dos argumentos 
nomeados no momento de passar os valores para a função 
(exemplo: d:4, b:3, a:5, c:7). */

import 'dart:io';

void main() {
  Map<String, int> valores = {};
  List<String> letrasValidas = ['a', 'b', 'c', 'd'];

  print("Digite uma letra (a, b, c, d) e o valor correspondente:");
  while (valores.length < 4) {
    stdout.write("Letra: ");
    String letra = stdin.readLineSync()!.toLowerCase();

    if (!letrasValidas.contains(letra)) {
      print("Letra inválida! Digite apenas a, b, c ou d.");
      continue;
    }

    if (valores.containsKey(letra)) {
      print("Letra já foi usada! Escolha outra.");
      continue;
    }

    stdout.write("Valor: ");
    int valor = int.parse(stdin.readLineSync()!);
    valores[letra] = valor;
  }

  print(soma(
    a: valores['a'] ?? 0,
    b: valores['b'] ?? 0,
    c: valores['c'] ?? 0,
    d: valores['d'] ?? 0,
  ));
}

int soma({required int a, required int b, required int c, required int d}) {
  return a + b + c + d;
}