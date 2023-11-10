import 'package:flutter/material.dart';
import 'package:navbrasil_spat/models/sector.dart';
import 'package:navbrasil_spat/screens/qrcode_page.dart';

class SectorPage extends StatefulWidget {
  const SectorPage({super.key});

  @override
  State<SectorPage> createState() => _SectorPageState();
}

class _SectorPageState extends State<SectorPage> {
  final List<Sector> listSector = [
    Sector(id: '1', name: 'Estação Rádio', locate: 'DNKG'),
    Sector(id: '2', name: 'EMS', locate: 'DNKG'),
    Sector(id: '3', name: 'Administração', locate: 'DNKG'),
    Sector(id: '4', name: 'KT', locate: 'DNKG'),
    Sector(id: '5', name: 'Depósito', locate: 'DNKG'),
    Sector(id: '6', name: 'Sala Reunião', locate: 'DNKG'),
    Sector(id: '7', name: 'Sala de Descanso', locate: 'DNKG'),
    Sector(id: '8', name: 'Copa', locate: 'DNKG'),
    Sector(id: '9', name: 'Chefia', locate: 'DNKG'),
    Sector(id: '10', name: 'Banheiros', locate: 'DNKG'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NAV Brasil - SETORES',
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(
            listSector.length,
            (index) {
              final item = listSector[index];
              return ListTile(
                title: Text(item.name),
                splashColor: Colors.blueGrey,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QRCodePage(),
                      settings: RouteSettings(arguments: item.name),
                    ),
                  );
                },
              );
            },
          ),
          // ElevatedButton(
          //   onPressed: () {},
          //   child: const Text('nav'),
          // ),
        ),
      ),
    );
  }
}
