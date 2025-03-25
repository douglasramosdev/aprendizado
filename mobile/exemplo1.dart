import 'dart:math';
import 'dart:io';

enum setList {
  EnterSandman,
  SadButTrue,
  TheUnforgiven,
  WhereverIMayRoam,
  NothingElseMatters,
  TheDayThatNeverComes,
  MasterOfPuppets,
  One,
  FadeToBlack,
  SeekAndDestroy,
  Battery,
  CreepingDeath,
  RideTheLightning,
  ForWhomTheBellTolls,
  Blackened,
  Papercut,
  Crawling,
  InTheEnd,
  Numb,
  BreakingTheHabit,
  NewDivide,
  WhatIveDone,
  Faint,
  SomewhereIBelong
}

void main() {
  int indice = int.parse(stdin.readLineSync()!);
  int faixa = indice;

  setList musica = setList.values.elementAt(indice);

  print('Nome da música: $musica.name');
  print("Número da faixa: $faixa");

  var banda = faixa <= 15 ? 'Metallica' : 'Linkin Park';
  print('Banda: $banda');

  var album = switch (musica.index){
    < 5 => 'Metallica (1991)',
    < 9 => 'Garage Inc (1998)',
    < 14 => 'Master of Puppets (1986)',
    < 18 => 'Hybrid Theory (2000)',
    _ => 'Minutes to Midnight (2007)',
  };
  print('Álbum: $album');
}