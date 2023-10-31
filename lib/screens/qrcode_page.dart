import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:navbrasil_spat/models/equipment.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({Key? key}) : super(key: key);

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  String _scanBarcode = '';

  final List<Equipment> listEquipment = [
    Equipment(
      id: '10301469',
      name: 'Computador EMS',
      description: 'Computador HP Compaq 8200 Preto',
      state: '-',
      location: 'Estação Rádio',
    ),
    Equipment(
      id: '10320982',
      name: 'Monitor EMS',
      description: 'Monitor Dell Preto 17 Polegadas',
      state: '-',
      location: 'Estação Rádio',
    ),
    Equipment(
      id: '1',
      name: 'Monitor EMS',
      description: 'Monitor Dell Preto 17 Polegadas',
      state: 'OK',
      location: 'Estação Rádio',
    ),
    Equipment(
      id: '2',
      name: 'Monitor EMS',
      description: 'Monitor Dell Preto 17 Polegadas',
      state: '-',
      location: 'Estação Rádio',
    ),
    Equipment(
      id: '3',
      name: 'Monitor EMS',
      description: 'Monitor Dell Preto 17 Polegadas',
      state: '-',
      location: 'Estação Rádio',
    ),
    Equipment(
      id: '4',
      name: 'Monitor EMS',
      description: 'Monitor Dell Preto 17 Polegadas',
      state: '-',
      location: 'Estação Rádio',
    ),
    Equipment(
      id: '5',
      name: 'Monitor EMS',
      description: 'Monitor Dell Preto 17 Polegadas',
      state: '-',
      location: 'Estação Rádio',
    ),
    Equipment(
      id: '6',
      name: 'Monitor EMS',
      description: 'Monitor Dell Preto 17 Polegadas',
      state: '-',
      location: 'Estação Rádio',
    ),
    Equipment(
      id: '7',
      name: 'Monitor EMS',
      description: 'Monitor Dell Preto 17 Polegadas',
      state: '-',
      location: 'Estação Rádio',
    ),
    Equipment(
      id: '8',
      name: 'Monitor EMS',
      description: 'Monitor Dell Preto 17 Polegadas',
      state: 'OK',
      location: 'Estação Rádio',
    ),
    Equipment(
      id: '9',
      name: 'Monitor EMS',
      description: 'Monitor Dell Preto 17 Polegadas',
      state: '-',
      location: 'Estação Rádio',
    ),
    Equipment(
      id: '10',
      name: 'Monitor EMS',
      description: 'Monitor Dell Preto 17 Polegadas',
      state: 'OK',
      location: 'Estação Rádio',
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancelar', true, ScanMode.QR);
      debugPrint(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // Se o widget foi removido da árvore enquanto a mensagem da plataforma assíncrona
    //estava em trânsito, queremos descartar a resposta em vez de chamar setState para
    //atualizar nossa aparência inexistente.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      if (_scanBarcode != '-1') {
        _showScanAlert();
      }
    });
  }

  Future<void> _showScanAlert() async {
    var asset =
        listEquipment.singleWhere((element) => element.id == _scanBarcode);
    asset.state = 'OK';

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Escaneado'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                if (_scanBarcode != '')
                  Column(children: [
                    Text(
                      'Plaqueta $_scanBarcode',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Nome: ${asset.name}'),
                  ])
                else
                  const Text(
                    'Erro de Leitura, tente novamente',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              'NAV Brasil - SPAT',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              'Estação Rádio',
              style: TextStyle(
                color: Colors.lightGreenAccent[400],
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        toolbarHeight: 72,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(32),
          ),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: () => scanQR(),
                icon: const Icon(Icons.qr_code),
                label: const Text('Checar Plaqueta'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  listEquipment.length,
                  (int index) {
                    Equipment equipment = listEquipment[index];
                    return Container(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                      child: ListTile(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        dense: false,
                        contentPadding: EdgeInsets.zero,
                        title: Text('${equipment.id} - ${equipment.name}'),
                        subtitle: Text(equipment.description),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueGrey[800],
                          child: Text(
                            '${index + 1}',
                          ),
                        ),
                        trailing: equipment.state == 'OK'
                            ? Icon(Icons.check_circle, color: Colors.lightGreenAccent[400],)
                            : Icon(Icons.error_outline, color: Colors.redAccent[700],),
                        onLongPress: () {
                          debugPrint("Editar patrimonio ${equipment.id}");
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
