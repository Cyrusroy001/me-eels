import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  static const RouteName = '/category-meals';
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String catTitle;
  Color catColor;
  List<Meal> displayedMeals;
  var _loadInitData = false;

  //runs before build and has no context
  @override
  void initState() {
    super.initState();
  }

  //runs before build but has some context
  @override
  void didChangeDependencies() {
    if (!_loadInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, Object>;
      catTitle = routeArgs['title'].toString();
      catColor = routeArgs['color'];
      final catId = routeArgs['id'].toString();

      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(catId);
      }).toList();
      _loadInitData = true;
    }

    super.didChangeDependencies();
  }

  void _removeItem(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: catColor,
        title: Text(
          catTitle + ' Meals',
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            color: catColor,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
    
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
