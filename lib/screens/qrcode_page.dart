import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:navbrasil_spat/commom/mycolors.dart';
import 'package:navbrasil_spat/models/equipment.dart';
import 'package:navbrasil_spat/screens/equipment_page.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({Key? key}) : super(key: key);

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  String _scanBarcode = '';
  List<Equipment> listEquipments = [];
  List<Equipment> listEquipmentSector = [];
  List<Equipment> listEquipmentSectorSort = [];
  int sortStatus = 0;

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

    //Se o widget foi removido da árvore enquanto a mensagem da plataforma assíncrona
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
    var asset = listEquipmentSector
        .singleWhere((element) => element.id == _scanBarcode);
    asset.state = 'OK';
    // debugPrint(asset.state.toString());

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

  void menuSort(int menuChoise) {
    if (menuChoise == 3) {
      listEquipmentSectorSort = listEquipmentSector
          .where((element) => element.state == "OK")
          .toList();
    } else if (menuChoise == 2) {
      listEquipmentSectorSort = listEquipmentSector
          .where((element) => element.state != "OK")
          .toList();
    } else {
      listEquipmentSectorSort = listEquipmentSector;
    }

    setState(() {
      sortStatus = menuChoise;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> args =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    listEquipments = args[1];

    listEquipmentSector =
        listEquipments.where((element) => element.location == args[0]).toList();

    sortStatus == 0 ? menuSort(1) : null;

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
              Text(
                '${args[0]}',
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    width: 10,
                    decoration: BoxDecoration(
                      color: MyColors.topBackground,
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: (sortStatus == 1)
                              ? MyColors.navDarkBlue
                              : Colors.transparent,
                        ),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        menuSort(1);
                      },
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.black),
                      child: const Text('Todos'),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 10,
                    decoration: BoxDecoration(
                      color: MyColors.topBackground,
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: (sortStatus == 2)
                              ? MyColors.navDarkBlue
                              : Colors.transparent,
                        ),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        menuSort(2);
                      },
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.black),
                      child: const Text('Conferir'),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 10,
                    decoration: BoxDecoration(
                      color: MyColors.topBackground,
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: (sortStatus == 3)
                              ? MyColors.navDarkBlue
                              : Colors.transparent,
                        ),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        menuSort(3);
                      },
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.black),
                      child: const Text('Verificados'),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: List.generate(
                  listEquipmentSectorSort.length,
                  (int index) {
                    Equipment equipment = listEquipmentSectorSort[index];
                    return Container(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                      child: ListTile(
                        tileColor: equipment.state == 'OK'
                            ? MyColors.navLightGreen
                            : MyColors.lightRed,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                          side: BorderSide(
                              width: 2,
                              color: equipment.state == 'OK'
                                  ? MyColors.navGreen
                                  : MyColors.mediumRed),
                        ),
                        dense: false,
                        contentPadding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                        title: Text(equipment.name),
                        titleTextStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                        subtitle:
                            Text('${equipment.id} \n${equipment.description}'),
                        trailing: equipment.state == 'OK'
                            ? const Text(
                                "OK",
                              )
                            : const Text(
                                "Conferir",
                              ),
                        onLongPress: () {
                          debugPrint("Editar patrimonio ${equipment.id}");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EquipmentPage(),
                              settings: RouteSettings(
                                arguments: equipment,
                              ),
                            ),
                          ).then((value) => setState((){}));
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
