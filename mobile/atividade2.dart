/*2) Crie uma variável inteira que receba um número aleatório. 
Utilize um ternário para verificar se esse número é par ou 
ímpar e printe o resultado.
 */

import 'dart:io';

void main(){
  print('Digite um número inteiro: ');
  int numeroInteiro = int.parse(stdin.readLineSync()!);

  String resultado = numeroInteiro % 2 == 0 ? 'O número é par' : 'O número é ímpar';
  print(resultado);
}