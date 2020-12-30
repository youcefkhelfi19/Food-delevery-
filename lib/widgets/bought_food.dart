import 'package:flutter/material.dart';

class BoughtFoods extends StatefulWidget {
  final String id;
  final String name;
  final String imagePath;
  final String category;
  final double price ;
  final double discount;
  final double rating;

  BoughtFoods({this.id, this.name, this.imagePath, this.category, this.price, this.discount, this.rating});
  @override
  _BoughtFoodsState createState() => _BoughtFoodsState();
}

class _BoughtFoodsState extends State<BoughtFoods> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          Container(
            height: 200,
            width: 340,
            child: Image.asset(widget.imagePath,fit: BoxFit.cover,)
          ),
          Positioned(
            left: 0,
          right: 0,
            bottom: 0,
            child: Container(
              height: 60,
              width: 340,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.black12
                  ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.name,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18, color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.star,color: Theme.of(context).primaryColor,size: 18,),
                            Icon(Icons.star,color: Theme.of(context).primaryColor,size: 18,),
                            Icon(Icons.star,color: Theme.of(context).primaryColor,size: 18,),
                            Icon(Icons.star,color: Theme.of(context).primaryColor,size: 18,),
                            Icon(Icons.star,color: Theme.of(context).primaryColor,size: 18,),
                            SizedBox(width: 5,),
                            Text('('+widget.rating.toString()+' Review)',
                              style: TextStyle(color: Colors.grey,fontSize: 14),
                            )
                          ],
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(widget.price.toString(),
                        style: TextStyle(fontSize: 18,color: Colors.deepOrange,fontWeight: FontWeight.bold),
                        ),
                        Text('Min Order',
                          style: TextStyle(fontSize: 16,color: Colors.grey,),
                        )
                      ],
                    )
                  ],
                  
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
