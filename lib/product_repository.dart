// lib/product_repository.dart
import 'api_service.dart';

class ProductRepository {
  final ApiService apiService;

  ProductRepository(this.apiService);

  Future<List<dynamic>> getAllProducts() async {
    return await apiService.fetchProducts();
  }
}
