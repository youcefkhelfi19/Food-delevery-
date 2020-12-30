import 'package:flutter/material.dart';
import 'package:foodie/admin_pages/add_food_item.dart';
import 'package:foodie/pages/sing_in.dart';
import 'package:foodie/scope_model/main_model.dart';
import 'package:foodie/tabs/explore_tab.dart';
import 'package:foodie/tabs/home_tab.dart';
import 'package:foodie/tabs/ordersTab.dart';
import 'package:foodie/tabs/profile_tab.dart';
import 'package:scoped_model/scoped_model.dart';

class MainScreen extends StatefulWidget {
 final MainModel model;
 MainScreen({this.model});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTabIndex=0;
  List<Widget>tabs;
  Widget currentTab;
  HomeTab homeTab;
  OrdersTab ordersTab;
  ExploreTab exploreTab;
  ProfileTab profileTab;
  @override
  void initState() {
    // TODO: implement initState
    widget.model.fetchAll();
    homeTab=HomeTab();
    ordersTab=OrdersTab();
    exploreTab=ExploreTab();
    profileTab=ProfileTab();
    tabs=[homeTab,exploreTab,ordersTab,profileTab];
    currentTab=homeTab;
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            currentTabIndex == 0 ? 'Home' :currentTabIndex == 1? 'All Foods' : currentTabIndex == 2 ?'Orders':'Profile',
            style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold)
          ),
          centerTitle: true,
          actions: [
          IconButton(icon: Icon(Icons.notifications_none, size: 25.0,color: Theme.of(context).primaryColor,),
              onPressed: null),
           currentTabIndex == 3 ?
                ScopedModelDescendant(builder:
                (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => SignIn()));
                  model.logout();
                },
              );
            })
               :
            IconButton(icon: _buildIconCart(),
                onPressed: null)

          ],

        ),

        drawer: Drawer(
          child: Column(
            children: [

              ListTile(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFoodItem()));

                },
                leading: Icon(Icons.list),
                title: Text('Add Food '),
              )
            ],
          ),
        ),
        backgroundColor: Colors.amberAccent,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index){
           setState(() {
             currentTabIndex=index;
             currentTab=tabs[index];
           });
          },
          currentIndex: currentTabIndex,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Explore'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
                label: 'Cart'
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person),
                label: 'Profile'
            ),
          ],
        ),

        body: currentTab,
      ),
    );
  }
  Widget _buildIconCart(){
    return Stack(
      children: [
        Icon(Icons.shopping_bag_outlined, size: 25.0,color: Theme.of(context).primaryColor,),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            height: 12,
            width: 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.red
            ),
            child: Center(child: Text('99',
            style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ],
    );
  }
}
