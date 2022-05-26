import 'package:flutter/material.dart';
import 'package:meals/components/meal_item.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';

class CategoriesMealsScreen extends StatelessWidget {
  const CategoriesMealsScreen(this.meals, {Key? key}) : super(key: key);

  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as Category;

    final categoryMeals = meals.where((meal) => meal.categories.contains(category.id)).toList();

    return Scaffold(
      appBar: AppBar(title: Text(category.title)),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (ctx, index) => MealItem(categoryMeals[index]),
      ),
    );
  }
}
