import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stock_app/pages/views/specie_identified_view.dart';
import 'package:stock_app/pages/widgets/context_button.dart';

class RedirectView extends StatefulWidget {
  const RedirectView({super.key});

  @override
  State<RedirectView> createState() => _RedirectViewState();
}

class _RedirectViewState extends State<RedirectView> {
  File? arquivo;
  final picker = ImagePicker();

  Future<bool> getFileFromGallery() async {
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() => arquivo = File(file.path));
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double phoneScale = MediaQuery.of(context).textScaler.scale(1);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ContextButton(
              text: Text(
                "Use sua câmera para identificar alguma espécie.",
                softWrap: true,
                maxLines: 2,
                style: TextStyle(
                  fontSize: phoneScale < 1.0
                      ? 20
                      : phoneScale < 1.5
                          ? 14
                          : 10,
                ),
              ),
              icon: const Icon(Icons.camera_alt_rounded),
              onPressed: () {
                Navigator.pushNamed(context, "/camera");
              },
            ),
            SizedBox(
              height: 10,
            ),
            ContextButton(
              text: Text(
                "Acesse fotos de seu armazenamento para identificar.",
                softWrap: true,
                maxLines: 2,
                style: TextStyle(
                  fontSize: phoneScale < 1.0
                      ? 20
                      : phoneScale < 1.5
                          ? 14
                          : 10,
                ),
              ),
              icon: Icon(Icons.file_upload_rounded),
              onPressed: () {
                getFileFromGallery();
              },
            ),
            SizedBox(
              height: 10,
            ),
            if (arquivo != null) ...[
              ContextButton(
                icon: Icon(Icons.batch_prediction_rounded),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        SpecieIdentifiedView(filePath: arquivo!),
                  ),
                ),
                text: Text(
                  "Enviar foto escolhida para identificar.",
                  style: TextStyle(
                    fontSize: phoneScale < 1.0
                        ? 20
                        : phoneScale < 1.5
                            ? 14
                            : 10,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
