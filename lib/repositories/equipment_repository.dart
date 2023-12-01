import 'dart:io' as io;

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navbrasil_spat/models/equipment_model.dart';
import 'package:path_provider/path_provider.dart';

class EquipmentRepository {
  static bool dataLoaded = false;
  static List<List<dynamic>> listData = [];
  late List<Equipment> listEquipment = [];
  static List<String> listSectors = [];

  EquipmentRepository() {
    loadCSV();
  }

  bool getDataLoaded() {
    return dataLoaded;
  }

  List<List<dynamic>> getListData() {
    return listData;
  }

  List<Equipment> getListEquipment() {
    return listEquipment;
  }

  List<String> getListSectors() {
    return listSectors;
  }

  loadCSV() async {
    final rawData = await rootBundle.loadString('assets/data.CSV');
    listData = const CsvToListConverter(fieldDelimiter: ';').convert(rawData);
    if (listData != []) {
      debugPrint('Dados Carregados!');
      dataLoaded = true;

      for (var i in listData) {
        listEquipment.add(Equipment(
            id: i[1].toString(),
            image: (i[2] == "") ? "assets/images/nophoto.jpg" : i[2].toString(),
            name: i[6].toString(),
            description: i[13],
            location: (i[8] == "") ? "INDEFINIDO" : i[8].toString(),
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
    } else {
      debugPrint('Problema no carregamento de Dados!');
    }

    final directory = await getExternalStorageDirectory();
    final targetPath = directory?.path;

    for (Equipment equip in listEquipment) {
      String targetImage = '$targetPath/${equip.id}.jpg';
      if (await io.File(targetImage).exists()) {
        equip.image = targetImage;
        debugPrint(equip.image);
      }
    }
  }
}
