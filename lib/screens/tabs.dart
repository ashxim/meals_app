import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/drawer.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';

const kInitialFilters = {
  Filter.gluteenFree: false,
  Filter.glocoseFree: false,
  Filter.vegetaria: false,
  Filter.vegan: false
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  late PageController _pageController;
  Map<Filter, bool> _selectedFilters = kInitialFilters;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleFavoriteMeal(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showMessage('The item was removed from favorites!');
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showMessage('Added to favorites!');
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  void _setScreen(identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filter') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => const FiltersScreen(),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.gluteenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.glocoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetaria]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleFavoriteMeal,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedPageIndex == 0 ? 'Categories' : 'Your Favorites'),
      ),
      drawer: MainDrawer(
        onSelectedScreen: _setScreen,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        children: [
          CategoriesScreen(
            onToggleFavorite: _toggleFavoriteMeal,
          ),
          MealsScreen(
            meals: _favoriteMeals,
            selctedItem: (context, meal) {},
            onToggleFavorite: _toggleFavoriteMeal,
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 200),
        backgroundColor: Theme.of(context).colorScheme.background,
        color: Theme.of(context).colorScheme.onSecondary,
        items: const [
          Icon(Icons.category_outlined),
          Icon(Icons.favorite_border),
        ],
        onTap: _onItemTapped,
        index: _selectedPageIndex,
      ),
    );
  }
}
