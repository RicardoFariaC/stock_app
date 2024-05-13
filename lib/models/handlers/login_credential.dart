
class LoginCredential {
  late String username;
  late String password;
  String token = "";

  LoginCredential({
    required this.username,
    required this.password,
  });

  LoginCredential.instance();

  Map<String, dynamic> toJson() {
    return <String, dynamic> {
      "username": username,
      "password": password
    };
  }

}