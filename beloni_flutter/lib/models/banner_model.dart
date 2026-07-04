import 'package:json_annotation/json_annotation.dart';

part 'banner_model.g.dart';

@JsonSerializable()
class BannerModel {
  final int id;
  final String image;
  final String? title;
  final String? title1;
  final String? title2;
  final String? description1;
  final String? description2;
  final String btnText;

  BannerModel({
    required this.id,
    required this.image,
    this.title,
    this.title1,
    this.title2,
    this.description1,
    this.description2,
    required this.btnText,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => _$BannerModelFromJson(json);
  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
