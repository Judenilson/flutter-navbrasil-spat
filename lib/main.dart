import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:navbrasil_spat/configs/hive_config.dart';
import 'package:navbrasil_spat/screens/data_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Este comando é para inicializar widgets antes da MainApp

  //iniciando Hive
  await HiveConfig.start();
  await Hive.openBox('equipment_Box');
  await Hive.openBox('sector_Box');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NAV Brasil SPAT',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        fontFamily: 'LeagueSpartan',
        useMaterial3: true,
        // brightness: Brightness.dark,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      // themeMode: ThemeMode.dark,
      home: const DataPage(),
    );
  }
}
