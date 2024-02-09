import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcpl/Src/Models/CommonListModel.dart';
import 'package:vcpl/Src/Models/CommonModel.dart';
import 'package:vcpl/Src/Models/LoginModel.dart';
import 'package:vcpl/Src/Models/VehicleModel.dart';
import 'package:vcpl/Src/Utilits/ConstantsApi.dart';
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
      } else if (T == CommonListModel) {
        return CommonListModel.fromJson(json) as T;
      } else if (T == CommonModel) {
        return CommonModel.fromJson(json) as T;
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
    _dio.options = BaseOptions(
      baseUrl: ConstantApi.SERVER_ONE, // Your base URL
      validateStatus: (status) {
        // Return true if the status code is between 200 and 299 (inclusive)
        // Return false if you want to throw an error for this status code
        return status! >= 200 && status < 300 || status == 404;
      },
    );
    try {
      final response = await _dio.post(path, data: data);

      return _fromJson<T>(response.data);
    } on DioException catch (e) {
      return _fromJson<T>(e.response?.data);
    } catch (e) {
      throw e;
    }
  }

  Future<T> _requestPOST1<T>(String path) async {
    _dio.options = BaseOptions(
      baseUrl: ConstantApi.SERVER_ONE, // Your base URL
      validateStatus: (status) {
        // Return true if the status code is between 200 and 299 (inclusive)
        // Return false if you want to throw an error for this status code
        return status! >= 200 && status < 300 || status == 404;
      },
    );
    try {
      final response = await _dio.post(path);

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
    return _requestPOST1<T>(path);
  }

  // API method for login endpoint without interceptor
  Future<T> login<T>(String path, FormData data) async {
    Dio dio = Dio();

    dio.options = BaseOptions(
      baseUrl: ConstantApi.SERVER_ONE, // Your base URL
      validateStatus: (status) {
        // Return true if the status code is between 200 and 299 (inclusive)
        // Return false if you want to throw an error for this status code
        return status! >= 200 && status < 300 || status == 404;
      },
    );

    try {
      Response response = await dio.post(ConstantApi.loginUrl, data: data);
      // Handle successful response

      print(response.data);
      return _fromJson<T>(response.data);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 404) {
        // Handle 404 error

        print('Resource not found');
        return _fromJson<T>(e.response!.data);
      } else {
        // Handle other Dio errors
        print('Error: ${e.message}');
        throw e;
      }
    }

    // try {
    //   // Make API call using Dio
    //   Dio dio = Dio();

    //   dio.options.headers = {
    //     'Accept': 'application/json',
    //     'Content-Type': 'application/json',
    //   };
    //   dio.options.baseUrl = path;
    //   print(path);

    //   final response = await dio.post(path, data: data);

    //   // Response response = await dio.post(path, data: data);
    //   return _fromJson<T>(response.data);

    //   // Handle successful response
    //   // Do something with response data
    // } catch (e) {
    //   // Handle DioException
    //   if (e is DioError) {
    //     if (e.response?.statusCode == 404) {
    //       // Handle 404 error
    //       print('Resource not found');
    //       return _fromJson<T>(e.response?.data);
    //     } else {
    //       // Handle other Dio errors
    //       print('Error: ${e.message}');
    //       return _fromJson<T>(e.response?.data);
    //     }
    //   } else {
    //     // Handle other types of exceptions
    //     print('Unexpected error: $e');
    //     throw e;
    //   }
    // }

    // try {
    //   Dio dio = Dio();
    //   Response response = await dio.post(path, data: data);
    //   return _fromJson<T>(response.data);
    // } on DioException catch (e) {
    //   return _fromJson<T>(e.response?.data);
    // } catch (error) {
    //   throw Exception('Error logging in: $error');
    // }
  }
}
