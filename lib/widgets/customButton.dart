import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final  Function onPress;
  CustomButton({this.text,this.onPress});
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onPress,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(30),

        ),
        child: Center(
          child: Text(
            "$text",
            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),
          ),
        ),
      ),
    );
  }
}
