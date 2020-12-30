import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/models/food_model.dart';
import 'package:foodie/scope_model/main_model.dart';
import 'package:foodie/widgets/customButton.dart';
import 'package:foodie/widgets/show_dialog.dart';
import 'package:scoped_model/scoped_model.dart';

class AddFoodItem extends StatefulWidget {
  final Food food;
  AddFoodItem({this.food});
  @override
  _AddFoodItemState createState() => _AddFoodItemState();
}

class _AddFoodItemState extends State<AddFoodItem> {
  String title;
  String category;
  String description;
  String price;
  String discount;
  GlobalKey<FormState> _formKey =GlobalKey();
  GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: WillPopScope(
        onWillPop: (){
          Navigator.of(context).pop(false);
            return Future.value(true);
        },
        child: Scaffold(

          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(widget.food != null? 'Update Food':'Add Food',
                style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold)
            ),
            backgroundColor: Colors.amberAccent,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: (){
                Navigator.of(context).pop(false);
              },
            ),
          ),
          backgroundColor: Colors.amberAccent,
          body: Container(
            margin: EdgeInsets.symmetric(vertical: 0,horizontal: 20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(

                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width*0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                          image: DecorationImage(
                              image: AssetImage('assets/noimage.png')
                          )
                      ),
                    ),
                  _buildTextFormField(
                    'Food Name'
                  ),
                    _buildTextFormField('Category'),
                    _buildTextFormField('Description',
                    maxLine: 3                ),
                    _buildTextFormField(
                        'Price'
                    ),
                    _buildTextFormField(
                        'Discount',

                    ),
                    ScopedModelDescendant<MainModel>(
                        builder:(BuildContext context, Widget child, MainModel model){
                          return CustomButton(
                            text:widget.food != null? 'Update': 'Add',
                            onPress: (){


                             onSubmit(model.addFood,model.updateFood);
                             if(model.isLoading){
                               showDialogIndicator(context,
                               widget.food !=null ? 'Updating Food':
                                   'Adding Food'
                               );

                             }
                            },
                          );

                        }

                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future onSubmit(Function addFood,Function updateFood)async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      if(widget.food != null){
         Map<String, dynamic> updatedFood={
           "title": title,
           "category": category,
           "description": description,
           "price":double.parse(price),
           "discount": double.parse(discount)
         };
         final bool response=await updateFood(updatedFood,widget.food.id);
         if(response){
           Navigator.of(context).pop();
           Navigator.of(context).pop(response);
           SnackBar snackBar =SnackBar(
             duration: Duration(seconds: 2),
             backgroundColor: Colors.blueAccent,
             content: Text('Item updated successfully',
             style: TextStyle(color: Colors.white),
             ), );
           _scaffoldKey.currentState.showSnackBar(snackBar);
         }else if(!response){
           Navigator.of(context).pop();
           Navigator.of(context).pop();
           SnackBar snackBar =SnackBar(
             duration: Duration(seconds: 2),
             backgroundColor: Colors.red,
             content: Text('Failed !',style: TextStyle(color: Colors.white),), );
           _scaffoldKey.currentState.showSnackBar(snackBar);
         }
      }else if(widget.food == null){
        final Food food= Food(
            title: title,
            category: category,
            description: description,
            price: double.parse(price),
            discount: double.parse(discount)

        );
        bool value=await addFood(food);
        if(value){
          Navigator.pop(context);
          SnackBar snackBar=SnackBar(
            content: Text('Item Added successfully'),

          );
          _scaffoldKey.currentState.showSnackBar(snackBar);
        }else if(!value){
          Navigator.pop(context);
          SnackBar snackBar=SnackBar(
            content: Text('Field to add item'),

          );
          _scaffoldKey.currentState.showSnackBar(snackBar);
        }
      }
    }
  }

  Widget _buildTextFormField(String hint, {int maxLine=1}){
    return Padding(
      padding: const EdgeInsets.only(top: 10,bottom: 10),
      child: TextFormField(
       initialValue: widget.food != null && hint == 'Food Name'? widget.food.title :
       widget.food != null && hint == 'Category'? widget.food.category :
       widget.food != null && hint == 'Description'? widget.food.description :
       widget.food != null && hint == 'Price'? widget.food.price.toString() :
       widget.food != null && hint == 'Discount'? widget.food.discount.toString() :
        null
        ,
        decoration: InputDecoration(

          hintText: '$hint',
      enabledBorder: const OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.orange,width: 1),
    ) ,
       focusedBorder: const OutlineInputBorder(
       borderSide: const BorderSide(color: Colors.white,width: 1),
    ) ,
       border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100)
    )

        ),
        maxLines: maxLine,
        keyboardType: hint=='Price'|| hint=='Discount'? TextInputType.number :TextInputType.text,
        onSaved: (String val){
          if(hint=='Food Name'){
            title=val;

          }
          if(hint=='Category'){
            category=val;
          }
          if(hint=='Description'){
            description=val;
          }
          if(hint=='Price'){
            price=val;
          }
          if(hint=='Discount'){
            discount=val;
          }
        },
        validator: (String value){
          if(value.isEmpty&&hint=='Food Name'){
            return 'Food Name required';
          }
          if(value.isEmpty&&hint=='Category'){
            return 'Add category';
          }
          if(value.isEmpty&&hint=='Description'){
            return 'Say something about this food ';
          }
          if(value.isEmpty&&hint=='Price'){
            return 'Add the price';
          }
          if(value.isEmpty&&hint=='Discount'){
            return 'Add discount ';
          }
          return null;
        },
      ),
    );
  }
}
