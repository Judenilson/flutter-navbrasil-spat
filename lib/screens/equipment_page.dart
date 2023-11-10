import 'package:flutter/material.dart';

class EquipmentPage extends StatefulWidget {
  const EquipmentPage({super.key});

  @override
  State<EquipmentPage> createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Column(
            children: [
              const Text(
                'NAV Brasil - SPAT',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Text(
                'Rádio',
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
        Image.asset(
          'assets/images/img1.jpg',
        ),
        const Text("text"),
      ],
    );
  }
}
