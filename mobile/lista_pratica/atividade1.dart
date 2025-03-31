/*1) Faça um programa que recebe um número e verifique qual mês 
aquele número se refere.
Exemplo: 1-Janeiro, 2-Fevereiro… Utilize switch case e, 
caso o número inserido seja inválido,
exiba uma mensagem dizendo “número inválido, deve ser de 1 a 12”.*/

import 'dart:io';

enum MesesDoAno{
  Janeiro,
  Fevereiro,
  Marco,
  Abril,
  Maio,
  Junho,
  Julho,
  Agosto,
  Setembro,
  Outubro,
  Novembro,
  Dezembro
}
void main() {
  print('Digite o número do mês: ');
  int mes = int.parse(stdin.readLineSync()!);

  String calendario = switch(mes){
    == 1 => 'Janeiro',
    == 2 => 'Fevereiro',
    == 3 => 'Março',
    == 4 => 'Abril',
    == 5 => 'Maio',
    == 6 => 'Junho',
    == 7 => 'Julho',
    == 8 => 'Agosto',
    == 9 => 'Setembro',
    == 10 => 'Outubro',
    == 11 => 'Novembro',
    == 12 => 'Dezembro',
    _ => 'Mês inválido',
  };

  print('O mês é: $calendario');
}


