import 'package:haidar_ppkd/tugas/day_32/tugas14.dart/model/fakestore.dart';
import 'package:http/http.dart' as http;

class ApiServicefake {
  final String baseUrl = "https://fakestoreapi.com/products";

  Future<List<ListStore>> getProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return listStoreFromJson(response.body);
    } else {
      throw Exception('Gagal memuat data produk');
    }
  }
}
