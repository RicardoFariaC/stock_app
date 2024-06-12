import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_app/models/handlers/handlersRepository/identify_handler.dart';
import 'package:stock_app/models/identify.dart';
import 'package:stock_app/pages/widgets/context_button.dart';
import 'package:stock_app/store/login.store.dart';

class WrongIdentifyView extends StatefulWidget {
  final File image;

  const WrongIdentifyView({super.key, required this.image});

  @override
  State<WrongIdentifyView> createState() => _WrongIdentifyViewState();
}

class _WrongIdentifyViewState extends State<WrongIdentifyView> {
  final _formKey = GlobalKey<FormState>();
  final _identify = IdentifyModel();

  void _submitForm() {
    final store = Provider.of<LoginStore>(context, listen: false);
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
    _handleIdentify(store.bearerToken).then(
      (value) {
        if(value) {
          AlertDialog alert = AlertDialog(
            title: Text("Identificação"),
            content: Text("A correção foi enviada com sucesso!"),
          );
          showDialog(context: context, builder: (context) => alert,);
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/home",
                (route) => false,
          );
          return;
        }
        AlertDialog alert = AlertDialog(
          title: Text("Identificação"),
          content: Text("Houve um erro ao enviar as informações!"),
        );
        showDialog(context: context, builder: (context) => alert,);
        Navigator.of(context).pushNamedAndRemoveUntil(
          "/home",
              (route) => false,
        );
      },
    );
  }

  Future<bool> _handleIdentify(String token) async {
    _identify.image = widget.image;
    Response res = await postIdentifiedSpecies(_identify, token);
    if(res.data != null) {
      return true;
    }
    return false;
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Nos corrija!",
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withAlpha(20),
                          blurRadius: 10,
                          spreadRadius: 5)
                    ],
                    color: const Color.fromARGB(255, 160, 233, 173),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 280,
                        width: 280,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            widget.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    onSaved: (newValue) {
                      _identify.name = newValue ?? "";
                    },
                    validator: (value) {
                      String name = value ?? "";
                      if (name.isEmpty) {
                        return "O campo de nome está vazio.";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * .065,
                          maxWidth: MediaQuery.of(context).size.width),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.drive_file_rename_outline_rounded,
                          size: 18,
                        ),
                        onPressed: () {},
                      ),
                      contentPadding: EdgeInsets.only(top: 12, left: 12),
                      filled: true,
                      fillColor: Theme.of(context)
                          .appBarTheme
                          .backgroundColor!
                          .withAlpha(80),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Theme.of(context)
                                .appBarTheme
                                .backgroundColor!
                                .withAlpha(10),
                            width: 1,
                          )),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ContextButton(
                  icon: const Icon(Icons.check_rounded),
                  onPressed: _submitForm,
                  text: Text("Enviar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
