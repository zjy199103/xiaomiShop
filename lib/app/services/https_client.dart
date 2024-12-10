import 'package:dio/dio.dart';

class HttpClient {

  static String domain = 'https://miapp.itying.com/';

  static Dio dio = Dio();

  HttpClient() {
    dio.options.baseUrl = domain;
    dio.options.connectTimeout = const Duration(milliseconds: 5000);
    dio.options.receiveTimeout = const Duration(milliseconds: 5000); 
  }

  Future get(apiUrl, {Map<String, dynamic>? params}) async {
    try {
      var response = await dio.get(domain + apiUrl, queryParameters: params);
      return response;
    } catch (e) { 
      return null;
    }
  }

  static replaceUri(String picUrl) {
    String tempUrl = domain + picUrl;
    return tempUrl.replaceAll('\\', '/');
  }

}
