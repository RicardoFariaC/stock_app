// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on _LoginStore, Store {
  late final _$usernameAtom =
      Atom(name: '_LoginStore.username', context: context);

  @override
  String get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  late final _$bearerTokenAtom =
      Atom(name: '_LoginStore.bearerToken', context: context);

  @override
  String get bearerToken {
    _$bearerTokenAtom.reportRead();
    return super.bearerToken;
  }

  @override
  set bearerToken(String value) {
    _$bearerTokenAtom.reportWrite(value, super.bearerToken, () {
      super.bearerToken = value;
    });
  }

  late final _$_LoginStoreActionController =
      ActionController(name: '_LoginStore', context: context);

  @override
  void setUsername(String userLogged) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.setUsername');
    try {
      return super.setUsername(userLogged);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBearerToken(String newBearerToken) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.setBearerToken');
    try {
      return super.setBearerToken(newBearerToken);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
username: ${username},
bearerToken: ${bearerToken}
    ''';
  }
}
