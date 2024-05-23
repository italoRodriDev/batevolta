import 'package:batevolta/data/providers/statuscode.provider.dart';
import 'package:batevolta/data/repository/google.repository.dart';
import 'package:batevolta/models/endereco_google.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crise/components/snackbar.component.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late BuildContext context;
  ValueNotifier<List<AddressGoogleMaps>> enderecosEvent =
      ValueNotifier<List<AddressGoogleMaps>>([]);
  GoogleRepository googleRepo = GoogleRepository();
  TextEditingController editPesquisaPartida = TextEditingController();
  TextEditingController editPesquisaDestino = TextEditingController();
  late AddressGoogleMaps localPartida;
  late AddressGoogleMaps localDestino;
  String tipoPesquisa = 'PARTIDA';

  getAddressPartida() async {
    if (editPesquisaPartida.text.length > 8) {
      Response res = await googleRepo.getAddress(editPesquisaPartida.text);
      AuthStatusCode.getStatus(res, (success) async {
        List<AddressGoogleMaps> list = [];
        for (var i in res.body['results']) {
          list.add(AddressGoogleMaps.fromJson(i));
        }
        enderecosEvent.value = list;
      }, (error) async {
        await SnackbarComponent.show(context, text: 'Erro: ${res.statusCode}');
      });
    }
  }

  getAddressDestino() async {
    if (editPesquisaDestino.text.length > 8) {
      Response res = await googleRepo.getAddress(editPesquisaDestino.text);
      AuthStatusCode.getStatus(res, (success) async {
        List<AddressGoogleMaps> list = [];
        for (var i in res.body['results']) {
          list.add(AddressGoogleMaps.fromJson(i));
        }
        enderecosEvent.value = list;
      }, (error) async {
        await SnackbarComponent.show(context, text: 'Erro: ${res.statusCode}');
      });
    }
  }
}
