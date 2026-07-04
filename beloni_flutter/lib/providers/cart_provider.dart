import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';

class CartItem extends ProductModel {
  final int cartQuantity;

  CartItem({
    required ProductModel product,
    this.cartQuantity = 1,
  }) : super(
          id: product.id,
          name: product.name,
          price: product.price,
          rating: product.rating,
          image: product.image,
          images: product.images,
          sizes: product.sizes,
          size: product.size,
          colors: product.colors,
          color: product.color,
          description: product.description,
          category: product.category,
          isBestseller: product.isBestseller,
          isFeatured: product.isFeatured,
          isSale: product.isSale,
          isOutOfStock: product.isOutOfStock,
          oldPrice: product.oldPrice,
          quantity: product.quantity,
          reviews: product.reviews,
        );

  CartItem copyWithQuantity(int newQuantity) {
    return CartItem(product: this, cartQuantity: newQuantity);
  }
}

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(ProductModel product) {
    final index = state.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index) state[i].copyWithQuantity(state[i].cartQuantity + 1) else state[i]
      ];
    } else {
      state = [...state, CartItem(product: product)];
    }
  }

  void removeFromCart(ProductModel product) {
    final index = state.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      if (state[index].cartQuantity > 1) {
        state = [
          for (int i = 0; i < state.length; i++)
            if (i == index) state[i].copyWithQuantity(state[i].cartQuantity - 1) else state[i]
        ];
      } else {
        state = state.where((item) => item.id != product.id).toList();
      }
    }
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) => CartNotifier());
