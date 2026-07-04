import 'package:json_annotation/json_annotation.dart';
import 'review_model.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final int id;
  final String name;
  final double price;
  final double rating;
  final String image;
  final List<String> images;
  final List<String> sizes;
  final String? size;
  final List<String> colors;
  final String? color;
  final String description;
  final String? category;
  @JsonKey(name: 'is_bestseller', defaultValue: false)
  final bool isBestseller;
  @JsonKey(name: 'is_featured', defaultValue: false)
  final bool isFeatured;
  @JsonKey(name: 'is_sale', defaultValue: false)
  final bool isSale;
  @JsonKey(name: 'is_out_of_stock', defaultValue: false)
  final bool isOutOfStock;
  @JsonKey(name: 'old_price')
  final double? oldPrice;
  final int? quantity;
  final List<ReviewModel> reviews;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.image,
    required this.images,
    required this.sizes,
    this.size,
    required this.colors,
    this.color,
    required this.description,
    this.category,
    this.isBestseller = false,
    this.isFeatured = false,
    this.isSale = false,
    this.isOutOfStock = false,
    this.oldPrice,
    this.quantity,
    required this.reviews,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
