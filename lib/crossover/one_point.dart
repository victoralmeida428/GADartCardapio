import 'dart:math';

import 'package:dart_genetic_algorithm/individual.dart';
import 'package:dart_genetic_algorithm/problem_interfaces.dart';

import 'crossover_abstract.dart';

final Random random = Random();

class OnePointCrossover<T> implements CrossoverAbstract<T> {
  final ProblemCostants cte;

  OnePointCrossover(this.cte);

  @override
  Individual<T> crossover(
    Individual<T> parent1,
    Individual<T> parent2,
    FitnessCalculator<T> fitnessCalculator,
  ) {
    final int crossoverPoint = random.nextInt(cte.geneLength);
    if (T == String) {
      final String genes1 = parent1.genes as String;
      final String genes2 = parent2.genes as String;
      final String childGenes =
          genes1.substring(0, crossoverPoint) +
          genes2.substring(crossoverPoint);
      return Individual<T>(
        genes: childGenes as T,
        fitnessCalculator: fitnessCalculator,
      );
    } else if (T == List<int>) {
      final List<int> genes1 = parent1.genes as List<int>;
      final List<int> genes2 = parent2.genes as List<int>;
      final List<int> childGenes = [
        ...genes1.sublist(0, crossoverPoint),
        ...genes2.sublist(crossoverPoint),
      ];
      return Individual<T>(
        genes: childGenes as T,
        fitnessCalculator: fitnessCalculator,
      );
    }
    return parent1;
  }
}
