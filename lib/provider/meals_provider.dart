import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/data/dummy_data.dart';

final mealProvider = Provider((ref) {
  return dummyMeals;
});
