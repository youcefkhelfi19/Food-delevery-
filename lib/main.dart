import 'package:flutter/material.dart';
import 'package:foodie/pages/sign_up.dart';
import 'package:foodie/pages/sing_in.dart';
import 'package:foodie/scope_model/main_model.dart';
import 'package:foodie/screens/main_screen.dart';
import 'package:scoped_model/scoped_model.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final MainModel mainModel=MainModel();
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: mainModel,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
         backgroundColor: Colors.amber
        ),
       routes: {
          "/":(BuildContext context)=> SignIn(),
         "mainScreen":(BuildContext context)=> MainScreen(model: mainModel),
       },

      ),
    );
  }
}
