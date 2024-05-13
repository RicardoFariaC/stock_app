import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_app/models/handlers/handlersRepository/login_credential_handler.dart';
import 'package:stock_app/models/handlers/login_credential.dart';
import 'package:stock_app/store/login.store.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _focus = FocusNode();
  final _credential = LoginCredential.instance();

  void _submitForm() {
    final store = Provider.of<LoginStore>(context, listen: false);
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
    _handleAuth().then((value) {
      if (value) {
        store.setBearerToken("Bearer ${_credential.token}");
        store.setUsername(_credential.username);
        Navigator.of(context).pushNamedAndRemoveUntil(
          "/home",
          (route) => false,
        );
      }
    });
  }

  Future<bool> _handleAuth() async {
    Response<dynamic> response = await authenticate(_credential);
    if (response.data != null) {
      _credential.token = response.data["token"];
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/stock_logo.png",
                    height: 80, color: Colors.green),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                      hintText: 'Nome de usuário',
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_focus);
                    },
                    validator: (_username) {
                      final username = _username ?? "";
                      if (username.isEmpty) {
                        return "O campo de nome de usuário está vazio.";
                      }
                      return null;
                    },
                    onSaved: (username) {
                      _credential.username = username ?? "";
                    }),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  focusNode: _focus,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    hintText: 'Senha',
                  ),
                  validator: (_senha) {
                    final senha = _senha ?? "";
                    if (senha.isEmpty) {
                      return "O campo de senha está vazia";
                    }

                    if (senha.length < 6) {
                      return "A senha precisa ter mais de 6 digitos.";
                    }

                    return null;
                  },
                  onFieldSubmitted: (_) => _submitForm(),
                  onSaved: (pass) => _credential.password = pass ?? "",
                ),
                const SizedBox(
                  height: 15,
                ),
                FilledButton(
                  onPressed: _submitForm,
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.login),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Entrar"),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/registration");
                  },
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  child: Text(
                    "Registrar-se",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
