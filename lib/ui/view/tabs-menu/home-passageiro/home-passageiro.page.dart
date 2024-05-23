import 'package:batevolta/controllers/home.controller.dart';
import 'package:batevolta/core/colors.dart';
import 'package:batevolta/core/fonts/fonts.dart';
import 'package:batevolta/ui/view/tabs-menu/home-passageiro/widgets/maps.dart';
import 'package:batevolta/ui/view/tabs-menu/home-passageiro/widgets/pesquisa_endereco.modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crise/components/button.component.dart';
import 'package:flutter_crise/components/search.component.dart';
import 'package:flutter_crise/components/tabs.component.dart';
import 'package:flutter_crise/components/text.component.dart';
import 'package:get/get.dart';

import '../../../../services/permissions.service.dart';

class HomePassageiroPage extends GetView {
  HomeController ctrl = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    Get.find<PermissionsService>().requestPermissions();
    ctrl.getCurrentLocation();
    return GetBuilder<HomeController>(
        init: ctrl,
        builder: (_) {
          return SafeArea(
              child: Scaffold(
                  backgroundColor: Colors.white,
                  body: SafeArea(
                      child: SingleChildScrollView(
                    child: Column(children: [
                      ValueListenableBuilder(
                          valueListenable: ctrl.locationEnabled,
                          builder: (context, bool enabled, child) {
                            if (enabled == false) {
                              return Container(
                                  color: AppColor.warning,
                                  height: 60,
                                  child: Row(
                                    children: [
                                      const Icon(Icons.location_pin),
                                      const SizedBox(width: 4),
                                      Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextComponent(
                                                value:
                                                    'Compartilhamento de localização desativado.',
                                                fontSize: 12,
                                              ),
                                              TextComponent(
                                                  value:
                                                      'Toque aqui para ativar...',
                                                  fontSize: 12),
                                            ],
                                          )),
                                      const SizedBox(width: 4),
                                      const Icon(Icons.arrow_forward)
                                    ],
                                  ));
                            } else {
                              return Container();
                            }
                          }),
                      TabsComponent(
                          fontSize: 16,
                          colorTab: Colors.black,
                          titlesTabs: ['Transporte urbano', 'Viagens'],
                          contentTabs: [
                            buildTransporteUrbanoScreen(context),
                            buildViagensScreen()
                          ],
                          onChangeIndex: (index) {},
                          onChangeTitle: (index) {})
                    ]),
                  ))));
        });
  }

  Widget buildTransporteUrbanoScreen(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: SearchComponent(
                onChanged: (value) async {
                  if (value.isNotEmpty) {
                    ctrl.enderecosEvent.value.clear();
                    ctrl.editPesquisaPartida.clear();
                    ctrl.editPesquisaDestino.clear();
                    ctrl.update();
                    await showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return const PesquisaEnderecoModal();
                      },
                    );
                  }
                },
                prefixIconData: Icons.search,
                hintText: 'Inserir local de partida...',
                borderRadius: 32,
                verticalPadding: 10)),
        const SizedBox(height: 5),
        const SizedBox(
          height: 450,
          child: MapsComponent(),
        ),
      ],
    );
  }

  Widget buildViagensScreen() {
    return Container();
  }
}
