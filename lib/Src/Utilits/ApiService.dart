import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcpl/Src/Models/LoginModel.dart';
import 'package:vcpl/Src/Models/VehicleModel.dart';
import 'package:vcpl/Src/Utilits/Generic.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.interceptors.add(LogInterceptor(responseBody: true)); // For debugging
  return dio;
});

// final apiServiceProvider = Provider<ApiService>((ref) {
//   final dio = ref.read(dioProvider);
//   return ApiService(dio);
// });
//
// class ApiService {
//   final Dio _dio;
//   ApiService(this._dio);
//
// }

class ApiService {
  final Dio _dio;

  ApiService(Dio read, {Dio? dio}) : _dio = dio ?? createDioWithAuth();

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

  Future<T> _requestGET<T>(String path) async {
    try {
      final response = await _dio.get(path);

      return _fromJson<T>(response.data);
    } on DioException catch (e) {
      return _fromJson<T>(e.response?.data);
    } catch (e) {
      throw e;
    }
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

  Future<dynamic> get<T>(String path) async {
    return _requestGET<T>(path);
  }

  Future<T> post<T>(String path, FormData data) async {
    return _requestPOST<T>(path, data: data);
  }

  Future<T> post1<T>(String path) async {
    return _requestPOST<T>(path);
  }

  // API method for login endpoint without interceptor
  Future<T> login<T>(String path, FormData data) async {
    try {
      Dio dio = Dio();
      Response response = await dio.post(path, data: data);
      return _fromJson<T>(response.data);
    } on DioException catch (e) {
      // Handle DioError, you can log or display an error message.
      // Future.delayed(const Duration(seconds: 2), () {
      // });
      return _fromJson<T>(e.response?.data);
    } catch (error) {
      throw Exception('Error logging in: $error');
    }
  }
}
