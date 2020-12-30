import 'package:flutter/material.dart';
import 'package:foodie/models/user_info_model.dart';
import 'package:foodie/scope_model/main_model.dart';
import 'package:foodie/widgets/customFlattBtn.dart';
import 'package:foodie/widgets/custom_list_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileTab extends StatefulWidget {

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool notificationOn=false;
  bool locationTrackingOn=false;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context , Widget child , MainModel model){

          UserInfo userInfo=model.getUserDetails(model.authenticatedUser.id);
          return Scaffold(
              backgroundColor: Colors.amberAccent,
              body: SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Divider(color: Colors.grey,),
                        SizedBox(height: 20,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: Colors.red,
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 3,
                                        offset: Offset(0,4),
                                        color: Colors.black38
                                    )
                                  ],
                                  image: DecorationImage(
                                      image: AssetImage('assets/breakfast.jpeg',
                                      ),
                                      fit: BoxFit.cover
                                  )
                              ),

                            ),
                            SizedBox(width: 30,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${userInfo.userName}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text('${userInfo.email}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black
                                  ),
                                ),
                                SizedBox(height: 20,),
                                CustomFlattBtn(
                                  onPress: (){

                                  },
                                  text:'Edit',
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 10.0,),
                        Text('Account' ,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10.0,),
                        Card(
                          elevation: 3.0,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: <Widget>[

                                CustomListTile(
                                  icon: Icons.location_on,
                                  text: "Location",
                                ),
                                Divider(height: 10.0,color: Colors.grey,indent: 0.0,),
                                CustomListTile(
                                  icon: Icons.visibility_off,
                                  text: "Password",
                                ),
                                Divider(height: 10.0,color: Colors.grey,indent: 0.0,),

                                CustomListTile(
                                  icon: Icons.shopping_cart,
                                  text: "shipping",
                                ),
                                Divider(height: 10.0,color: Colors.grey,indent: 0.0,),

                                CustomListTile(
                                  icon: Icons.payment,
                                  text: "Payment",
                                ),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Text('Notifications' ,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10.0,),
                        Card(
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('App Notifications',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Switch(
                                        value: notificationOn,
                                        onChanged:(bool val){
                                          setState(() {
                                            notificationOn=val;
                                          });
                                        }
                                    )
                                  ],
                                ),
                                Divider(height: 10,
                                  color: Colors.grey,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Location tracking',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Switch(
                                        value: locationTrackingOn,
                                        onChanged:(bool val){
                                          setState(() {
                                            locationTrackingOn=val;
                                          });
                                        }
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Text('Other' ,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10.0,),
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Language",style: TextStyle(fontSize: 16.0),),
                                  Divider(height: 30.0,color: Colors.grey,indent: 0.0,),
                                  Text("Currency",style: TextStyle(fontSize: 16.0),),

                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
          );
        }

    );
  }
}
