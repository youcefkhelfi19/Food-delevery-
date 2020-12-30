import 'package:flutter/material.dart';
import 'package:foodie/widgets/customFlattBtn.dart';

class FoodItemCard extends StatelessWidget {
  final String foodName;
  final String description;
  final String price;
  final Function onDelete;
   const FoodItemCard({
     this.price,this.description,this.foodName,this.onDelete,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                offset: Offset(0,3),
                color: Colors.black38
            )
          ]
      ),
      child: Stack(
        children: [

          Row(
            children: [
              Container(
                height:MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width*0.35,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/breakfast.jpeg'),
                        fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(

                      children: [
                        Text('$foodName',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),),
                            SizedBox(width: 83,),

                      ],
                    ),
                    SizedBox(height: 5,),
                    Container(
                      height: 39,
                     width: 170,
                      child: Text(
                        '$description',
                        style: TextStyle(fontSize: 14),
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height:5 ,),
                    Row(
                      children: [
                        Text('$price DA',
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                         SizedBox(width: 52),
                        CustomFlattBtn(
                          text: 'Buy',
                          onPress: (){

                          },
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Positioned(
            right: 5,
            top: 5,
            child: InkWell(
                onTap: onDelete,
                child: Icon(Icons.cancel,color: Colors.grey,)),
          ),
        ],
      ),
    );
  }
}
