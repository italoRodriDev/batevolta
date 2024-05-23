import 'package:batevolta/data/providers/google.provider.dart';

class GoogleRepository {
  final GoogleApiClient api = GoogleApiClient();

  getAddress(textQuery) async {
    return await api.getAddress(textQuery);
  }
}
