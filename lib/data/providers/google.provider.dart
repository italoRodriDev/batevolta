import 'dart:async';
import 'dart:io';

import 'package:get/get_connect/connect.dart';

class GoogleApiClient extends GetConnect {
  Future<dynamic> getHeaders() async {
    return {'Content-Type': 'application/json', 'accept': '*/*'};
  }

  Future<Response> getAddress(String textQuery) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$textQuery&key=${'AIzaSyCg3OzrK3B0QG0IYQfVINorD5ldpC431cI'}';

    try {
      return await get(url, headers: await getHeaders());
    } catch (e) {
      if (e is SocketException) {
        return const Response(statusCode: 1500);
      } else if (e is TimeoutException) {
        return const Response(statusCode: 1501);
      } else {
        return const Response(statusCode: 1502);
      }
    }
  }
}
