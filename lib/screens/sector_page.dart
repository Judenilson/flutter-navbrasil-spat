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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              'NAV Brasil',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              'Sistema de Patrimônio',
              style: TextStyle(
                color: Colors.blueGrey[900],
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QRCodePage()),
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
