import 'dart:math';
import 'package:dart_genetic_algorithm/constants.dart';
import 'package:dart_genetic_algorithm/dto/daily_diet.dart';
import 'package:dart_genetic_algorithm/dto/meal_component.dart';
import 'package:dart_genetic_algorithm/individual.dart';
import 'package:dart_genetic_algorithm/mutation/mutation_abstract.dart';
import 'package:dart_genetic_algorithm/problem_interfaces.dart';

class DietMutation implements MutationAbstract<DailyDiet> {
  final DietConstants constants;
  final Random random = Random();

  DietMutation(this.constants);

  @override
  void mutate(
    Individual<DailyDiet> individual,
    FitnessCalculator<DailyDiet> fitnessCalculator,
  ) {
    if (random.nextDouble() < constants.mutationRate) {
      final DailyDiet dietGenes = individual.genes;

      final mutationType = random.nextInt(3);
      final mealIndex = random.nextInt(dietGenes.meals.length);
      final meal = dietGenes.meals[mealIndex];

      switch (mutationType) {
        case 0: // Mudar a quantidade de um item existente (não cria duplicatas)
          if (meal.isEmpty) break;
          final componentIndex = random.nextInt(meal.length);
          final changeFactor = (random.nextDouble() * 0.5) - 0.25;
          final newQuantity =
              meal[componentIndex].quantityOunces * (1 + changeFactor);
          meal[componentIndex].quantityOunces = max(0.05, newQuantity);
          if (meal[componentIndex].quantityOunces < 0) {
            meal[componentIndex].quantityOunces = 1;
          }
          break;

        case 1: // Trocar um item por outro, garantindo que não crie duplicatas
          if (meal.isEmpty) break;

          final componentIndex = random.nextInt(meal.length);
          final currentComponent = meal[componentIndex];

          // Pega os nomes dos OUTROS alimentos na refeição
          final otherFoodNamesInMeal = meal
              .where((c) => c.foodItem.name != currentComponent.foodItem.name)
              .map((c) => c.foodItem.name)
              .toSet();

          // Filtra a lista de alimentos disponíveis para encontrar os que não estão na refeição
          final availableToSwap = constants.availableFoodItems
              .where((food) => !otherFoodNamesInMeal.contains(food.name))
              .toList();

          if (availableToSwap.isNotEmpty) {
            final newItem =
                availableToSwap[random.nextInt(availableToSwap.length)];
            // Substitui o item antigo pelo novo, mantendo a quantidade
            meal[componentIndex] =
                MealComponent(newItem, currentComponent.quantityOunces);
          }
          break;

        case 2: // Adicionar um novo item à refeição, garantindo que não seja repetido
          // Pega os nomes de todos os alimentos já presentes na refeição
          final existingFoodNames = meal.map((c) => c.foodItem.name).toSet();

          // Filtra a lista geral para encontrar alimentos que ainda não estão na refeição
          final availableToAdd = constants.availableFoodItems
              .where((food) => !existingFoodNames.contains(food.name))
              .toList();

          // Se houver alimentos disponíveis para adicionar, adiciona um
          if (availableToAdd.isNotEmpty) {
            final newItem =
                availableToAdd[random.nextInt(availableToAdd.length)];
            final newQuantity = random.nextDouble() * 5 + 0.05;
            meal.add(MealComponent(newItem, newQuantity));
          }
          break;
      }
    }

    individual.fitness = fitnessCalculator.calculate(individual.genes);
  }
}
