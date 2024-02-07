import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vcpl/Src/Utilits/Common_Colors.dart';

final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
String? accesstokens = 'accessToken';
String? userId = 'user_id';
String Storage = 'storage';
String? routes = "routes_Log";

AndroidOptions _androidOptions() => AndroidOptions();
IOSOptions _getIOSOptions() => IOSOptions(
      accountName: Storage,
    );

void deleteAll() async {
  await _secureStorage.deleteAll(iOptions: _getIOSOptions());
}

accessToken(dynamic val) async {
  await _secureStorage.write(
      key: accesstokens!, value: val, aOptions: _androidOptions());
  print("val!:$val" + "$accesstokens");
}

Future<dynamic> getToken() async {
  final String? gettoken = await _secureStorage.read(
      key: accesstokens!, aOptions: _androidOptions());
  print("valu:$gettoken");
  return gettoken ?? "";
}

userID(dynamic val) async {
  await _secureStorage.write(
      key: userId!, value: val.toString(), aOptions: _androidOptions());
  print("value!:${val!}" + "$userId");
}

Future<dynamic> getUserID() async {
  dynamic user_id =
      await _secureStorage.read(key: userId!, aOptions: _androidOptions());
  print("valuesss:$user_id");
  return user_id;
}

Routes(dynamic val) async {
  await _secureStorage.write(
      key: routes!, value: val!, aOptions: _androidOptions());
  print("valuesss:$routes");
  return routes;
}

Future<dynamic> getRoutes() async {
  dynamic routes_Log =
      await _secureStorage.read(key: routes!, aOptions: _androidOptions());
  print("valuesss:$routes_Log");
  return routes_Log;
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

void ShowToastMessage(String message) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0);

class GetterSetter {
  String? _myValue;

  String get myValue {
    return _myValue ?? "";
  }

  set myValue(String value) {
    _myValue = value;
  }
}

class SingleTon {
  static final SingleTon qwerty = SingleTon._internal();
  factory SingleTon() {
    return qwerty;
  }
  SingleTon._internal();

  String setLocation = "";
  String lattidue = "";
  String longitude = "";
  File? setPdf;
  bool isLoading = true;
}

void showBottomLoader(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return const SizedBox(
        height: 200.0, // You can customize the height as needed
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
}

Widget buildLoadingIndicator() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: SpinKitWave(
        type: SpinKitWaveType.center,
        size: 50,
        itemBuilder: (_, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? blue1 : Colors.black,
            ),
          );
        },
      ),
    ),
  );
}

// Future<List<int>> compressImage(File file) async {
//   var result = await FlutterImageCompress.compressWithFile(
//     file.absolute.path,
//     quality: 25, // Adjust the quality as needed (0 to 100)
//   );

//   if (result == null) {
//     throw Exception('Failed to compress image');
//   }

//   return result;
// }


// Future<void> readall() async{
// final all =await _secureStorage.readAll(aOptions: _androidOptions());
// }

// void tokenVal(tokens, farmerId) async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString("tokenval", tokens);
//   await prefs.setInt("farmerID", farmerId);
//   final _tokenval = await prefs.getString("tokenval");
//   final _idVal = await prefs.getInt("farmerID");
//   print(_tokenval);
//   print(_idVal);
// }


