import 'package:batevolta/controllers/home.controller.dart';
import 'package:batevolta/core/colors.dart';
import 'package:batevolta/models/endereco_google.model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_crise/components/button.component.dart';
import 'package:flutter_crise/components/search.component.dart';
import 'package:flutter_crise/components/text.component.dart';
import 'package:get/get.dart';

class PesquisaEnderecoModal extends StatefulWidget {
  const PesquisaEnderecoModal({super.key});

  @override
  State<PesquisaEnderecoModal> createState() => _PesquisaEnderecoModalState();
}

class _PesquisaEnderecoModalState extends State<PesquisaEnderecoModal> {
  HomeController ctrl = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height: 50),
          Card(
              color: Colors.white,
              elevation: 0,
              child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 5, right: 5),
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: SearchComponent(
                              labelText: 'Local de partida',
                              accentColor: Colors.grey[500],
                              textEditingController: ctrl.editPesquisaPartida,
                              onChanged: (value) async {
                                ctrl.tipoPesquisa = 'PARTIDA';
                                if (value.length > 8) {
                                  await ctrl.getAddressPartida();
                                } else {
                                  ctrl.enderecosEvent.value.clear();
                                }
                              },
                              prefixIconData: Icons.location_pin,
                              hintText: 'Inserir local de partida...',
                              borderRadius: 0,
                              verticalPadding: 10)),
                      const SizedBox(height: 10),
                      Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: SearchComponent(
                              labelText: 'Para onde?',
                              accentColor: Colors.grey[500],
                              textEditingController: ctrl.editPesquisaDestino,
                              onChanged: (value) async {
                                ctrl.tipoPesquisa = 'DESTINO';
                                if (value.length > 8) {
                                  await ctrl.getAddressDestino();
                                } else {
                                  ctrl.enderecosEvent.value.clear();
                                }
                              },
                              prefixIconData: Icons.location_pin,
                              hintText: 'Inserir local de destino...',
                              borderRadius: 0,
                              verticalPadding: 10)),
                      Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: ButtonComponent(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              label: 'Buscar motorista',
                              borderRadius: 32,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5))),
                    ],
                  ))),
          const SizedBox(height: 5),
          ValueListenableBuilder(
            valueListenable: ctrl.enderecosEvent,
            builder: (context, List<AddressGoogleMaps> listResults, child) {
              if (listResults.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: SizedBox(
                    height: 400,
                    child: ListView.builder(
                      itemCount: listResults.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        AddressGoogleMaps address = listResults[index];
                        return InkWell(
                            onTap: () {
                              switch (ctrl.tipoPesquisa) {
                                case 'PARTIDA':
                                  ctrl.localPartida = address;
                                  ctrl.editPesquisaPartida.text =
                                      address.formattedAddress;
                                  ctrl.editPesquisaPartida.selection =
                                      TextSelection.fromPosition(
                                          TextPosition(offset: 0));
                                  break;
                                case 'DESTINO':
                                  ctrl.localDestino = address;
                                  ctrl.editPesquisaDestino.text =
                                      address.formattedAddress;
                                  ctrl.editPesquisaDestino.selection =
                                      TextSelection.fromPosition(
                                          TextPosition(offset: 0));

                                  break;
                              }
                              ctrl.enderecosEvent.value = [];
                              ctrl.update();
                            },
                            child: Card(
                              margin: const EdgeInsets.only(bottom: 1),
                              elevation: 0,
                              shadowColor: AppColor.primary,
                              child: SizedBox(
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.location_pin),
                                        const SizedBox(width: 3),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start, // Alinha à esquerda
                                          mainAxisAlignment: MainAxisAlignment
                                              .center, // Centraliza verticalmente
                                          children: [
                                            TextComponent(
                                              textAlign: TextAlign.start,
                                              value: (address.formattedAddress
                                                          .toString()
                                                          .length >
                                                      40
                                                  ? '${address.formattedAddress.toString().substring(0, 40)}...'
                                                  : address.formattedAddress
                                                      .toString()),
                                            ),
                                            TextComponent(
                                              color: Colors.grey[300],
                                              textAlign: TextAlign.start,
                                              value: address.neighborhood
                                                      ?.toString() ??
                                                  '',
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Icon(Icons.arrow_forward_ios_rounded),
                                  ],
                                ),
                              ),
                            ));
                      },
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          )
        ],
      )),
    ));
  }
}
