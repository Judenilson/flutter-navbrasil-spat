// import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:navbrasil_spat/repositories/equipment_repository.dart';
import 'package:navbrasil_spat/screens/sector_page.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  EquipmentRepository repo = EquipmentRepository();
  // bool loadingStatus = false;
  List<List<dynamic>> data = [];
  late List<String> sectors;

  // void loadCSV() async {
  //   final rawData = await rootBundle.loadString('assets/data.CSV');
  //   List<List<dynamic>> listData =
  //       const CsvToListConverter(fieldDelimiter: ';').convert(rawData);
  //   data = listData;

  //   setState(() {
  //     loadingStatus = true;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // repo = EquipmentRepository();
    debugPrint('Iniciado.');
  }

  @override
  Widget build(BuildContext context) {
    // !loadingStatus ? loadCSV() : null;
    // Future<bool> loadingStatus = EquipmentRepository.loadCSV();
    if (EquipmentRepository.dataLoaded) {
      debugPrint("Dados Carregados!");
    }

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Spacer(),
            Image.asset('assets/images/nav_logo.png', width: 180),
            Container(
              height: 20,
            ),
            const Divider(),
            const Text(
              "Sistema de Acompanhamento de Patrimônio",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            const Divider(),
            const Text(
              'Carregando banco de dados...',
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            EquipmentRepository.dataLoaded
                ? const Text('')
                : ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SectorPage(repo: repo),
                          // settings: RouteSettings(arguments: data),
                        ),
                      );
                    },
                    label: const Text('Iniciar...'),
                    icon: const Icon(Icons.login),
                    style: const ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
