import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vcpl/Src/Common_Widgets/Common_Button.dart';
import 'package:vcpl/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:vcpl/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:vcpl/Src/Utilits/Common_Colors.dart';
import 'package:vcpl/Src/Utilits/Text_Style.dart';

class Add_Shop_Transaction_Screen extends StatefulWidget {
  const Add_Shop_Transaction_Screen({super.key});

  @override
  State<Add_Shop_Transaction_Screen> createState() => _Add_Shop_Transaction_ScreenState();
}

class _Add_Shop_Transaction_ScreenState extends State<Add_Shop_Transaction_Screen> {
  String? trnsactionType;
  List<String> TransactionOtion = [
    "Issued to Site",
    "Transfer Shop Items",
    "Received Shop Items",
  ];

  String? workTypeOption;
  List<String> workTypeVal = [
    "VKT Godown",
    "Suresh Complex",
    "Codissia Hub",
    "KCT",
    "Promod Complex",
    "PSGR S BLOCK",
    "KCN BOYS HOSTEL",
    "EPPINGER",
    "SARAYU SCHOOL",
  ];

  String? vechileNumber;
  List<String> vechileNumberOtion = [
    "TN 37 CC 2683",
    "TN 37 CC 2683",
    "TN 37 CC 2683",
  ];

  TextEditingController _Bags = TextEditingController();
  TextEditingController _Purpose = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white3,
      appBar: Custom_AppBar(title: "Add Shop Transactions", actions: null, isBlue: true, isNav: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Column(
            children: [
              //TRANSACTION TYPE
              Title_Style(Title: 'Transaction Type', isStatus: true),
              dropDownField(
                context,
                value: trnsactionType,
                listValue: TransactionOtion,
                onChanged: (String? newValue) {
                  setState(() {
                    trnsactionType = newValue;
                  });
                }, hint: 'Site Name',
              ),

              //ISSUED TYPE
              Column(
                children: [
                  //BAGS QUANTITY
                  trnsactionType == null?Container():Title_Style(Title: 'Quantity ', isStatus: true),
                  trnsactionType == null?Container():textFormField2(
                    // isEnabled: false,
                      hintText: "Enter Bags Quantity",
                      keyboardtype: TextInputType.phone,
                      Controller: _Bags,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly],
                      onChanged: null,
                      validating:(value){
                        if (value!.isEmpty) {
                          return 'Please Enter Bags Quantity';
                        } else if (value==null) {
                          return 'Please Enter Bags Quantity';
                        }
                        return null;
                      }
                  ),

                  //BAGS QUANTITY
                  trnsactionType == "Issued to Site"? Title_Style(Title: 'Purpose ', isStatus: true):Container(),
                  trnsactionType == "Issued to Site"? textFormField2(
                    // isEnabled: false,
                      hintText: "Enter Purpose",
                      keyboardtype: TextInputType.text,
                      Controller: _Purpose,
                      inputFormatters: null,
                      onChanged: null,
                      validating:(value){
                        if (value!.isEmpty) {
                          return 'Please Enter Purpose';
                        } else if (value==null) {
                          return 'Please Enter Purpose';
                        }
                        return null;
                      }
                  ):Container(),
                ],
              ),
              //TRANSFER CEMENT
              Column(
                children: [
                  // Site Name
                  trnsactionType == "Transfer Shop Items"?  Title_Style(Title: 'To Site Name  ', isStatus: true):Container(),
                  trnsactionType == "Transfer Shop Items"?dropDownField(
                    context,
                    value: workTypeOption,
                    listValue: workTypeVal,
                    onChanged: (String? newValue) {
                      setState(() {
                        workTypeOption = newValue;
                      });
                    }, hint: 'Select To Site',
                  ):Container(),

                  //SLIP NUMBER
                  trnsactionType == "Transfer Shop Items"?Title_Style(Title: 'Transfer Slip Number  ', isStatus: true):Container(),
                  trnsactionType == "Transfer Shop Items"?textFormField2(
                    // isEnabled: false,
                      hintText: "Enter Transfer Slip Number ",
                      keyboardtype: TextInputType.phone,
                      Controller: _Bags,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly],
                      onChanged: null,
                      validating:(value){
                        if (value!.isEmpty) {
                          return 'Please Enter Transfer Slip Number ';
                        } else if (value==null) {
                          return 'Please Enter Transfer Slip Number ';
                        }
                        return null;
                      }
                  ):Container(),
                  //VECHILE NUMBER
                  trnsactionType == "Transfer Shop Items"?Title_Style(Title: 'Vehicle No  ', isStatus: true):
                  trnsactionType == "Received Shop Items"?Title_Style(Title: 'Vehicle No  ', isStatus: true):Container(),
                  trnsactionType == "Transfer Shop Items"? dropDownField(
                    context,
                    value: vechileNumber,
                    listValue: vechileNumberOtion,
                    onChanged: (String? newValue) {
                      setState(() {
                        vechileNumber = newValue;
                      });
                    }, hint: 'Select Vechile',
                  ):
                  trnsactionType == "Received Shop Items"?dropDownField(
                    context,
                    value: vechileNumber,
                    listValue: vechileNumberOtion,
                    onChanged: (String? newValue) {
                      setState(() {
                        vechileNumber = newValue;
                      });
                    }, hint: 'Select Vechile',
                  ):Container(),
                ],
              ),
              //RECEIVED CEMENT
              Column(
                children: [

                  //GRADE AND BRAND
                  trnsactionType == "Received Shop Items"?Title_Style(Title: 'Grade and Brand ', isStatus: true):Container(),
                  trnsactionType == "Received Shop Items"?textFormField2(
                    // isEnabled: false,
                      hintText: "Entre Grade and Brand",
                      keyboardtype: TextInputType.text,
                      Controller: _Bags,
                      inputFormatters: null,
                      onChanged: null,
                      validating:(value){
                        if (value!.isEmpty) {
                          return 'Please Enter Grade and Brand';
                        } else if (value==null) {
                          return 'Please Enter Grade and Brand';
                        }
                        return null;
                      }
                  ):Container(),
                ],
              ),
              //SUBMIT BUTTON
              Padding(
                padding: const EdgeInsets.only(bottom: 100,top: 100,left: 30,right: 30),
                child: CommonElevatedButton(context, 'Submit', () {

                }),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
