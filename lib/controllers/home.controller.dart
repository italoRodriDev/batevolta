import 'package:batevolta/data/providers/statuscode.provider.dart';
import 'package:batevolta/data/repository/google.repository.dart';
import 'package:batevolta/models/endereco_google.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crise/components/snackbar.component.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  late Position currentPosition;
  ValueNotifier<bool> locationEnabled = ValueNotifier<bool>(false);
  ValueNotifier<String> locationEvent = ValueNotifier<String>('INIT');
  List<AddressGoogleMaps> markers = [];

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

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      locationEnabled.value = false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        locationEnabled.value = false;
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      locationEnabled.value = false;
      return;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      currentPosition = value;
      locationEnabled.value = true;
      print(currentPosition.latitude);
      print(currentPosition.longitude);
    });
  }
}
