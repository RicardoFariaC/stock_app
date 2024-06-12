import "package:dio/dio.dart";

String apiUrl = "192.168.31.31";
String baseURL = "http://$apiUrl:8080";

BaseOptions options = BaseOptions(
  baseUrl: baseURL,
  headers: { "content-type": "application/json" }
);

Dio api = Dio(options);