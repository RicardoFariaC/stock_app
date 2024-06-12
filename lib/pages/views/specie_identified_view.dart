import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:provider/provider.dart';
import 'package:stock_app/main.dart';
import 'package:stock_app/models/handlers/handlersRepository/identify_handler.dart';
import 'package:stock_app/models/identify.dart';
import 'package:stock_app/pages/views/wrong_identify_view.dart';
import 'dart:developer' as devtools;

import 'package:stock_app/pages/widgets/context_button.dart';
import 'package:stock_app/store/login.store.dart';

class SpecieIdentifiedView extends StatefulWidget {
  final File filePath;

  const SpecieIdentifiedView({
    required this.filePath,
    super.key,
  });

  @override
  State<SpecieIdentifiedView> createState() => _SpecieIdentifiedViewState();
}

class _SpecieIdentifiedViewState extends State<SpecieIdentifiedView> {
  final _identify = IdentifyModel();
  String label = '';
  double confidence = 0.0;
  bool recognized = false;

  Future<void> _tfliteInit() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  _submit() {
    final store = Provider.of<LoginStore>(context, listen: false);
    _identify.image = widget.filePath;
    _identify.name = label;
    sendInfo(store.bearerToken).then(
      (value) {
        if(value) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/home",
                (route) => false,
          );
        }
        Navigator.of(context).pushNamedAndRemoveUntil(
          "/home",
              (route) => false,
        );
      },
    );
  }

  Future<bool> sendInfo(String token) async {
    Response res = await postIdentifiedSpecies(_identify, token);
    if (res.data != null) {
      return true;
    }
    return false;
  }

  recognize() async {
    final XFile imageToRec = XFile(widget.filePath.path);

    var recognition = await Tflite.runModelOnImage(
      path: imageToRec.path,
      imageMean: 0.0,
      imageStd: 1.0,
      numResults: 1,
      threshold: .1,
    );

    if (recognition == null) {
      devtools.log("NULLPTR");
      return;
    }
    devtools.log(recognition.toString());

    setState(() {
      confidence = recognition[0]['confidence'] * 100;
      label = recognition[0]['label'].toString();
      recognized = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _tfliteInit().then((value) => recognize());
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double phoneScale = MediaQuery.of(context).textScaler.scale(1);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withAlpha(20),
                          blurRadius: 10,
                          spreadRadius: 5)
                    ],
                    color: const Color.fromARGB(255, 160, 233, 173),
                    borderRadius: BorderRadius.circular(12)),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 280,
                                width: 280,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    widget.filePath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "A espécie é...",
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: phoneScale < 1.0
                                  ? 16
                                  : phoneScale < 1.5
                                      ? 12
                                      : 10,
                            ),
                          ),
                          Text(
                            toCapitalize(label),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                                fontSize: phoneScale < 1.0
                                    ? 16
                                    : phoneScale < 1.5
                                        ? 12
                                        : 10),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Confiança do resultado: ${confidence.round()}%",
                            style: TextStyle(
                              fontSize: phoneScale < 1.0
                                  ? 12
                                  : phoneScale < 1.5
                                      ? 10
                                      : 8,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "A identificação pode ser imprecisa.",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: phoneScale < 1.0
                                  ? 12
                                  : phoneScale < 1.5
                                      ? 10
                                      : 8,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ContextButton(
                icon: const Icon(Icons.error_rounded),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return WrongIdentifyView(image: widget.filePath);
                    },
                  ));
                },
                text: Text(
                  "A identificação está errada!",
                  style: TextStyle(
                    fontSize: phoneScale < 1.0
                        ? 10
                        : phoneScale < 1.5
                            ? 12
                            : 6,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ContextButton(
                icon: const Icon(Icons.check_rounded),
                onPressed: () {
                  if(recognized) {
                    _submit();
                  }
                },
                text: Text(
                  "O resultado da identificação te satisfez!",
                  style: TextStyle(
                    fontSize: phoneScale < 1.0
                        ? 10
                        : phoneScale < 1.5
                            ? 12
                            : 6,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                child: const Text(
                  "Não sei",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String toCapitalize(String text) {
    List<String> list = text.split(" ");
    String result = '';
    for (int i = 0; i < list.length; i++) {
      for (int j = 0; j < list[0].length; j++) {
        if (j == 0) {
          result += list[i][j].toUpperCase();
        } else {
          result += list[i][j];
        }
      }
    }

    return result;
  }
}
