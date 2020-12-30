import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(

      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration:BoxDecoration(
                border:Border.all(width:2.0,color: Colors.grey ),
                borderRadius: BorderRadius.circular(10)
              ),
              height:75,
              width: 45,
              child: Column(
                children: [
                      InkWell(
                          onTap:(){
        },
                          child: Icon(Icons.keyboard_arrow_up,color: Colors.grey,)),
                      Text('0',style: TextStyle(fontSize: 18),),
                      InkWell(
                          onTap: (){

                          },
                          child: Icon(Icons.keyboard_arrow_down,color: Colors.blueGrey,)),

                ],
              ),
            ),
            //SizedBox(width: 20,),
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/lunch.jpeg"),
                  fit: BoxFit.cover
                ),
               borderRadius: BorderRadius.circular(35),
                boxShadow:[
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(5.5,5.5),
                    blurRadius: 5.5
                  )
                ]
              ),
            ),
            //SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Grilled Chicken',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                Text('300 DZ',style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 16)),
                  SizedBox(height: 5,),
                Container(
                  height: 25,
                  width: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        Text('Chicken',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                        SizedBox(width: 5,),
                        InkWell(
                            onTap: (){

                            },
                            child: Text('x',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),))
                      ],
                    ),
                  ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Text('Chicken',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                            SizedBox(width: 5,),
                            InkWell(
                                onTap: (){

                                },
                                child: Text('x',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),))
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            GestureDetector(
                onTap: (){

                },
                child: Icon(Icons.cancel,color: Colors.grey,))
          ],
        ),
      ),
    );
  }
}
