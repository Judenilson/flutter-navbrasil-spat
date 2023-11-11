import 'package:flutter/material.dart';
import 'package:navbrasil_spat/commom/mycolors.dart';
import 'package:navbrasil_spat/models/equipment.dart';
import 'package:navbrasil_spat/screens/qrcode_page.dart';

class SectorPage extends StatefulWidget {
  const SectorPage({super.key});

  @override
  State<SectorPage> createState() => _SectorPageState();
}

class _SectorPageState extends State<SectorPage> {
  final List<Equipment> listEquipment = [];
  final List<String> listSectors = [];

  //0 entidade
  //1 nr_patrimonio
  //2 imagem
  //3 Dependência
  //4 proprietario
  //5 vinculado
  //6 descricao_bem
  //7 valor
  //8 localizacao
  //9 matricula
  //10 responsavel
  //11 Tipo Bem
  //12 Situação do Bem
  //13 Observações

  @override
  Widget build(BuildContext context) {
    final List<List<dynamic>> data =
        ModalRoute.of(context)!.settings.arguments as List<List<dynamic>>;

    for (var i in data) {
      listEquipment.add(Equipment(
          id: i[1].toString(),
          name: i[6].toString(),
          description: i[13],
          location: (i[8] == "") ? "INDEFINIDO" : i[8],
          state: ""));
      bool putItem = true;
      for (var j = 0; j < listSectors.length; j++) {
        if (i[8] == listSectors[j] || i[8] == "") {
          putItem = false;
          break;
        }
      }
      if (putItem) {
        listSectors.add(i[8]);
      }
    }

    debugPrint(listSectors.toString());
    debugPrint(listSectors.length.toString());

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'SETORES',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: listSectors.length,
          itemBuilder: (context, int index) {
            final item = listSectors[index];
            return Card(
              child: ListTile(
                title: Text(item),
                splashColor: MyColors.navLightBlue,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QRCodePage(),
                      settings: RouteSettings(arguments: item),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
