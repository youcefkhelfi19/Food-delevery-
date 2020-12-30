import 'package:flutter/material.dart';
import 'package:foodie/data/category_data.dart';
import 'package:foodie/models/category_model.dart';

import 'food_category_card.dart';

class FoodCategory extends StatelessWidget {
  final List<Category> _categories= categories;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (BuildContext context,int index){
          return FoodCategoryCard(
          categoryName: _categories[index].categoryName,
            imagePath: _categories[index].imagePath,
            numberOfItems: _categories[index].numberOfItems,
          );
        },
      ),
    );
  }
}
