import 'problem_interfaces.dart';

class Individual<T> {
  T genes;
  int fitness;
  Individual({
    required this.genes,
    required FitnessCalculator<T> fitnessCalculator,
  })
  : fitness = fitnessCalculator.calculate(genes);
}
