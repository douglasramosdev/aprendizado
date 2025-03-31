/*5) Crie uma lista de números inteiros e implemente as seguintes funcionalidades: 
1. Adicione cinco números à lista. 
2. Remova um número específi co da lista. 
3. Imprima a lista ordenada em ordem crescente. Use o método sort para ordenar. 
4. Calcule e imprima a soma de todos os números na lista. */
import 'dart:io';

void main() {
  List<int> numeros = [];


  for (int i = 0; i < 5; i++) {
    print('Digite um número inteiro: ');
    int numero = int.parse(stdin.readLineSync()!);
    numeros.add(numero);
  }


  print('Digite o número que deseja remover: ');
  int numeroRemover = int.parse(stdin.readLineSync()!);
  numeros.remove(numeroRemover);


  numeros.sort();
  print('Lista ordenada: $numeros');

  
  int soma = numeros.reduce((a, b) => a + b);
  print('Soma dos números na lista: $soma');
}
