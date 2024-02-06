import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vcpl/Src/Common_Widgets/Common_Button.dart';
import 'package:vcpl/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:vcpl/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:vcpl/Src/Utilits/Common_Colors.dart';
import 'package:vcpl/Src/utilits/Text_Style.dart';

class Add_Centering_Transaction_Screen extends StatefulWidget {
  const Add_Centering_Transaction_Screen({super.key});

  @override
  State<Add_Centering_Transaction_Screen> createState() => _Add_Centering_Transaction_ScreenState();
}

class _Add_Centering_Transaction_ScreenState extends State<Add_Centering_Transaction_Screen> {
  String? trnsactionType;
  List<String> TransactionOtion = [
    "Issued to Site",
    "Transfer Cement",
    "Received Cement",
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
  TextEditingController _TransferedSlip = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white3,
      appBar: Custom_AppBar(title: "Add Labours Assigning", actions: null, isBlue: true, isNav: true),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
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
                //TO SITE NAME
                Title_Style(Title: 'To Site Name  ', isStatus: true),
                dropDownField(
                  context,
                  value: workTypeOption,
                  listValue: workTypeVal,
                  onChanged: (String? newValue) {
                    setState(() {
                      workTypeOption = newValue;
                    });
                  }, hint: 'Select To Site',
                ),
                //QUANTITY
                Title_Style(Title: 'Quantity  ', isStatus: true),
                textFormField2(
                  // isEnabled: false,
                    hintText: "Enter Quantity",
                    keyboardtype: TextInputType.phone,
                    Controller: _TransferedSlip,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly],
                    onChanged: null,
                    validating:(value){
                      if (value!.isEmpty) {
                        return 'Please Enter Quantity';
                      } else if (value==null) {
                        return 'Please Enter Quantity';
                      }
                      return null;
                    }
                ),
                //TRANSFER SLIP NUMBER
                Title_Style(Title: 'Transfer Slip Number  ', isStatus: true),
                textFormField2(
                  // isEnabled: false,
                    hintText: "Enter Transfer Slip Number ",
                    keyboardtype: TextInputType.phone,
                    Controller: _TransferedSlip,
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
                ),
             //SELECT VECHILE
                Title_Style(Title: 'Vehicle No  ', isStatus: true),
                dropDownField(
                  context,
                  value: vechileNumber,
                  listValue: vechileNumberOtion,
                  onChanged: (String? newValue) {
                    setState(() {
                      vechileNumber = newValue;
                    });
                  }, hint: 'Select Vechile',
                ),

                //SUBMIT BUTTON
                Padding(
                  padding: const EdgeInsets.only(top: 100,left: 30,right: 30),
                  child: CommonElevatedButton(context, 'Submit', () {

                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
