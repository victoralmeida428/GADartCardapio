import 'package:dart_genetic_algorithm/crossover/crossover_abstract.dart';
import 'package:dart_genetic_algorithm/individual.dart';
import 'package:dart_genetic_algorithm/mutation/mutation_abstract.dart';
import 'package:dart_genetic_algorithm/problem_interfaces.dart';
import 'package:dart_genetic_algorithm/selection/selection_abstract.dart';

class GeneticAlgorithm<T> {
  List<Individual<T>> population = [];
  final ProblemCostants _cte;
  final CrossoverAbstract<T> _crossover;
  final MutationAbstract<T> _mutation;
  final SelectionAbstract<T> _selection;
  final FitnessCalculator<T> _fitnessCalculator;

  GeneticAlgorithm({
    required ProblemCostants constants,
    required CrossoverAbstract<T> crossover,
    required MutationAbstract<T> mutation,
    required SelectionAbstract<T> selection,
    required FitnessCalculator<T> fitnessCalculator,
  })  : _cte = constants,
        _crossover = crossover,
        _mutation = mutation,
        _selection = selection,
        _fitnessCalculator = fitnessCalculator;

  void initializePopulation(T Function() generateRandomGene) {
    for (int i = 0; i < _cte.populationSize; i++) {
      population.add(
        Individual<T>(
          genes: generateRandomGene(),
          fitnessCalculator: _fitnessCalculator,
        ),
      );
    }
  }

  void run() {
    Individual<T>? overallBestIndividual;

    for (int i = 0; i < _cte.generations; i++) {
      final bestOfCurrentGeneration = population.reduce(
        (a, b) => a.fitness > b.fitness ? a : b,
      );

      if (overallBestIndividual == null ||
          bestOfCurrentGeneration.fitness > overallBestIndividual.fitness) {
        overallBestIndividual = bestOfCurrentGeneration;
      }

      final List<Individual<T>> newPopulation = [];

      // ... (O resto da lógica do loop permanece o mesmo)
      for (int j = 0; j < _cte.populationSize; j++) {
        final parent1 = _selection.selectParent(population);
        final parent2 = _selection.selectParent(population);

        final child = _crossover.crossover(
          parent1,
          parent2,
          _fitnessCalculator,
        );

        _mutation.mutate(child, _fitnessCalculator);
        newPopulation.add(child);
      }
      population = newPopulation;
    }
    final double score = (overallBestIndividual?.fitness.toDouble() ?? 0) / 1000.0;
    print('Melhor Dieta -> (Score: ${score.toStringAsFixed(4)})');
    print(overallBestIndividual?.genes); // Isso chamará o toString() aprimorado
  }
}
