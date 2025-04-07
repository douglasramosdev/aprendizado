/*7) Crie um Map que armazena a relação entre nomes de alunos e suas notas. 
1. Adicione três pares de nome e nota ao mapa. 
2. Atualize a nota de um aluno específico. 
3. Imprima todos os alunos e suas notas. Use um foreach. 
4. Calcule e imprima a média das notas dos alunos.*/
//as notas tem que ser de 0.0 à 10.0
//as notas devem ser adicionadas pelo usuário
//os alunos não podem ter o mesmo nome

import 'dart:io';

void main() {
  Map<String, double> alunosNotas = {};

  for (int i = 0; i < 3; i++) {
    print('Digite o nome do aluno ${i + 1}: ');
    String? nome = stdin.readLineSync();

    if (nome != null && nome.isNotEmpty) {
      if (alunosNotas.containsKey(nome)) {
        print('O nome "$nome" já existe no mapa. Tente outro nome.');
        i--;
      } else {
        print('Digite a nota do aluno $nome: ');
        String? notaStr = stdin.readLineSync();
        double? nota = double.tryParse(notaStr!);

        if (nota != null && nota >= 0.0 && nota <= 10.0) {
          alunosNotas[nome] = nota;
        } else {
          print('Nota inválida, tente novamente.');
          i--;
        }
      }
    } else {
      print('Nome inválido, tente novamente.');
      i--;
    }
  }


  while (true) {
    print('Digite o nome do aluno cuja nota deseja atualizar: ');
    String? nomeAtualizar = stdin.readLineSync();

    if (nomeAtualizar != null && alunosNotas.containsKey(nomeAtualizar)) {
      print('Digite a nova nota para $nomeAtualizar: ');
      String? novaNotaStr = stdin.readLineSync();
      double? novaNota = double.tryParse(novaNotaStr!);

      if (novaNota != null && novaNota >= 0.0 && novaNota <= 10.0) {
        alunosNotas[nomeAtualizar] = novaNota;
        break;
      } else {
        print('Nota inválida, tente novamente.');
      }
    } else {
      print('Aluno não encontrado ou nome inválido, tente novamente.');
    }
  }

  print('Digite o nome do aluno cuja nota deseja atualizar: ');
  String? nomeAtualizar = stdin.readLineSync();
  if (nomeAtualizar != null && alunosNotas.containsKey(nomeAtualizar)) {
    print('Digite a nova nota para $nomeAtualizar: ');
    String? novaNotaStr = stdin.readLineSync();
    double? novaNota = double.tryParse(novaNotaStr!);

    if (novaNota != null && novaNota >= 0.0 && novaNota <= 10.0) {
      alunosNotas[nomeAtualizar] = novaNota;
    } else {
      print('Nota inválida, não foi possível atualizar.');
    }
  } else {
    print('Aluno não encontrado ou nome inválido.');
  }

  print('\nAlunos e suas notas:');
  alunosNotas.forEach((nome, nota) {
    print('$nome: $nota');
  });

  double somaNotas = alunosNotas.values.reduce((a, b) => a + b);
  double mediaNotas = somaNotas / alunosNotas.length;
  print('\nMédia das notas: $mediaNotas'); 
}

