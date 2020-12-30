import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodie/enums/auth_mode.dart';
import 'package:foodie/pages/sing_in.dart';
import 'package:foodie/scope_model/main_model.dart';
import 'package:foodie/widgets/customButton.dart';
import 'package:foodie/widgets/show_dialog.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _toggleVisibility =true;
   String _username;
   String _email;
   String _password;
  GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey();
  GlobalKey<FormState>_formKey=GlobalKey();
  Widget _buildUserNameTextField(){
    return TextFormField(
      onSaved: (String value){
        _username=value.trim();
      },
      validator: (String value){
        String error;
        if(value.isEmpty){
          error='User name is required';
        }
        return error;
      },
      decoration: InputDecoration(
          hintText: 'User name',
          hintStyle: TextStyle(
              color: Color(0xffbdc2cb),
              fontSize: 18
          )

      ),
    );
  }
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
      backgroundColor: Colors.amberAccent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sing Up ',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 30,),
             /* Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Forget Password ?',
                    style: TextStyle(color: Colors.blueAccent,fontSize: 18),
                  )
                ],
              ),*/
              SizedBox(height: 10,),
              Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      _buildUserNameTextField(),
                      SizedBox(height: 10,),
                      _buildEmailTextField(),
                      SizedBox(height: 10,),
                      _buildPasswordTextField(),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
                ScopedModelDescendant(
                    builder:(BuildContext context,Widget child, MainModel model){
                      return  CustomButton(
                        text: 'Sign Up',
                        onPress: (){
                          showDialogIndicator(context, 'Creating account');
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
                  Text("Already have account ?  ",
                    style: TextStyle(
                        color: Color(0xffbdc2cb)
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
                    },
                    child: Text('Sign In',
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
      Map<String, dynamic> userInfo={
        "username":_username,
        "email":_email,
        "userType":'custom'
      };
      authenticate(_email,_password,authMode:AuthMode.SignUp,userInfo:userInfo).then((final response){
        if(!response['hasError']){
          print("done");
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed("mainScreen");

        }else{
          print('fuck');
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
