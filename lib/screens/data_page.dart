import 'package:flutter/material.dart';
import 'package:navbrasil_spat/screens/sector_page.dart';

class DataPage extends StatelessWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const Divider(),
            const Text(
              'Carregando banco de dados...',
              style: TextStyle(fontSize: 12),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SectorPage(),
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
