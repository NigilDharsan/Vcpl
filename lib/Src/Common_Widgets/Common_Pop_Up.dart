import 'package:flutter/material.dart';
import 'package:vcpl/Src/Add_Transaction_Ui/Add_Cement_Transaction_Screen.dart';
import 'package:vcpl/Src/Add_Transaction_Ui/Add_Centering_Transactions_Screen.dart';
import 'package:vcpl/Src/Add_Transaction_Ui/Add_Labours_Assigning_Screen.dart';
import 'package:vcpl/Src/Add_Transaction_Ui/Add_Lorry_Transaction_Screen.dart';
import 'package:vcpl/Src/Add_Transaction_Ui/Add_Shop_Transactions_Screen.dart';
import 'package:vcpl/Src/Add_Transaction_Ui/Add_ToolsandPlants_Transactions_Screen.dart';
import 'package:vcpl/Src/Models/CommonListModel.dart';
import 'package:vcpl/Src/Models/VehicleModel.dart';
import 'package:vcpl/Src/Transaction_History_Ui/Cement_Transaction_Screen.dart';
import 'package:vcpl/Src/Transaction_History_Ui/Centering_Transaction_Screen.dart';
import 'package:vcpl/Src/Transaction_History_Ui/Lorry_Transaction_Screen.dart';
import 'package:vcpl/Src/Transaction_History_Ui/Shop_Transaction_Screen.dart';
import 'package:vcpl/Src/Transaction_History_Ui/Tools_And_Plant_Transaction_Screen.dart';
import 'package:vcpl/Src/Utilits/Common_Colors.dart';

import '../Pending_Transaction_Ui/Pending_Transaction_Screen.dart';
import 'Common_Button.dart';

//CEMENT POP UP
Widget Cement_Pop_Up(BuildContext context, List<ListData> sitenameData,
    List<ListData> siteListData, List<VehicleData> vehicleListData) {
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
                    builder: (context) => Cement_Transaction(sitenameData)));
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: CommonElevatedButton(context, "Add Cement Transactions", () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Add_Cement_Transaction_Screen(
                        sitenameData, siteListData, vehicleListData)));
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: CommonElevatedButton(context, "Pending Transactions", () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Pending_Transaction_Screen("Cement Transactions")));
          }),
        ),
      ],
    ),
  );
}

//CENTERING POP UP
Widget Centering_Pop_Up(BuildContext context, List<ListData> sitenameData,
    List<ListData> siteListData, List<VehicleData> vehicleListData) {
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
                    builder: (context) => Centering_Transaction(sitenameData)));
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
                    builder: (context) => Add_Centering_Transaction_Screen(
                        sitenameData, siteListData, vehicleListData)));
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 25),
          child: CommonElevatedButton(context, "Pending Transaction", () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Pending_Transaction_Screen("Centering Transactions")));
          }),
        ),
      ],
    ),
  );
}

//LORRY POP UP
Widget Lorry_Pop_Up(BuildContext context, List<ListData> sitenameData,
    List<ListData> siteListData, List<VehicleData> vehicleListData) {
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
                        Lorry_Transaction_Screen(sitenameData)));
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: CommonElevatedButton(context, "Add Lorry Transactions", () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Add_Lorry_Transaction_Screen(
                        sitenameData, siteListData, vehicleListData)));
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 25),
          child: CommonElevatedButton(context, "Pending Transaction", () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Pending_Transaction_Screen("Lorry Transactions")));
          }),
        ),
      ],
    ),
  );
}

//SHOP POP UP
Widget Shop_Pop_Up(BuildContext context, List<ListData> sitenameData) {
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
                        Shop_Transaction_Screen(sitenameData)));
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
Widget Tools_Pop_Up(BuildContext context, List<ListData> sitenameData,
    List<ListData> siteListData, List<VehicleData> vehicleListData) {
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
                        Tools_And_Plant_Transaction_Screen(sitenameData)));
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
                    builder: (context) => Add_ToolsAndPlant_Transaction_Screen(
                        sitenameData, siteListData, vehicleListData)));
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 25),
          child: CommonElevatedButton(context, "Pending Transaction", () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Pending_Transaction_Screen(
                        "ToolsandPlants Transactions")));
          }),
        ),
      ],
    ),
  );
}

//LABOUR POP UP
Widget Labour_Pop_Up(BuildContext context, List<ListData> siteListData) {
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
                    builder: (context) =>
                        Add_Labours_Assigning_Screen(siteListData)));
          }),
        ),
      ],
    ),
  );
}
