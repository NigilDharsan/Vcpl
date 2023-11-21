import 'package:flutter/material.dart';
import 'package:vcpl/Src/Utilits/Common_Colors.dart';
import 'package:vcpl/Src/Utilits/Image_Path.dart';
import 'package:vcpl/Src/Utilits/Text_Style.dart';

import '../Common_Widgets/Custom_App_Bar.dart';

class Home_Dashboard_Screen extends StatefulWidget {
  const Home_Dashboard_Screen({super.key});

  @override
  State<Home_Dashboard_Screen> createState() => _Home_Dashboard_ScreenState();
}

class _Home_Dashboard_ScreenState extends State<Home_Dashboard_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white3,
      appBar: Custom_AppBar(title: 'Dashboard', actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: CircleAvatar(
            radius: 15,
            backgroundColor: grey3,
            child: Icon(Icons.person,size: 20,),
          ),
        ),
      ],isNav: null,),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25,),
            //Cement Transactions && Labours Assigning
            Padding(
              padding: const EdgeInsets.only(bottom: 20,top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DashBoardCard(context, cardTitle: 'Cement Transactions', cardImg: 'payment.svg'),
                  const Spacer(),
                  _DashBoardCard(context, cardTitle: 'Labours Assigning', cardImg: 'Document.svg'),
                ],
              ),
            ),
            //Centering Transaction && Tools&Plants Transaction
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  _DashBoardCard(context, cardTitle: 'Centering Transaction', cardImg: 'Document.svg'),
                  const Spacer(),
                  _DashBoardCard(context, cardTitle: 'Tools&Plants Transaction', cardImg: 'Document.svg'),
                ],
              ),
            ),
            //Lorry Transactions && Shop Transactions
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  _DashBoardCard(context, cardTitle: 'Lorry Transactions', cardImg: 'Document.svg'),
                  const Spacer(),
                  _DashBoardCard(context, cardTitle: 'Shop Transactions', cardImg: 'Document.svg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _DashBoardCard(context,{ required String cardTitle, required String cardImg}){
  return  Card(
    elevation: 5,
    child: Container(
      width:MediaQuery.of(context).size.width/2.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: white1,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //COUNT
            Padding(
              padding: const EdgeInsets.only(top: 15,bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(child: Icon(Icons.shopping_cart_rounded,color: blue3,size: 45,)),
                  SizedBox(height: 5,),
                  //CARD TITLE
                  Container(
                    width: 100,
                    child: Text(cardTitle,style: cardT,maxLines: 2,),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    ),
  );
}
