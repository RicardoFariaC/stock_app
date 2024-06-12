import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:stock_app/constants/api.dart';
import 'package:stock_app/models/identify.dart';

Future<Response> postIdentifiedSpecies(
    IdentifyModel model, String bearerToken) async {
  var formData = FormData.fromMap(
    {
      'name': model.name,
      'file': await MultipartFile.fromFile(
        model.image.path,
        filename: model.image.path.split("/").last
      )
    },
  );
  try {
    Response res = await api.post("/api/specie/identify",
        data: formData,
        options: Options(headers: {
          "Authorization": bearerToken,
          'Content-Type': 'multipart/form-data'
        }));
    return res;
  } catch (e) {
    return Response(
      data: <String, dynamic>{"exception": e.toString()},
      requestOptions: RequestOptions(),
    );
  }
}
