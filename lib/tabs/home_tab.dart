import 'package:flutter/material.dart';
import 'package:foodie/models/food_model.dart';
import 'package:foodie/pages/food_details_page.dart';
import 'package:foodie/scope_model/main_model.dart';
import 'package:foodie/widgets/bought_food.dart';
import 'package:foodie/widgets/food_category.dart';
import 'package:foodie/widgets/home_top.dart';
import 'package:foodie/widgets/search.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeTab extends StatefulWidget {

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amberAccent,

        body: ListView(
          padding: EdgeInsets.only(left: 20,right: 20.0, top: 0),
          children: [
            HomeTop(),
            FoodCategory(),
            SizedBox(height: 10,),
            Search(),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  'Frequently Bought Food',
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Colors.black),
                ),
                GestureDetector(
                  child: Text('View All',
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Colors.brown),
                  ),
                )
              ],
            ),
            SizedBox(height: 15,),
            ScopedModelDescendant<MainModel>(
                builder:(BuildContext context, Widget child , MainModel model){
                  return Column(
                      children: model.foods.map(_buildFoodItems).toList()
                  );
                }
            )
          ],
        ),
      ),
    );
  }
  Widget _buildFoodItems(Food food){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodDetailsPage(
          food: food,
        )));

        },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: BoughtFoods(
          id:food.id ,
          name: food.title,
          category: food.category,
          imagePath: 'assets/lunch.jpeg',
          //imagePath: food.imagePath,
          rating: food.rating,
          discount: food.discount,
          price: food.price,
        ),
      ),
    );
  }
}
