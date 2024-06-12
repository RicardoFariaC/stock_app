import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stock_app/models/handlers/handlersRepository/register_credential_handler.dart';
import 'package:stock_app/models/handlers/register_credential.dart';
import 'package:string_validator/string_validator.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocus = FocusNode();
  final _confirmEmailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();
  final _credential = RegisterCredential.instance();
  final confirmEmailController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void _submitForm() {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();

    _handleAuth().then((value) {
      if (value) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          "/",
              (route) => false,
        );
      }
    });
  }

  Future<bool> _handleAuth() async {
    Response<dynamic> response = await register(_credential);
    if (response.data != null) {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    confirmPasswordController.dispose();
    confirmEmailController.dispose();
    _confirmEmailFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registrar-se")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/stock_logo.png",
                      height: 80, color: Colors.green),
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
                        FocusScope.of(context).requestFocus(_emailFocus);
                      },
                      validator: (user) {
                        final username = user ?? "";
                        if (username.isEmpty) {
                          return "O campo de nome de usuário está vazio.";
                        }
                        return null;
                      },
                      onSaved: (username) {
                        _credential.username = username ?? "";
                      }),
                  Divider(),
                  TextFormField(
                    focusNode: _emailFocus,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0))),
                      hintText: 'Email',
                    ),
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_confirmEmailFocus),
                    validator: (value) {
                      final email = value ?? "";
                      if(email.isEmpty) return "O campo de email está vazio";
                      if(!isEmail(email)) return "Digite um email válido";
                      if(confirmEmailController.text != email) return "Os emails não correspondem";
                      return null;
                    },
                    onSaved: (email) {
                      _credential.email = email ?? "";
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: confirmEmailController,
                    focusNode: _confirmEmailFocus,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0))),
                      hintText: 'Confirmar email',
                    ),
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_passwordFocus),
                    validator: (value) {
                      final email = value ?? "";
                      if(email.isEmpty) return "O campo de email está vazio";
                      if(!isEmail(email)) return "Digite um email válido";
                      return null;
                    },
                  ),
                  Divider(),
                  TextFormField(
                    focusNode: _passwordFocus,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0))),
                      hintText: 'Senha',
                    ),
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_confirmPasswordFocus),
                    validator: (pass) {
                      final senha = pass ?? "";
                      if (senha.isEmpty) {
                        return "O campo de senha está vazia";
                      }
                      if (senha.length < 6) {
                        return "A senha precisa ter mais de 6 digitos.";
                      }
                      if(confirmPasswordController.text != senha) {
                        return "As senhas não correspondem.";
                      }
                      return null;
                    },
                    onSaved: (senha) {
                      _credential.password = senha ?? "";
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    focusNode: _confirmPasswordFocus,
                    controller: confirmPasswordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0))),
                      hintText: 'Confirmar senha',
                    ),
                    validator: (pass) {
                      final senha = pass ?? "";
                      if (senha.isEmpty) {
                        return "O campo de senha está vazia";
                      }
                      if (senha.length < 6) {
                        return "A senha precisa ter mais de 6 digitos.";
                      }
                      return null;
                    },
                  ),
                  Divider(),
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
                          Icon(Icons.app_registration_rounded),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Registrar-se"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
