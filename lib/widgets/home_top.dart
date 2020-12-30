import 'package:flutter/material.dart';

class HomeTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textStyle=TextStyle(fontSize: 32,fontWeight: FontWeight.bold);

    return  Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(color: Colors.grey,),
          Text('What Would',style: textStyle,),
          Text('You like to eat ?',style: textStyle,)
        ],
      ),
    );
  }
}
