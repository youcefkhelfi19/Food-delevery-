import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/pages/sign_up.dart';
import 'package:foodie/widgets/order_card.dart';

class OrdersTab extends StatefulWidget {
  @override
  _OrdersTabState createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,

      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.vertical,
        children: [
          OrderCard(),
          OrderCard(),
          OrderCard(),
          OrderCard(),


        ],
      ),
      bottomNavigationBar: _buildTotalContainer() ,
    );
  }
  Widget _buildTotalContainer(){
    return Container(
      height: 220,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Cart Total",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey),),
               Text("23",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Discount",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey),),
              Text("3.0",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Tax",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey),),
              Text("0.5",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
            ],
          ),
          Divider(height: 20,color: Colors.white,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey),),
              Text("26.5",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
            ],
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),

              ),
              child: Center(
                child: Text(
                  "Proceed To Check",
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
