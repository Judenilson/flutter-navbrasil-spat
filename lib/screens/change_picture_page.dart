import 'dart:io';

import 'package:flutter/material.dart';
import 'package:navbrasil_spat/commom/mycolors.dart';
import 'package:navbrasil_spat/models/equipment.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navbrasil_spat/screens/preview_page.dart';
import 'package:navbrasil_spat/widgets/anexo.dart';

class ChangePicturePage extends StatefulWidget {
  const ChangePicturePage({super.key});

  @override
  State<ChangePicturePage> createState() => _ChangePicturePageState();
}

class _ChangePicturePageState extends State<ChangePicturePage> {
  File? arquivo;
  final picker = ImagePicker();

  Future getFileFromGallery() async {
    XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() => arquivo = File(file.path));
    }
  }

  showPreview(file) async {
    File? arq = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewPage(file: file),
      ),
    );

    if (arq != null) {
      setState(() => arquivo = arq);
      if (!context.mounted) return;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Equipment equipment =
        ModalRoute.of(context)!.settings.arguments as Equipment;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, MyColors.baseBackground],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'MUDAR IMAGEM',
              ),
              Image.asset(
                'assets/images/nav_logo.png',
                fit: BoxFit.contain,
                height: 36,
              ),
            ],
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (arquivo != null) Anexo(arquivo: arquivo!),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CameraCamera(
                    onFile: (file) => showPreview(file),
                    resolutionPreset: ResolutionPreset.high,
                  ),
                ),
              ),
              icon: const Icon(Icons.camera_alt),
              label: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Tire uma foto'),
              ),
              style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  textStyle: const TextStyle(
                    fontSize: 18,
                  )),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text('ou'),
            ),
            OutlinedButton.icon(
              icon: const Icon(Icons.attach_file),
              label: const Text('Selecione um arquivo'),
              onPressed: () => getFileFromGallery(),
            ),
          ],
        ),
      ),
    );
  }
}
