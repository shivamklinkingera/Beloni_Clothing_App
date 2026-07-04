// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) => BannerModel(
  id: (json['id'] as num).toInt(),
  image: json['image'] as String,
  title: json['title'] as String?,
  title1: json['title1'] as String?,
  title2: json['title2'] as String?,
  description1: json['description1'] as String?,
  description2: json['description2'] as String?,
  btnText: json['btnText'] as String,
);

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'title': instance.title,
      'title1': instance.title1,
      'title2': instance.title2,
      'description1': instance.description1,
      'description2': instance.description2,
      'btnText': instance.btnText,
    };
