import 'package:flutter/material.dart';
import 'package:food_app/screens/categories.dart';
import 'package:food_app/screens/tabs.dart';
import 'package:food_app/widgets/main_drawer.dart';

enum filter {
  glutenfree,
  lactosefree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key,required this.currentFilters});
  final Map<filter,bool> currentFilters;
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenfreeFilterset = false;
  var _lactosefreeFilterset = false;
  var _vegetarianFilterset = false;
  var _veganFilterset = false;
  @override
  void initState() {
    super.initState();
    _glutenfreeFilterset = widget.currentFilters[filter.glutenfree]!;
    _lactosefreeFilterset = widget.currentFilters[filter.lactosefree]!;
    _vegetarianFilterset = widget.currentFilters[filter.vegetarian]!;
    _veganFilterset = widget.currentFilters[filter.vegan]!;
    print(widget.currentFilters);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if(identifier=='Meals'){
      //     Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (ctx) => const TabsScreen(),
      //   ),
      // );
      //   }
      //  },),
      body: WillPopScope(
        onWillPop: () async{
          Navigator.of(context).pop({
            filter.glutenfree: _glutenfreeFilterset,
            filter.lactosefree: _lactosefreeFilterset,
            filter.vegetarian: _vegetarianFilterset,
            filter.vegan: _veganFilterset,
          });
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenfreeFilterset,
              onChanged: (isChecked) {
                setState(() {
                  _glutenfreeFilterset = isChecked;
                });
              },
              title: Text(
                'Gluten-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Only include Gluten-free meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _lactosefreeFilterset,
              onChanged: (isChecked) {
                setState(() {
                  _lactosefreeFilterset = isChecked;
                });
              },
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Only include Lactose-free meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _vegetarianFilterset,
              onChanged: (isChecked) {
                setState(() {
                  _vegetarianFilterset = isChecked;
                });
              },
              title: Text(
                'vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Only include Vegetarian meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _veganFilterset,
              onChanged: (isChecked) {
                setState(() {
                  _veganFilterset = isChecked;
                });
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Only include Vegan meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
