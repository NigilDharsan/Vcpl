import 'package:flutter/material.dart';
import 'package:vcpl/Src/Common_Widgets/Common_List.dart';
import 'package:vcpl/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:vcpl/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:vcpl/Src/Utilits/Common_Colors.dart';

class Pending_Transaction_Screen extends StatefulWidget {
  const Pending_Transaction_Screen({super.key});

  @override
  State<Pending_Transaction_Screen> createState() => _Pending_Transaction_ScreenState();
}

class _Pending_Transaction_ScreenState extends State<Pending_Transaction_Screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white1,
      appBar: Custom_AppBar(
      title: 'Pending Transactions',
      actions: null,
      isNav: true,
      isBlue: true,
    ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15,),
            textFormFieldSearchBar(
              keyboardtype: TextInputType.text,
              hintText: "Search ...",
              Controller: null,
              validating: null,
              onChanged: null,
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Pending_Transaction(context,isTag: 'Issued',),
            ),
          ],
        ),
      ),
    );
  }
}
