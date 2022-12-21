import 'package:dio/dio.dart';

class Diohealper{
  static Dio dio=Dio(
    BaseOptions(
      baseUrl: 'https://newsapi.org/',
      receiveDataWhenStatusError: true,
    )

  );
  static Future<Response> getdate({url,data})async{
    return dio.get(
      url,
      queryParameters: data,
    );
  }

}