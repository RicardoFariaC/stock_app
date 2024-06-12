import 'package:dio/dio.dart';
import 'package:stock_app/constants/api.dart';
import 'package:stock_app/models/handlers/login_credential.dart';
import 'package:stock_app/models/handlers/register_credential.dart';

Future<Response> register(RegisterCredential credentials) async {
  try {
    Response res = await api.post("/auth/register", data: credentials.toJson());
    return res;
  } catch (e) {
    if (e.toString().contains("403")) {
      return Response(
        data: <String, dynamic>{
          "status": "not_registered",
        },
        requestOptions: RequestOptions(),
        statusCode: 401,
      );
    }
    return Response(
      data: <String, dynamic>{"exception": e.toString()},
      requestOptions: RequestOptions(),
    );
  }
}