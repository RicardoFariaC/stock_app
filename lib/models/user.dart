
import 'package:stock_app/models/enums/Roles.dart';

class User {
  late final int id;
  late final String username;
  late final Set<Roles> roles;
  late final bool isActive;
  late final String createdAt;
  late final String updatedAt;

  User.fromSpecieJson(Map<String, dynamic> json) {
    id = json["id"];
    username = json["username"];
  }
}