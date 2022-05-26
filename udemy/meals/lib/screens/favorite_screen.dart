import 'package:flutter/material.dart';
import 'package:meals/components/meal_item.dart';
import 'package:meals/models/meal.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen(this.favoriteMeals, {Key? key}) : super(key: key);

  final List<Meal> favoriteMeals;

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(child: const Text('Nenhuma refeição foi marcada como favorita!'));
    }

    return ListView.builder(
      itemCount: favoriteMeals.length,
      itemBuilder: (ctx, index) {
        return MealItem(favoriteMeals[index]);
      },
    );
  }
}
