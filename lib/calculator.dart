import 'dart:math';

import 'package:dart_genetic_algorithm/constants.dart';
import 'package:dart_genetic_algorithm/dto/daily_diet.dart';
import 'package:dart_genetic_algorithm/problem_interfaces.dart';

final Random random = Random();

class DietFitnessCalculator implements FitnessCalculator<DailyDiet> {
  final DietConstants constants;
  final double targetMeatPercentage;
  final double targetVegetablePercentage;

  DietFitnessCalculator(this.constants, this.targetMeatPercentage,
      this.targetVegetablePercentage);

  @override
  int calculate(DailyDiet dailyDiet) {
    // Score de 0 a 1 para calorias. 1 é o alvo exato.
    final double targetCalories = constants.targetTotalCalories;
    final double actualCalories = dailyDiet.totalDailyCalories;
    final double calorieDifference = (actualCalories - targetCalories).abs();
    // Normaliza a pontuação de calorias, tornando-a 1 no alvo e 0 no dobro da diferença ou mais.
    final double calorieScore =
        max(0.0, 1.0 - (calorieDifference / targetCalories));

    // Score de 0 a 1 para a composição de carne.
    final double actualMeatPercentage = dailyDiet.meatPercentage;
    final double meatDifference =
        (actualMeatPercentage - targetMeatPercentage).abs();
    final double meatScore = max(0.0, 1.0 - meatDifference);

    // Score de 0 a 1 para a composição de vegetais.
    final double actualVegetablePercentage = dailyDiet.vegetablePercentage;
    final double vegetableDifference =
        (actualVegetablePercentage - targetVegetablePercentage).abs();
    final double vegetableScore = max(0.0, 1.0 - vegetableDifference);

    // O score de composição é a média dos scores de carne e vegetais
    final double compositionScore = (meatScore + vegetableScore) / 2.0;

    // A aptidão final é o produto dos scores.
    // Se qualquer um dos scores for baixo, a aptidão geral será baixa.
    // Isso força o algoritmo a encontrar soluções que são boas em AMBOS os critérios.
    final double fitness = ((calorieScore * 0.1) + (compositionScore * 0.9));

    // Multiplica por 1000 para ter mais granularidade nos inteiros
    return (fitness * 1000).toInt();
  }
}