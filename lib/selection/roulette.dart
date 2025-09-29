import 'dart:math';

import 'package:dart_genetic_algorithm/individual.dart';

import 'selection_abstract.dart';

final _random = Random();

class Roulette<T> implements SelectionAbstract<T> {
  @override
  Individual<T> selectParent(List<Individual<T>> population) {
    final totalFitness = population.fold(
      0,
      (sum, individual) => sum + individual.fitness,
    );
    double randomPoint = random.nextDouble() * totalFitness;
    for (final individual in population) {
      randomPoint -= individual.fitness;
      if (randomPoint <= 0) {
        return individual;
      }
    }
    return population.last;
  }
  
  @override
  List<Individual<T>> select(List<Individual<T>> population, int count) {
    if (population.isEmpty) {
      throw ArgumentError('A população não pode estar vazia.');
    }
    if (count <= 0) {
      return [];
    }

    // 1. Calcula a soma total do fitness da população (apenas uma vez).
    final totalFitness = population.fold<double>(
      0.0,
      (sum, individual) => sum + individual.fitness,
    );

    // Caso especial: se todos os fitness são 0, não é possível usar a roleta.
    // Nesse caso, selecionamos de forma puramente aleatória.
    if (totalFitness == 0.0) {
      final List<Individual<T>> selected = [];
      for (int i = 0; i < count; i++) {
        selected.add(population[_random.nextInt(population.length)]);
      }
      return selected;
    }

    final List<Individual<T>> selectedIndividuals = [];

    // 2. Repete o processo de seleção 'count' vezes.
    for (int i = 0; i < count; i++) {
      // Gera um ponto aleatório na "roleta" para cada seleção.
      double randomPoint = _random.nextDouble() * totalFitness;

      // 3. Percorre a população até encontrar o indivíduo selecionado.
      for (final individual in population) {
        randomPoint -= individual.fitness;
        if (randomPoint <= 0) {
          selectedIndividuals.add(individual);
          break; // Para o loop interno e começa a próxima seleção.
        }
      }
    }
    return selectedIndividuals;
  }
}
