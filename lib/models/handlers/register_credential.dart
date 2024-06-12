
class RegisterCredential {
  late String username;
  late String email;
  late String confirmEmail;
  late String password;
  late String confirmPassword;

  RegisterCredential({
    required this.username,
    required this.email,
    required this.password
  });

  RegisterCredential.instance();

  Map<String, dynamic> toJson() {
    return <String, dynamic> {
      "username": username,
      "email": email,
      "password": password
    };
  }

}