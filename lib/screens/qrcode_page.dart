import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:navbrasil_spat/commom/mycolors.dart';
import 'package:navbrasil_spat/models/equipment.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({Key? key}) : super(key: key);

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  String _scanBarcode = '';

  List<Equipment> listEquipment = [];
  final List<Equipment> listEquipmentOffline = [
    Equipment(
      id: '10301469',
      name: 'Computador EMS',
      description: 'Computador HP Compaq 8200 Preto',
      state: '-',
      location: 'Estação Rádio',
    ),
    Equipment(
      id: '10320982',
      name: 'Monitor EMS 23" Ultra HD Com Drivers Novos e Bacana',
      description: 'Monitor Dell Preto 17 Polegadas',
      state: 'OK',
      location: 'Estação Rádio',
    ),
    Equipment(
      id: '1',
      name: 'Monitor EMS',
      description: 'Monitor Dell Preto 17 Polegadas',
      state: 'OK',
      location: 'EMS',
    ),
    Equipment(
      id: '2',
      name: 'Monitor EMS',
      description: 'Monitor Dell Preto 17 Polegadas',
      state: '-',
      location: 'Depósito',
    ),
    Equipment(
      id: '3',
      name: 'Monitor EMS',
      description: 'Monitor Dell Preto 17 Polegadas',
      state: '-',
      location: 'Copa',
    ),
    Equipment(
      id: '4',
      name: 'Monitor EMS',
      description: 'Monitor Dell Preto 17 Polegadas',
      state: '-',
      location: 'Copa',
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
      location: 'Chefia',
    ),
    Equipment(
      id: '7',
      name: 'Monitor EMS',
      description: 'Monitor Dell Preto 17 Polegadas',
      state: '-',
      location: 'KT',
    ),
    Equipment(
      id: '8',
      name: 'Monitor EMS',
      description: 'Monitor Dell Preto 17 Polegadas',
      state: 'OK',
      location: 'KT',
    ),
    Equipment(
      id: '9',
      name: 'Monitor EMS',
      description: 'Monitor Dell Preto 17 Polegadas',
      state: '-',
      location: 'Banheiros',
    ),
    Equipment(
      id: '10',
      name: 'Monitor EMS',
      description: 'Monitor Dell Preto 17 Polegadas',
      state: 'OK',
      location: 'Administração',
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
    final String sectorName =
        ModalRoute.of(context)!.settings.arguments as String;

    for (var i = 0; i < listEquipmentOffline.length; i++) {
      if (sectorName == listEquipmentOffline[i].location) {
        listEquipment.add(listEquipmentOffline[i]);
      }
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [MyColors.topBackground, MyColors.baseBackground],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'NAV Brasil - $sectorName',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: List.generate(
                  listEquipment.length,
                  (int index) {
                    Equipment equipment = listEquipment[index];
                    return Container(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                      child: ListTile(
                        tileColor: equipment.state == 'OK'
                            ? MyColors.navLightGreen
                            : MyColors.lightRed,
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(6)),
                          side: BorderSide(
                              width: 2,
                              color: equipment.state == 'OK'
                                  ? MyColors.navGreen
                                  : MyColors.mediumRed),
                        ),
                        dense: false,
                        contentPadding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                        title: Text('${equipment.id} - ${equipment.name}'),
                        titleTextStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                        subtitle: Text(equipment.description),
                        trailing: equipment.state == 'OK'
                            ? const Text(
                                "OK",
                              )
                            : const Text(
                                "Conferir",
                              ),
                        onLongPress: () {
                          debugPrint("Editar patrimonio ${equipment.id}");
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: ElevatedButton.icon(
          onPressed: () => scanQR(),
          icon: const Icon(Icons.qr_code),
          label: const Text('Conferir'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            backgroundColor: MyColors.navGreen,
            foregroundColor: MyColors.baseBackground,
          ),
        ),
      ),
    );
  }
}
