import 'package:dart_genetic_algorithm/dto/meal_component.dart';
import 'package:dart_genetic_algorithm/enum/food.dart';

class DailyDiet {
  // Uma dieta consiste em 3 refeições, cada uma com uma lista de componentes
  final List<List<MealComponent>> meals = [[], [], []];

  double get _totalMeatCal {
    double weight = 0.0;
    for (final meal in meals) {
      for (final component in meal) {
        if (component.foodItem.type != FoodType.VEGETABLE) {
          weight += component.totalCalories;
        }
      }
    }
    return weight;
  }

  double get _totalVegetableCal {
    double weight = 0.0;
    for (final meal in meals) {
      for (final component in meal) {
        if (component.foodItem.type == FoodType.VEGETABLE) {
          weight += component.totalCalories;
        }
      }
    }
    return weight;
  }

  double get totalWeight {
    double weight = 0.0;
    for (final meal in meals) {
      for (final component in meal) {
        weight += component.quantityOunces;
      }
    }
    return weight;
  }

  // --- Getters Públicos de Porcentagem ---

  double get meatPercentage {
    final total = totalDailyCalories;
    if (total == 0) return 0.0;
    return _totalMeatCal / total;
  }

  double get vegetablePercentage {
    final total = totalDailyCalories;
    if (total == 0) return 0.0;
    return _totalVegetableCal / total;
  }

  // --- Cálculo de Calorias (sem alteração) ---
  double get totalDailyCalories {
    return meals.fold(0.0, (sum, meal) {
      return sum +
          meal.fold(
              0.0, (mealSum, component) => mealSum + component.totalCalories);
    });
  }

  // --- Método toString() Aprimorado para Depuração ---
  @override
  String toString() {
    final buffer = StringBuffer();
    final calories = totalDailyCalories;
    final meat = meatPercentage * 100;
    final vegs = vegetablePercentage * 100;

    // Adiciona o totalizador de depuração na linha de cabeçalho
    buffer.writeln(
        'Dieta com ${calories.toStringAsFixed(2)} kCal (${meat.toStringAsFixed(2)}% carne, ${vegs.toStringAsFixed(2)}% vegetais)');

    for (int i = 0; i < meals.length; i++) {
      buffer.writeln('  -> Refeição ${i + 1}:');
      final meal = meals[i];

      if (meal.isEmpty) {
        buffer.writeln('    - (Vazia)');
      } else {
        for (final component in meal) {
          final foodName = component.foodItem.name;
          final quantity = component.gram.toStringAsFixed(2);
          // Adiciona um indicador de tipo [M]eat ou [V]egetable
          final type = component.foodItem.type;
          buffer.writeln(
              '    - $foodName ($quantity g) [$type] => ${component.totalCalories.toStringAsFixed(2)} kCal');
        }
      }
    }
    return buffer.toString();
  }
}
