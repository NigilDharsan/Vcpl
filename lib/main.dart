import 'package:flutter/material.dart';

import 'Src/Add_Transaction_Ui/Add_Cement_Transaction_Screen.dart';
import 'Src/Add_Transaction_Ui/Add_Centering_Transactions_Screen.dart';
import 'Src/Add_Transaction_Ui/Add_Labours_Assigning_Screen.dart';
import 'Src/Add_Transaction_Ui/Add_Lorry_Transaction_Screen.dart';
import 'Src/Add_Transaction_Ui/Add_Shop_Transactions_Screen.dart';
import 'Src/Add_Transaction_Ui/Add_ToolsandPlants_Transactions_Screen.dart';
import 'Src/Home_Dashboard_Ui/Home_Dashboard_Screen.dart';
import 'Src/Login_Screen_Ui/Login_Screen.dart';
import 'Src/Transaction_History_Ui/Centering_Transaction_Screen.dart';
import 'Src/Transaction_History_Ui/Lorry_Transaction_Screen.dart';
import 'Src/Transaction_History_Ui/Shop_Transaction_Screen.dart';
import 'Src/Transaction_History_Ui/Tools_And_Plant_Transaction_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Login_Screen(),
    );
  }
}


