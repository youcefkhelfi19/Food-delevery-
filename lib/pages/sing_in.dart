import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodie/enums/auth_mode.dart';
import 'package:foodie/pages/sign_up.dart';
import 'package:foodie/scope_model/main_model.dart';
import 'package:foodie/tabs/profile_tab.dart';
import 'package:foodie/widgets/customButton.dart';
import 'package:foodie/widgets/show_dialog.dart';
import 'package:scoped_model/scoped_model.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _email;
  String _password;
  GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey();
  GlobalKey<FormState>_formKey=GlobalKey();
  bool _toggleVisibility =true;
  Widget _buildEmailTextField(){
    return TextFormField(
      onSaved: (String value){
        _email=value.trim();
      },
      validator: (String value){
        String error;
        if(value.isEmpty){
          error='email name is required';
        }
        if(!value.contains("@")){
          error="Uncorrected email form";
        }
        return error;
      },
      decoration: InputDecoration(
        hintText: 'Your Email',
        hintStyle: TextStyle(
          color: Color(0xffbdc2cb),
           fontSize: 18
        )

      ),
    );
  }
  Widget _buildPasswordTextField(){
    return TextFormField(
      onSaved: (String value){
        _password=value;
      },
      validator: (String value){
        String error;
        if(value.length<6){
          error='Short password';
        }
        return error;
      },
      decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: TextStyle(
              color: Color(0xffbdc2cb),
              fontSize: 18
          ),
         suffixIcon: IconButton(
           onPressed: (){
            setState(() {

              _toggleVisibility =!_toggleVisibility;
            });
           },
           icon: _toggleVisibility? Icon(Icons.visibility,color: Colors.grey,):Icon(Icons.visibility_off,color: Colors.grey,),
         )
      ),
      obscureText: _toggleVisibility,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sing In ',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold
              ),
              ),
              SizedBox(height: 70,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Forget Password ?',
                  style: TextStyle(color: Colors.blueAccent,fontSize: 18),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                     _buildEmailTextField(),
                      SizedBox(height: 20,),
                      _buildPasswordTextField(),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              ScopedModelDescendant(
                  builder:(BuildContext context,Widget child, MainModel model){
                    return  CustomButton(
                      text: 'Sign In',
                      onPress: (){
                       showDialogIndicator(context, 'Signing in....');
                        onSubmit(
                            model.authenticate
                        );
                      },
                    );
                  }
              ),
              Divider(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("You don't have account ? ",
                  style: TextStyle(
                    color: Color(0xffbdc2cb)
                  ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                    },
                    child: Text('Sign up',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue
                    ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  void onSubmit(Function authenticate){
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      authenticate(_email,_password,authMode:AuthMode.SignIn).then((final response){
        if(!response['hasError']){
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed("mainScreen");
        }else{
          Navigator.of(context).pop();
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text(response['message']),
                duration: Duration(seconds: 3),
                backgroundColor: Colors.red,
              )
          );
        }
      });
    }
  }
}
