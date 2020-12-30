import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/admin_pages/add_food_item.dart';
import 'package:foodie/scope_model/main_model.dart';
import 'package:foodie/widgets/food_item_card.dart';
import 'package:foodie/widgets/show_dialog.dart';
import 'package:scoped_model/scoped_model.dart';

class ExploreTab extends StatefulWidget {

  @override
  _ExploreTabState createState() => _ExploreTabState();

}

  class _ExploreTabState extends State<ExploreTab> {
   GlobalKey<ScaffoldState> _exploreScaffoldKey=GlobalKey();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amberAccent,
        key: _exploreScaffoldKey,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ScopedModelDescendant<MainModel>(

              builder: (BuildContext context, Widget child, MainModel model){

               model.fetchFoods();
              // List<Food> foods=model.foods;
                return  RefreshIndicator(
                  onRefresh: model.fetchUserInfo,
                  child: ListView.builder(
                    itemCount: model.foodsLength,
                      itemBuilder:(BuildContext listViewContext,int index) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          child: GestureDetector(
                            onTap: ()async{
                             final bool response= await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFoodItem(
                                food: model.foods[index],
                              )));
                            if(response){
                              SnackBar snackBar =SnackBar(
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.blueAccent,
                                content: Text('Item updated successfully',
                                  style: TextStyle(color: Colors.white),
                                ), );
                              _exploreScaffoldKey.currentState.showSnackBar(snackBar);
                            }
                            },
                            child: FoodItemCard(
                              onDelete: (){
                               showDialogIndicator(context, 'Deleting food');
                               model.deleteFood(model.foods[index].id).then((bool response) => Navigator.of(context).pop());

                              },
                              foodName: model.foods[index].title,
                              price: model.foods[index].price.toString(),
                              description: model.foods[index].description,

                            ),
                          ),

                        );
                      }
                        )

                );
              }),
        )
      ),
    );
  }
}

