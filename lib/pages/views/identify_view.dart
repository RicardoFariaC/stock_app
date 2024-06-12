import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_app/pages/views/specie_identified_view.dart';
import 'package:stock_app/pages/widgets/camera_button.dart';

class IdentifyView extends StatefulWidget {
  const IdentifyView({super.key});

  @override
  State<IdentifyView> createState() => _IdentifyViewState();
}

class _IdentifyViewState extends State<IdentifyView> {
  List<CameraDescription> cameras = [];
  CameraController? _controller;
  XFile? image;
  File? arquivo;
  Size? size;
  double? deviceRatio;
  double? xScale;
  double? yScale;
  int detected = 0;

  @override
  void initState() {
    _loadCameras();
    super.initState();
  }

  _loadCameras() async {
    try {
      cameras = await availableCameras();
      _startCamera();
    } on CameraException catch (e) {
      print(e.description);
    }
  }

  _startCamera() {
    if (cameras.isEmpty) {
      print("Não há cameras encontradas.");
    } else {
      _previewCamera(cameras.first);
    }
  }

  _previewCamera(CameraDescription camera) async {
    final CameraController cameraController = CameraController(
        camera, ResolutionPreset.high,
        enableAudio: false, imageFormatGroup: ImageFormatGroup.jpeg);
    _controller = cameraController;

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print(e.description);
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    deviceRatio = size!.width / size!.height;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: [
          Container(
            color: Theme.of(context).appBarTheme.backgroundColor,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                _arquivoWidget(),
                image != null
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 8),
                              child: FilledButton(
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SpecieIdentifiedView(filePath: arquivo!),
                                  ),
                                ),
                                style: ButtonStyle(
                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.upload_rounded),
                                      Text("Enviar foto"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size!.height * .1,
                            )
                          ],
                        ),
                      )
                    : CameraButton(
                        onPressed: photoShoot,
                      )
              ],
            ),
          ),
          Positioned(
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                    color: Colors.white,
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.black54)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _arquivoWidget() {
    if(image == null) {
      return _cameraPreviewWidget();
    } else {
      setState(() {
        arquivo = File(image!.path);
      });
      return Image.file(
        File(image!.path),
        fit: BoxFit.contain,
      );
    }
  }

  Widget _cameraPreviewWidget() {
    final CameraController? cameraController = _controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return Container();
    } else {
      return CameraPreview(_controller!);
    }
  }

  photoShoot() async {
    final CameraController? cameraController = _controller;
    if (cameraController != null && cameraController.value.isInitialized) {
      try {
        XFile file = await cameraController.takePicture();
        if (mounted) setState(() => image = file);
      } on CameraException catch (e) {
        print(e.description);
      }
    }
  }
}
