import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final http.Client client;

  ApiService({required this.client});

  Future<List<dynamic>> fetchProducts() async {
    final response = await client.get(
      Uri.parse('https://dummyjson.com/products'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['products']; // List of products
    } else {
      throw Exception('Failed to load products');
    }
  }
}
