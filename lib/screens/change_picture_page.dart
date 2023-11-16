import 'dart:io';

import 'package:flutter/material.dart';
import 'package:navbrasil_spat/commom/mycolors.dart';
import 'package:navbrasil_spat/models/equipment.dart';
import 'package:navbrasil_spat/screens/preview_page.dart';
import 'package:navbrasil_spat/widgets/anexo.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ChangePicturePage extends StatefulWidget {
  const ChangePicturePage({super.key});

  @override
  State<ChangePicturePage> createState() => _ChangePicturePageState();
}

class _ChangePicturePageState extends State<ChangePicturePage> {
  File? arquivo;
  final picker = ImagePicker();

  Future getFileFromGallery(equipment) async {
    XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if ((file != null) && (await verifyPermission())) {
      final targetPath = await _localPath;
      file.saveTo('$targetPath/${equipment.id}.jpg');
      equipment.image = '$targetPath/${equipment.id}.jpg';
      setState(() => arquivo = File(file.path));
    }
  }

  static verifyPermission() async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      debugPrint('Opening Storage...');
      return true;
    } else {
      openAppSettings(); //Abre as configurações do APP no Android
      debugPrint('Storage permission denied.');
      return false;
    }
  }

  showPreview(file, equipment) async {
    File? arq = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewPage(file: file),
      ),
    );

    if (arq != null) {
      setState(() async {
        arquivo = arq;
        // Corrigir salvamento
        final targetPath = _localPath;
        file.saveTo('$targetPath/${equipment.id}.jpg');
        equipment.image = '$targetPath/${equipment.id}.jpg';
        Navigator.of(context).pop();
      });

      // if (!context.mounted) return;
    }
  }

  Future<String?> get _localPath async {
    final directory = await getExternalStorageDirectory();
    return directory?.path;
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (arquivo != null) Anexo(arquivo: arquivo!),
              ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraCamera(
                      onFile: (file) => showPreview(file, equipment),
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
                onPressed: () => getFileFromGallery(equipment),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
