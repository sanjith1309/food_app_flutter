import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/data/dummy_data.dart';
import 'package:food_app/models/meal.dart';
import 'package:food_app/provider/meals_provider.dart';
import 'package:food_app/screens/categories.dart';
import 'package:food_app/screens/filters.dart';
import 'package:food_app/screens/meals.dart';
import 'package:food_app/widgets/main_drawer.dart';

const kIntitialFilters = {
  filter.glutenfree: false,
  filter.lactosefree: false,
  filter.vegetarian: false,
  filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  Map<filter, bool> _selectedFilters = kIntitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('REMOVED');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage('ADDED');
    }
  }

  void _selectpage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      final result = await Navigator.of(context).push<Map<filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters,),
        ),
      );
      print(result);
      setState(() {
        _selectedFilters = result ?? kIntitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals=ref.watch(mealProvider);
    final availableMeals = meals.where((meal) {
      if (_selectedFilters[filter.glutenfree] == true && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[filter.lactosefree] == true && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[filter.vegetarian] == true && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[filter.vegan] == true && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus, availableMeals: availableMeals,

    );
    var activePageTitle = 'Categories';
    if (_selectPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Favorties';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectpage,
        currentIndex: _selectPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
