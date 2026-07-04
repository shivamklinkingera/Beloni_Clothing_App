import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';

class WishlistNotifier extends StateNotifier<List<ProductModel>> {
  WishlistNotifier() : super([]);

  void toggleWishlist(ProductModel product) {
    if (state.any((item) => item.id == product.id)) {
      state = state.where((item) => item.id != product.id).toList();
    } else {
      state = [...state, product];
    }
  }
}

final wishlistProvider = StateNotifierProvider<WishlistNotifier, List<ProductModel>>((ref) => WishlistNotifier());
