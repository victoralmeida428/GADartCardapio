
import 'package:dart_genetic_algorithm/dto/food.dart';
import 'package:dart_genetic_algorithm/enum/food.dart';
import 'package:dart_genetic_algorithm/problem_interfaces.dart';

class DietConstants implements ProblemCostants {

  // --- Parâmetros Padrão do Algoritmo Genético ---
  
  @override
  int get populationSize => 1000; // Aumentado para maior diversidade inicial

  @override
  int get generations => 200; // Aumentado para mais iterações de otimização

  @override
  double get mutationRate => 0.02; // Taxa de mutação mais alta para exploração

  @override
  int get geneLength => 0; // Não aplicável, pois não usamos uma lista de bits de tamanho fixo

  @override
  String get target => 'Dieta com aproximadamente 1500 kCal';

  // --- Parâmetros Específicos do Problema da Dieta ---

  // Alvo total de calorias para o dia
  double targetTotalCalories = 1200.0;

  // --- Alvos de Composição ---
  // Para cães
  double get targetMeatPercentageDog => 0.75;
  double get targetVegetablePercentageDog => 0.25;

  // Para gatos
  double get targetMeatPercentageCat => 0.88;
  double get targetVegetablePercentageCat => 0.12;

  final List<FoodItem> availableFoodItems = [
  // Valores representam as calorias por onça (oz) para cada alimento cru.

  // --- Carnes Musculares ---
  FoodItem('Carne Bovina (Patinho)', 38.0, FoodType.MUSCLE_MEAT),
  FoodItem('Peito de Frango sem Pele', 31.4, FoodType.MUSCLE_MEAT),
  FoodItem('Sobrecoxa de Frango c/ Pele', 49.9, FoodType.MUSCLE_MEAT),
  FoodItem('Sobrecoxa de Frango s/ Pele', 39.7, FoodType.MUSCLE_MEAT),
  FoodItem('Moela de Frango', 26.8, FoodType.MUSCLE_MEAT),
  FoodItem('Sardinha em Água', 59.4, FoodType.MUSCLE_MEAT),

  // --- Vísceras / Órgãos ---
  FoodItem('Fígado de Boi', 38.6, FoodType.ORGAN),
  FoodItem('Coração de Galinha', 43.7, FoodType.ORGAN),
  FoodItem('Rim de Boi', 38.3, FoodType.ORGAN),

  // --- Ossos Carnudos ---
  FoodItem('Pescoço de Frango', 62.8, FoodType.BONE),
  FoodItem('Dorso de Frango', 60.3, FoodType.BONE),

  // --- Vegetais ---
  FoodItem('Batata-Doce', 24.6, FoodType.VEGETABLE),
  FoodItem('Brócolis', 9.7, FoodType.VEGETABLE),
  FoodItem('Cenoura', 11.7, FoodType.VEGETABLE),
  FoodItem('Abóbora', 7.4, FoodType.VEGETABLE),
  FoodItem('Beterraba', 13.9, FoodType.VEGETABLE)
];
}