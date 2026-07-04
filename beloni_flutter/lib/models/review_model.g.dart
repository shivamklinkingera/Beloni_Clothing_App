// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  rating: (json['rating'] as num).toDouble(),
  comment: json['comment'] as String,
  image: json['image'] as String,
  date: json['date'] as String,
);

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rating': instance.rating,
      'comment': instance.comment,
      'image': instance.image,
      'date': instance.date,
    };
