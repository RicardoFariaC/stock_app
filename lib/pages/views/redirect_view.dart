import 'package:flutter/material.dart';
import 'package:stock_app/pages/widgets/context_button.dart';

class RedirectView extends StatelessWidget {
  const RedirectView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ContextButton(
            text: Text(
              "Use sua câmera para identificar alguma espécie.",
              softWrap: true,
              maxLines: 2,
            ),
            icon: Icon(Icons.camera_alt_rounded),
            onPressed: () {
              Navigator.pushNamed(context, "/camera");
            },
          ),
          ContextButton(
            text: Text(
              "Acesse fotos de seu armazenamento para identificar.",
              softWrap: true,
              maxLines: 2,
            ),
            icon: Icon(Icons.file_upload_rounded),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
