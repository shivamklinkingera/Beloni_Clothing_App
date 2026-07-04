import 'package:json_annotation/json_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel {
  final int id;
  final String name;
  final double rating;
  final String comment;
  final String image;
  final String date;

  ReviewModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.comment,
    required this.image,
    required this.date,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => _$ReviewModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}
