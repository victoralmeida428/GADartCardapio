

import 'package:dart_genetic_algorithm/individual.dart';
import 'package:dart_genetic_algorithm/problem_interfaces.dart';

abstract class CrossoverAbstract<T> {
  Individual<T> crossover(Individual<T> parent1, Individual<T> parent2, FitnessCalculator<T> fitnessCalculator);
}
