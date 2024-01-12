import 'package:flutter/material.dart';

enum Filter {
  gluteenFree,
  glocoseFree,
  vegetaria,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _gluteenFreeFilterSet = false;
  bool _glocoseFreeFilterSet = false;
  bool _vegetarianFilterSet = false;
  bool _veganFilterSet = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.gluteenFree: _gluteenFreeFilterSet,
            Filter.glocoseFree: _glocoseFreeFilterSet,
            Filter.vegan: _veganFilterSet,
            Filter.vegetaria: _vegetarianFilterSet,
          });
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _gluteenFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _gluteenFreeFilterSet = isChecked;
                });
              },
              title: Text(
                'gluteen-free',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(
                'only include gluteen-free meals',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SwitchListTile(
              value: _glocoseFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _glocoseFreeFilterSet = isChecked;
                });
              },
              title: Text(
                'glocose-free',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(
                'only include glocose-free meals',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SwitchListTile(
              value: _vegetarianFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _vegetarianFilterSet = isChecked;
                });
              },
              title: Text(
                'vegetarian',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(
                'only include vegetarian meals',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SwitchListTile(
              value: _veganFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _veganFilterSet = isChecked;
                });
              },
              title: Text(
                'vegan',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(
                'only include vegan meals',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
