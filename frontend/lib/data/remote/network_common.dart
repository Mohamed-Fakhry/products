import 'dart:convert';

import 'package:dio/dio.dart';

class NetworkCommon {
  static final NetworkCommon _singleton = NetworkCommon._internal();
  static const String baseUrl = "http://localhost:3000/";

  factory NetworkCommon() {
    return _singleton;
  }

  NetworkCommon._internal();

  Dio get dio {
    Dio dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
    return dio;
  }
}
