import 'package:flutter/material.dart';
// import 'package:navbrasil_spat/screens/equipment_page.dart';
// import 'package:navbrasil_spat/screens/qrcode_page.dart';
import 'package:navbrasil_spat/screens/sector_page.dart';

void main() {
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
        // elevatedButtonTheme: ElevatedButtonThemeData(
        //   style: ElevatedButton.styleFrom(
        //     // foregroundColor: Colors.black,
        //     // backgroundColor: Colors.lightGreenAccent[400],
        //     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 36),
        //     textStyle:
        //         const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        //   ),
        // ),
      ),
      // themeMode: ThemeMode.dark,
      home: const SectorPage(),
    );
  }
}
