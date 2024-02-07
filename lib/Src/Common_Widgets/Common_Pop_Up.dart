import 'package:flutter/material.dart';
import 'package:vcpl/Src/Add_Transaction_Ui/Add_Cement_Transaction_Screen.dart';
import 'package:vcpl/Src/Add_Transaction_Ui/Add_Centering_Transactions_Screen.dart';
import 'package:vcpl/Src/Add_Transaction_Ui/Add_Labours_Assigning_Screen.dart';
import 'package:vcpl/Src/Add_Transaction_Ui/Add_Lorry_Transaction_Screen.dart';
import 'package:vcpl/Src/Add_Transaction_Ui/Add_Shop_Transactions_Screen.dart';
import 'package:vcpl/Src/Add_Transaction_Ui/Add_ToolsandPlants_Transactions_Screen.dart';
import 'package:vcpl/Src/Transaction_History_Ui/Cement_Transaction_Screen.dart';
import 'package:vcpl/Src/Transaction_History_Ui/Centering_Transaction_Screen.dart';
import 'package:vcpl/Src/Transaction_History_Ui/Lorry_Transaction_Screen.dart';
import 'package:vcpl/Src/Transaction_History_Ui/Shop_Transaction_Screen.dart';
import 'package:vcpl/Src/Transaction_History_Ui/Tools_And_Plant_Transaction_Screen.dart';
import 'package:vcpl/Src/Utilits/Common_Colors.dart';

import 'Common_Button.dart';

//CEMENT POP UP
Widget Cement_Pop_Up(BuildContext context) {
  return AlertDialog(
    surfaceTintColor: white1,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 25, bottom: 20),
          child: CommonElevatedButton(context, "View Transaction History", () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Cement_Transaction()));
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: CommonElevatedButton(context, "Add Cement Transactions", () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Add_Cement_Transaction_Screen()));
          }),
        ),
      ],
    ),
  );
}

//CENTERING POP UP
Widget Centering_Pop_Up(BuildContext context) {
  return AlertDialog(
    surfaceTintColor: white1,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 25, bottom: 20),
          child: CommonElevatedButton(context, "View Transaction History", () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Centering_Transaction()));
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child:
              CommonElevatedButton(context, "Add Centering Transactions", () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Add_Centering_Transaction_Screen()));
          }),
        ),
      ],
    ),
  );
}

//LORRY POP UP
Widget Lorry_Pop_Up(BuildContext context) {
  return AlertDialog(
    surfaceTintColor: white1,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 25, bottom: 20),
          child: CommonElevatedButton(context, "View Transaction History", () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Lorry_Transaction_Screen()));
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: CommonElevatedButton(context, "Add Lorry Transactions", () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Add_Lorry_Transaction_Screen()));
          }),
        ),
      ],
    ),
  );
}

//SHOP POP UP
Widget Shop_Pop_Up(BuildContext context) {
  return AlertDialog(
    surfaceTintColor: white1,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 25, bottom: 20),
          child: CommonElevatedButton(context, "View Transaction History", () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Shop_Transaction_Screen()));
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: CommonElevatedButton(context, "Add Shop Transactions", () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Add_Shop_Transaction_Screen()));
          }),
        ),
      ],
    ),
  );
}

//TOOLS AND PLANT POP UP
Widget Tools_Pop_Up(BuildContext context) {
  return AlertDialog(
    surfaceTintColor: white1,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 25, bottom: 20),
          child: CommonElevatedButton(context, "View Transaction History", () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Tools_And_Plant_Transaction_Screen()));
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: CommonElevatedButton(context, "Add ToolsAndPlant Transactions",
              () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Add_ToolsAndPlant_Transaction_Screen()));
          }),
        ),
      ],
    ),
  );
}

//LABOUR POP UP
Widget Labour_Pop_Up(BuildContext context) {
  return AlertDialog(
    surfaceTintColor: white1,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 25, bottom: 20),
          child: CommonElevatedButton(
              context, "Add Labours Assigning Transactions", () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Add_Labours_Assigning_Screen()));
          }),
        ),
      ],
    ),
  );
}
