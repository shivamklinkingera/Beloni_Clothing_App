// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  price: (json['price'] as num).toDouble(),
  rating: (json['rating'] as num).toDouble(),
  image: json['image'] as String,
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  sizes: (json['sizes'] as List<dynamic>).map((e) => e as String).toList(),
  size: json['size'] as String,
  colors: (json['colors'] as List<dynamic>).map((e) => e as String).toList(),
  color: json['color'] as String,
  description: json['description'] as String,
  category: json['category'] as String,
  isBestseller: json['is_bestseller'] as bool,
  isFeatured: json['is_featured'] as bool,
  isSale: json['is_sale'] as bool,
  isOutOfStock: json['is_out_of_stock'] as bool,
  oldPrice: (json['old_price'] as num?)?.toDouble(),
  quantity: (json['quantity'] as num?)?.toInt(),
  reviews: (json['reviews'] as List<dynamic>)
      .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'rating': instance.rating,
      'image': instance.image,
      'images': instance.images,
      'sizes': instance.sizes,
      'size': instance.size,
      'colors': instance.colors,
      'color': instance.color,
      'description': instance.description,
      'category': instance.category,
      'is_bestseller': instance.isBestseller,
      'is_featured': instance.isFeatured,
      'is_sale': instance.isSale,
      'is_out_of_stock': instance.isOutOfStock,
      'old_price': instance.oldPrice,
      'quantity': instance.quantity,
      'reviews': instance.reviews,
    };
