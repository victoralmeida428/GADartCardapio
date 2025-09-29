import 'dart:math';

import 'package:dart_genetic_algorithm/individual.dart';


final Random random = Random();

abstract class SelectionAbstract<T> {
  Individual<T>  selectParent(List<Individual<T>> population);
}