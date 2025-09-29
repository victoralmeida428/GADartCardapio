import 'dart:math';

import 'package:dart_genetic_algorithm/individual.dart';
import 'package:dart_genetic_algorithm/problem_interfaces.dart';


final Random random = Random();

abstract class MutationAbstract<T> {
  void mutate(Individual<T> individual, FitnessCalculator<T> fitnessCalculator);
}

class RandomMutation<T> implements MutationAbstract<T> {
  final ProblemCostants constants;

  RandomMutation(this.constants);

  @override
  void mutate(
    Individual<T> individual,
    FitnessCalculator<T> fitnessCalculator,
  ) {
    if (random.nextDouble() < constants.mutationRate) {
      if (T == String) {
        final String genes = individual.genes as String;
        final int geneIndex = random.nextInt(constants.geneLength);
        final int charCode = random.nextInt(95) + 32;

        final List<String> geneList = genes.split('');
        geneList[geneIndex] = String.fromCharCode(charCode);
        individual.genes = geneList.join('') as T;
      } else if (T == List<int>) {
        final List<int> genes = individual.genes as List<int>;
        final int geneIndex = random.nextInt(constants.geneLength);
        final int newValue = 1 - genes[geneIndex];
        genes[geneIndex] = newValue;
        individual.genes = genes as T;
      }
    }

    // Recalcula a aptidão após a mutação
    individual.fitness = fitnessCalculator.calculate(individual.genes);
  }
}
