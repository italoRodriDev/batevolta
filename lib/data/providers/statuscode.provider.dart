import 'package:get/get.dart';

class AuthStatusCode {
  // -> Validando respostas da api
  static getStatus(Response res, Function success, Function error) {
    try {
      var message = 'Aguadando resposta...';
      switch (res.statusCode) {
        case 200:
          success(message);
          break;
        case 202:
          var msg = res.body['message'].toString();
          if (msg.isNotEmpty) {
            message = msg;
          }
          success(message);
          break;
        case 206:
          var msg = res.body['message'].toString();
          if (msg.isNotEmpty) {
            message = msg;
          }
          success(message);
          break;
        case 400:
          message = 'Ops! seus dados estão incorretos!.';
          error(message);
          break;
        case 401:
          message = 'Sua conta foi deslogada!.';
          error(message);
          break;
        case 500:
          message =
              'O servidor encontrou uma situação com a qual não sabe lidar.';
          error(message);
          break;
        case 503:
          message = 'Servidor em manutenção ou sobrecarregado. status: 503';
          error(message);
          break;
        case 403:
          // -> Fora do horário de atendimento
          message = res.body['message'].toString();
          error(message);
          break;
        default:
          if (res.statusCode != null) {
            message = 'Algo saiu errado! Erro: ' + res.statusCode.toString();
          } else {
            message = 'Erro: ' + res.statusText.toString();
          }
          error(message);
      }
    } catch (e) {}
  }
}
