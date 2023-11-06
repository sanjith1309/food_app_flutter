import 'package:flutter/material.dart';
import 'package:food_app/models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    required this.meals,
    required this.title,
    super.key,
  });

  final String title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No data",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Try Selecting different category",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );

    if (!meals.isEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => Text(
          meals[index].title,
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("hello"),
      ),
      body: content,
    );
  }
}
