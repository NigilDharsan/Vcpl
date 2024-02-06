import 'package:flutter/material.dart';

import '../utilits/Common_Colors.dart';
import '../utilits/Text_Style.dart';




// ELEVATED BUTTON
Widget CommonElevatedButton(
  BuildContext context,
  String titleName,
  void Function()? onPress,
){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: blue3,
      minimumSize: Size(double.infinity, 50),
      elevation: 9,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    onPressed: onPress,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        titleName,
        style: ButtonT,textAlign: TextAlign.center,
      ),
    ),
  );
}







//CALL NOW BOTTON
Widget callNow_Button(
    BuildContext context,
    String titleName,

{required void Function()? onPress,required Color? backgroundColor}
    ) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      minimumSize: Size(double.infinity, 30),
      // elevation: 9,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
    onPressed: onPress,
    child: Text(
      titleName,
      style: ButtonT1,
    ),
  );
}

