import 'package:dart_genetic_algorithm/crossover/crossover_abstract.dart';
import 'package:dart_genetic_algorithm/dto/daily_diet.dart';
import 'package:dart_genetic_algorithm/individual.dart';
import 'package:dart_genetic_algorithm/problem_interfaces.dart';



class DietCrossover implements CrossoverAbstract<DailyDiet> {
  @override
  Individual<DailyDiet> crossover(
    Individual<DailyDiet> parent1,
    Individual<DailyDiet> parent2,
    FitnessCalculator<DailyDiet> fitnessCalculator,
  ) {
    // Acessamos os genes (.genes) dos pais para criar o filho
    final DailyDiet parent1Genes = parent1.genes;
    final DailyDiet parent2Genes = parent2.genes;

    final childGenes = DailyDiet();

    childGenes.meals[0] = List.from(parent1Genes.meals[0]);
    childGenes.meals[1] = List.from(parent2Genes.meals[1]);
    childGenes.meals[2] = List.from(parent2Genes.meals[2]);

    // Criamos e retornamos um NOVO Individual com os genes do filho
    return Individual<DailyDiet>(
      genes: childGenes,
      fitnessCalculator: fitnessCalculator,
    );
  }
}
