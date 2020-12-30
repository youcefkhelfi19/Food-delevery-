import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
       elevation: 5.0,
      borderRadius: BorderRadius.circular(30),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 32,vertical: 14),
          hintText: 'Search here ',
          suffixIcon: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30),
              child: Icon(Icons.search,
               color: Colors.black,
              )),
            border: InputBorder.none
        ),
      ),
    );
  }
}
