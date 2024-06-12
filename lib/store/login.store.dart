import 'package:mobx/mobx.dart';

part "login.store.g.dart";

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String username = "Convidado";

  @observable
  String bearerToken = "";

  @action
  void setUsername(String userLogged) {
    username = userLogged;
  }

  @action
  void setBearerToken(String newBearerToken) {
    bearerToken = newBearerToken;
  }
}