import 'package:flutter/material.dart';
import 'package:foodie/models/food_model.dart';

class FoodDetailsPage extends StatelessWidget {
  final Food food;
  FoodDetailsPage({
    this.food
});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amberAccent,
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )
                  ),
                  child: Image.asset('assets/lunch.jpeg',
                  fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 15,
                  top: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black38
                    ),
                    child: Center(
                      child: IconButton(
                          icon:Icon(Icons.arrow_back , size: 30,color: Colors.white,) ,
                          onPressed:(){
                             Navigator.pop(context);
                      }),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(food.title,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                  ),
                  Text('${food.price}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  ),
                  )
                ],
              ),

            ),
            Divider(color: Colors.grey,),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description :',style:
                    TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    )
                    ,),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: Text("${food.description}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                      ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.star,color: Theme.of(context).primaryColor,size: 25,),
                      Icon(Icons.star,color: Theme.of(context).primaryColor,size: 25,),
                      Icon(Icons.star,color: Theme.of(context).primaryColor,size: 25,),
                      Icon(Icons.star,color: Theme.of(context).primaryColor,size: 25,),
                      Icon(Icons.star,color: Theme.of(context).primaryColor,size: 25,),
                      SizedBox(width: 5,),

                      Text('${100}(Review)',
                        style: TextStyle(color: Colors.grey,fontSize: 16),
                      ),
                      Text('Discount')
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 60,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.add_circle,color: Colors.grey,),
                        onPressed: (){

                        },),
                      SizedBox(height: 15.0,),

                      Text("1", style: TextStyle(fontSize: 16.0)),
                      SizedBox(height: 15.0,),
                      IconButton(icon: Icon(Icons.remove_circle,color: Colors.grey,),
                        onPressed: (){

                        },),


                    ],
                  ),
                  buildBtn(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildBtn() {
    return Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blue)
                  ),
                  child: Center(
                    child: Text('Add to Cart',
                      style: TextStyle(
                          color: Colors.white,fontSize: 16
                      ),
                    ),
                  ),
                );
  }
}
