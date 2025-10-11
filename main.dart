

import 'dart:math';

import 'package:dart_genetic_algorithm/calculator.dart';
import 'package:dart_genetic_algorithm/constants.dart';
import 'package:dart_genetic_algorithm/crossover/diet_crossover.dart';
import 'package:dart_genetic_algorithm/dto/daily_diet.dart';
import 'package:dart_genetic_algorithm/dto/food.dart';
import 'package:dart_genetic_algorithm/dto/meal_component.dart';
import 'package:dart_genetic_algorithm/enum/specie.dart';
import 'package:dart_genetic_algorithm/genetic_algorithm.dart';
import 'package:dart_genetic_algorithm/mutation/diet_mutation.dart';
import 'package:dart_genetic_algorithm/selection/tournament.dart';

main() {
  final cte = DietConstants();
  cte.targetTotalCalories = 100;
  // --- Escolha o tipo de animal aqui ---
  final animalType = SpecieType.DOG; // ou 'cat'

  final double targetMeat;
  final double targetVeg;

  if (animalType == SpecieType.DOG) {
    targetMeat = cte.targetMeatPercentageDog;
    targetVeg = cte.targetVegetablePercentageDog;
    print('--- Gerando Dieta para Cão ---');
  } else {
    targetMeat = cte.targetMeatPercentageCat;
    targetVeg = cte.targetVegetablePercentageCat;
    print('--- Gerando Dieta para Gato ---');
  }
  print(
      'Alvo: ${targetMeat * 100}% carne, ${targetVeg * 100}% vegetais, ~${cte.targetTotalCalories} kCal');

  final fitness = DietFitnessCalculator(cte, targetMeat, targetVeg);
  
  final selectionStrategy = Tournament<DailyDiet>();
  final crossoverStrategy = DietCrossover();
  final mutationStrategy = DietMutation(cte);

  DailyDiet generateRandomGene() {
    final diet = DailyDiet.randomMeals();

    // Itera sobre cada uma das 3 refeições da dieta
    for (int i = 0; i < diet.meals.length; i++) {
      // Define um número aleatório de ingredientes para esta refeição (ex: de 2 a 4)
      final numberOfComponents = random.nextInt(3) + 2;

      // Cria uma cópia da lista de alimentos disponíveis para esta refeição específica
      final availableFoodsForMeal = List<FoodItem>.from(cte.availableFoodItems);

      // Garante que não vamos tentar adicionar mais componentes do que os alimentos únicos disponíveis
      final maxComponents =
          min(numberOfComponents, availableFoodsForMeal.length);

      for (int j = 0; j < maxComponents; j++) {
        // Se a lista de alimentos disponíveis para a refeição esvaziar, paramos
        if (availableFoodsForMeal.isEmpty) break;

        // 1. Escolhe um item alimentar aleatório da lista de disponíveis
        final foodIndex = random.nextInt(availableFoodsForMeal.length);
        // 2. Remove o item escolhido da lista para não ser selecionado novamente nesta refeição
        final randomFoodItem = availableFoodsForMeal.removeAt(foodIndex);

        // 3. Define uma quantidade aleatória
        final randomQuantity = random.nextDouble() * 8.95 + 0.05;

        // 4. Cria o componente e o adiciona à refeição
        final component = MealComponent(randomFoodItem, randomQuantity);
        diet.meals[i].add(component);
      }
    }
    return diet;
  }

  final ga = GeneticAlgorithm<DailyDiet>(
    constants: cte,
    crossover: crossoverStrategy,
    mutation: mutationStrategy,
    selection: selectionStrategy,
    fitnessCalculator: fitness,
  );

  ga.initializePopulation(generateRandomGene);
  ga.run();
}
