import 'package:foodie/scope_model/scoped_food_model.dart';
import 'package:foodie/scope_model/user_scoped_model.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model with FoodModel,UserScopedModel{
void fetchAll(){
  fetchUserInfo();
  fetchFoods();
}

}