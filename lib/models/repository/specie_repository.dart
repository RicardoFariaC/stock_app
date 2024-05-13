

import 'package:dio/dio.dart';
import 'package:stock_app/constants/api.dart';
import 'package:stock_app/models/specie.dart';
class SpecieRepository {
  late List<Specie> species;

  Future<void> getActiveSpecies() async {
    Response<Specie> response = await api.get("/api/species");
    species = (response.data as List)
        .map((e) => Specie.fromJson(e))
        .toList();
  }
}
