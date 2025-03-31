/*6) Crie um Set de strings que representa os nomes de alunos em uma turma. 
1. Adicione através do input, três nomes ao conjunto. 
2. Tente adicionar um nome que já existe no conjunto e imprima o conjunto após essa tentativa. 
3. Remova um nome do conjunto. 
4. Verifique se um nome específico está presente no conjunto e imprima o resultado. */
import 'dart:io';

void main() {
  Set<String> alunos = {};

  for (int i = 0; i < 3; i++) {
    print('Digite o nome do aluno ${i + 1}: ');
    String? nome = stdin.readLineSync();

    if (nome != null && nome.isNotEmpty) {
      if (alunos.contains(nome)) {
        print('O nome "$nome" já existe no conjunto. Tente outro nome.');
        i--;
      } else {
        alunos.add(nome);
      }
    } else {
      print('Nome inválido, tente novamente.');
      i--;
    }
  }

  print('Conjunto de alunos: $alunos');

  print('Digite o nome do aluno que deseja remover: ');
  String? nomeRemover = stdin.readLineSync();
  if (nomeRemover != null) {
    alunos.remove(nomeRemover);
  }

  print('Digite o nome do aluno que deseja verificar se está presente: ');
  String? nomeVerificar = stdin.readLineSync();
  if (nomeVerificar != null) {
    bool presente = alunos.contains(nomeVerificar);
    print('O aluno $nomeVerificar está presente no conjunto: $presente');
  }
}