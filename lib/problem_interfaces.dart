abstract class ProblemCostants {
  String get target;
  int get populationSize;
  int get generations;
  double get mutationRate;
  int get geneLength;
}

abstract class FitnessCalculator<T> {
  int calculate(T genes);
}
