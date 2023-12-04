import 'package:flutter/material.dart';
import 'package:navbrasil_spat/commom/mycolors.dart';
import 'package:navbrasil_spat/models/equipment_model.dart';
import 'package:navbrasil_spat/repositories/equipment_repository.dart';
import 'package:navbrasil_spat/screens/qrcode_page.dart';

class SectorPage extends StatefulWidget {
  final EquipmentRepository repo;
  const SectorPage({Key? key, required this.repo}) : super(key: key);

  @override
  State<SectorPage> createState() => _SectorPageState();
}

class _SectorPageState extends State<SectorPage> {
  late List<Equipment> listEquipment;
  late List<String> listSectors;
  bool loadingStatus = false;

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
  void initState(){
    super.initState();
    listSectors = widget.repo.getListSectors();
    listEquipment = widget.repo.getListEquipment();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, MyColors.baseBackground],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
              final sector = listSectors[index];
              return Card(
                child: ListTile(
                  title: Text(sector),
                  splashColor: MyColors.navLightBlue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QRCodePage(
                            sector: sector, equipmentsList: listEquipment),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
