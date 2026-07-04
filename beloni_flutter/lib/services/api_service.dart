import 'package:dio/dio.dart';
import '../models/product_model.dart';
import '../core/theme/app_colors.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppColors.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _dio.get('products.json');
      if (response.statusCode == 200) {
        final List<dynamic> productsJson = response.data['products'];
        return productsJson.map((json) => ProductModel.fromJson(json)).toList();
      }
      throw Exception('Failed to load products');
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
