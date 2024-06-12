import 'package:dio/dio.dart';
import 'package:stock_app/constants/api.dart';
import 'package:stock_app/models/specie.dart';

class SpecieRepository {
  late List<Specie> species;

  Future<void> getActiveSpecies(String bearerToken) async {
    var response = await api.get(
      "/api/specie",
      options: Options(headers: {"Authorization": bearerToken}),
    );
    species = (response.data as List).map((e) => Specie.fromJson(e)).toList();
  }
}
