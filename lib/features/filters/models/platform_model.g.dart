// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlatformModel _$PlatformModelFromJson(Map<String, dynamic> json) =>
    PlatformModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$PlatformModelToJson(PlatformModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

PlatformListResponse _$PlatformListResponseFromJson(
        Map<String, dynamic> json) =>
    PlatformListResponse(
      results: (json['results'] as List<dynamic>)
          .map((e) => PlatformModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlatformListResponseToJson(
        PlatformListResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
