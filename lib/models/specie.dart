
import 'package:stock_app/models/user.dart';

class Specie {
  late final int id;
  late final String image;
  late final String name;
  late final String description;
  late final User registeredBy;
  late final bool isActive;
  late final String createdAt;
  late final String updatedAt;

  Specie({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.registeredBy,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt
  });

  Specie.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    registeredBy = User.fromSpecieJson(json["user"]);
    isActive = json["is_active"];
  }
}