
import 'package:dart_genetic_algorithm/dto/food.dart';

class MealComponent {
  final FoodItem foodItem;
  double quantityOunces;
  MealComponent(this.foodItem, this.quantityOunces);

  double get gram => quantityOunces * 28.3495;

  double get totalCalories => foodItem.caloriesPerOunce * quantityOunces;
}