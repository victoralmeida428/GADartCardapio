import 'package:dart_genetic_algorithm/individual.dart';

import 'selection_abstract.dart';

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
}
