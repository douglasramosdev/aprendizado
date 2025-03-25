/* 3) Implemente uma função de multiplicação que receba 
apenas 2 argumentos posicionados.*/

import 'dart:io';

void main() {
  print('Digite dois números inteiros: ');
  int x = int.parse(stdin.readLineSync()!);
  int y = int.parse(stdin.readLineSync()!);
  int resultado = funcaoMultiplicacao(x, y);
  print('O resultado da multiplicação é: $resultado');
}
int funcaoMultiplicacao(int x, int y) {
  int resultado = x * y;
  return resultado;
}
