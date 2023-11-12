import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navbrasil_spat/screens/sector_page.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  bool loadingStatus = false;
  List<List<dynamic>> data = [];

  void loadCSV() async {
    final rawData = await rootBundle.loadString('assets/data.CSV');
    List<List<dynamic>> listData =
        const CsvToListConverter(fieldDelimiter: ';').convert(rawData);
    data = listData;

    setState(() {
      loadingStatus = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    !loadingStatus ? loadCSV() : null;

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
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            const Divider(),
            const Text(
              'Carregando banco de dados...',
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: !loadingStatus
                  ? null
                  : () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SectorPage(),
                          settings: RouteSettings(arguments: data),
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
