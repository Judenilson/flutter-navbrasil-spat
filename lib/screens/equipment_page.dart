import 'package:flutter/material.dart';
import 'package:navbrasil_spat/commom/mycolors.dart';
import 'package:navbrasil_spat/models/equipment.dart';

class EquipmentPage extends StatefulWidget {
  const EquipmentPage({super.key});

  @override
  State<EquipmentPage> createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {
  void verifiedStatus(Equipment equipment) {
    (equipment.state == "OK") ? equipment.state = "" : equipment.state = "OK";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Equipment equipment =
        ModalRoute.of(context)!.settings.arguments as Equipment;

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
                'EQUIPAMENTO',
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
        body: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: Colors.black12),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  equipment.image,
                ),
              ),
              Container(
                height: 20,
              ),
              Text(
                equipment.name,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
              ),
              const Divider(),
              Text(
                'Patrimônio: ${equipment.id}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const Divider(),
              Text(
                'Localização: ${equipment.location}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.right,
              ),
              const Divider(),
              Text(
                'Observações: ${equipment.description}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.right,
              ),
              const Spacer(),
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.settings),
                    label: const Text('Editar'),
                    style: const ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      verifiedStatus(equipment);
                    },
                    icon: const Icon(Icons.check_circle),
                    label: (equipment.state == "OK")
                        ? const Text('Perder')
                        : const Text('Verificar'),
                    style: ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(
                          (equipment.state == "OK")
                              ? MyColors.mediumRed
                              : MyColors.navGreen),
                    ),
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.verified,
                        color: (equipment.state == "OK")
                            ? MyColors.navLightGreen
                            : MyColors.mediumRed,
                        size: 48,
                      ),
                      (equipment.state != "OK")
                          ? const Text(
                              "Não Localizado",
                              style: TextStyle(
                                  fontSize: 10, color: MyColors.mediumRed),
                            )
                          : const Text(
                              "Verificado",
                              style: TextStyle(
                                  fontSize: 10, color: MyColors.navLightGreen),
                            ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
