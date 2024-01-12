import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {super.key,
      this.title,
      required this.meals,
      required this.selctedItem,
      required this.onToggleFavorite});
  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;
  final void Function(BuildContext context, Meal meal) selctedItem;
  @override
  Widget build(BuildContext context) {
    Widget content;
    selctedItem(BuildContext context, Meal meal, ont) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MealDetailsScreen(
            meal: meal,
            onToggleFavorite: onToggleFavorite,
          ),
        ),
      );
    }

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) => MealItem(
          meal: meals[index],
          onselectItem: (meal) {
            selctedItem(context, meal, onToggleFavorite);
          },
        ),
      );
    } else {
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sorry, there is no data.'),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Please try again',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).primaryColorLight),
            ),
          ],
        ),
      );
    }
    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
