import 'package:dio/dio.dart';
import 'package:shop_app/shared/const.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
    print('Dio Is on !');
  }

  static Future<Response> getDataFromApi(
      {required String path,
      Map<String, dynamic>? query,
      String? lang,
      String? token}) {
    dio!.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    return dio!.get(path, queryParameters: query);
  }

  static Future<Response> sendDataToApi(
      {required String path,
      Map<String, dynamic>? query,
      String? lang,
      String? token,
      dynamic apiData}) {
    dio!.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    return dio!.post(path, data: apiData);
  }
}
