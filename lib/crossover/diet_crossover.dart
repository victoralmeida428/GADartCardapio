import 'dart:math';

import 'package:dart_genetic_algorithm/crossover/crossover_abstract.dart';
import 'package:dart_genetic_algorithm/dto/daily_diet.dart';
import 'package:dart_genetic_algorithm/dto/meal_component.dart';
import 'package:dart_genetic_algorithm/individual.dart';
import 'package:dart_genetic_algorithm/problem_interfaces.dart';



class DietCrossover implements CrossoverAbstract<DailyDiet> {

  final Random _random = Random();
  
  @override
  Individual<DailyDiet> crossover(
    Individual<DailyDiet> parent1,
    Individual<DailyDiet> parent2,
    FitnessCalculator<DailyDiet> fitnessCalculator,
  ) {
    // Acessamos os genes (.genes) dos pais para criar o filho
    final DailyDiet parent1Genes = parent1.genes;
    final DailyDiet parent2Genes = parent2.genes;

    final int childMealCount = _random.nextBool()
        ? parent1Genes.meals.length
        : parent2Genes.meals.length;

    final int crossoverPoint = _random.nextInt(childMealCount);

    final List<List<MealComponent>> childMeals = [];

    for (int i = 0; i < childMealCount; i++) {
      if (i < crossoverPoint) {
        // Antes do ponto de corte, herda do pai 1 (se a refeição existir)
        if (i < parent1Genes.meals.length) {
          childMeals.add(List.from(parent1Genes.meals[i]));
        } else {
          childMeals.add([]); // Adiciona uma refeição vazia se o pai 1 não tiver
        }
      } else {
        // Depois do ponto de corte, herda do pai 2 (se a refeição existir)
        if (i < parent2Genes.meals.length) {
          childMeals.add(List.from(parent2Genes.meals[i]));
        } else {
          childMeals.add([]); // Adiciona uma refeição vazia se o pai 2 não tiver
        }
      }
    }

    final childGenes = DailyDiet.fromMeals(childMeals);

    return Individual<DailyDiet>(
      genes: childGenes,
      fitnessCalculator: fitnessCalculator,
    );
  }
}
