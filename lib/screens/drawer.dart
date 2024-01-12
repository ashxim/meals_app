import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectedScreen});
  final void Function(String identifier) onSelectedScreen;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.fastfood,
                      size: 50,
                    ),
                    SizedBox(width: 16),
                    Text(
                      'lets cook!',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.restaurant_outlined, size: 30),
            title: const Text(
              'meals',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            onTap: () {
              onSelectedScreen('meals');
            },
          ),
          ListTile(
            leading: const Icon(Icons.filter_list_sharp, size: 30),
            title: const Text(
              'filter',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            onTap: () {
              onSelectedScreen('filter');
            },
          ),
        ],
      ),
    );
  }
}
