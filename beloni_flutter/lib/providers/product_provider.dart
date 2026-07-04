import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';
import '../models/product_model.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final productsProvider = FutureProvider<List<ProductModel>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getProducts();
});
