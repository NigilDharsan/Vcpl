import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcpl/Src/Models/LoginModel.dart';
import 'package:vcpl/Src/Models/VehicleModel.dart';
import 'package:vcpl/Src/Utilits/Generic.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

class Api {
  final Dio _dio;

  Api(Dio read, {Dio? dio}) : _dio = dio ?? createDioWithAuth();

  static Dio createDioWithAuth() {
    Dio dio = Dio();

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add bearer token to the headers
        String? accessToken = await getToken();
        if (accessToken != "") {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        return handler.next(options); // continue with the request
      },
      onError: (error, handler) {
        // Do something with error
        return handler.next(error); // continue with the error
      },
    ));

    return dio;
  }

  T _fromJson<T>(dynamic json) {
    if (json != null) {
      if (T == LoginModel) {
        return LoginModel.fromJson(json) as T;
      } else if (T == VehicleModel) {
        return VehicleModel.fromJson(json) as T;
      }
    }

    // Add more conditionals for other model classes as needed
    throw Exception("Unknown model type");
  }

  Future<T> _requestPOST<T>(
    String path, {
    FormData? data,
  }) async {
    try {
      final response = await _dio.post(path, data: data);

      return _fromJson<T>(response.data);
    } on DioException catch (e) {
      return _fromJson<T>(e.response?.data);
    } catch (e) {
      throw e;
    }
  }

  Future<T> post<T>(String path, FormData data) async {
    return _requestPOST<T>(path, data: data);
  }

  Future<T> post1<T>(String path) async {
    return _requestPOST<T>(path);
  }

  Future<T> postData<T>(FormData body) async {
    try {
      final response = await _dio.post('YOUR_POST_API_ENDPOINT', data: body);
      return response.data;
    } catch (error) {
      throw error; // Handle error accordingly
    }
  }

  Future<T> login<T>(String path, FormData data) async {
    try {
      Dio dio = Dio();
      Response response = await dio.post(path, data: data);
      return _fromJson<T>(response.data);
    } on DioException catch (e) {
      return _fromJson<T>(e.response?.data);
    } catch (error) {
      throw Exception('Error logging in: $error');
    }
  }
}
