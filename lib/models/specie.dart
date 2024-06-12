
import 'package:stock_app/models/user.dart';

class Specie {
  late final int id;
  late final String image;
  late final String name;
  late final String specie;
  late final String description;
  late final User registeredBy;
  late final String createdAt;
  late final String updatedAt;

  Specie({
    required this.id,
    required this.name,
    required this.image,
    required this.specie,
    required this.description,
    required this.registeredBy,
    required this.createdAt,
    required this.updatedAt
  });

  Specie.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
    name = json["name"];
    specie = json["specie"];
    description = json["description"];
    registeredBy = User.fromSpecieJson(json["registered_by"]);
  }
}