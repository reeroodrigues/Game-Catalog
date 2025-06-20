import 'package:json_annotation/json_annotation.dart';

part 'platform_model.g.dart';

@JsonSerializable()
class PlatformModel {
  final int id;
  final String name;

  PlatformModel({required this.id, required this.name});

  factory PlatformModel.fromJson(Map<String, dynamic> json) =>
      _$PlatformModelFromJson(json);
  Map<String, dynamic> toJson() => _$PlatformModelToJson(this);
}

@JsonSerializable()
class PlatformListResponse {
  final List<PlatformModel> results;

  PlatformListResponse({required this.results});

  factory PlatformListResponse.fromJson(Map<String, dynamic> json) =>
      _$PlatformListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PlatformListResponseToJson(this);
}
