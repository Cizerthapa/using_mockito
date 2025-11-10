import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mockito_test/api_service.dart';
import 'package:mockito_test/product_repository.dart';
import 'product_repository_test.mocks.dart';

void main() {
  late MockClient mockClient;
  late ApiService apiService;
  late ProductRepository productRepository;

  setUp(() {
    mockClient = MockClient();
    apiService = ApiService(client: mockClient);
    productRepository = ProductRepository(apiService);
  });

  test('fetches products successfully from dummyjson', () async {
    // Mock JSON response similar to what DummyJSON returns
    final mockResponse = {
      "products": [
        {"id": 1, "title": "iPhone 9"},
        {"id": 2, "title": "iPhone X"},
      ],
    };

    // Arrange: Mock the HTTP call
    when(
      mockClient.get(Uri.parse('https://dummyjson.com/products')),
    ).thenAnswer((_) async => http.Response(jsonEncode(mockResponse), 200));

    // Act: Call the repository method
    final result = await productRepository.getAllProducts();

    // Assert: Verify and check result
    expect(result.length, 2);
    expect(result[0]['title'], equals('iPhone 9'));
    verify(
      mockClient.get(Uri.parse('https://dummyjson.com/products')),
    ).called(1);
  });

  test('throws exception when API fails', () async {
    when(
      mockClient.get(Uri.parse('https://dummyjson.com/products')),
    ).thenAnswer((_) async => http.Response('Not Found', 404));

    expect(() => productRepository.getAllProducts(), throwsException);
  });
}
