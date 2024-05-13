import "package:dio/dio.dart";

String api_url = "secret";
String baseURL = "http://$api_url:8080";

BaseOptions options = BaseOptions(
  baseUrl: baseURL,
  headers: { "content-type": "application/json" }
);

Dio api = Dio(options);