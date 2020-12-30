import 'package:flutter/material.dart';

class CustomFlattBtn extends StatelessWidget {
  final String text;
  final Function onPress;
  CustomFlattBtn({this.onPress,this.text});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 25,
        width: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blue)
        ),
        child: Center(
          child: Text(text,
            style: TextStyle(
                color: Colors.blue,fontSize: 16
            ),
          ),
        ),
      ),
    );

  }
}
