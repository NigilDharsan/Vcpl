import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcpl/Src/Models/LoginModel.dart';
import 'package:vcpl/Src/Utilits/ConstantsApi.dart';
import 'package:vcpl/Src/Utilits/Services.dart';

final apiServiceProvider = Provider((ref) => Api(ref.read(dioProvider)));
// final fetchDataProvider = FutureProvider.autoDispose(
//     (ref) => ref.watch(apiServiceProvider).fetchData());
final postDataProvider =
    FutureProvider.autoDispose.family<LoginModel, FormData>(
  (ref, body) => ref
      .watch(apiServiceProvider)
      .login<LoginModel>(ConstantApi.loginUrl, body),
);
